const assert = require('node:assert/strict')
const { createHash } = require('node:crypto')
const fs = require('node:fs')
const path = require('node:path')
const { spawn } = require('node:child_process')
const { setTimeout: sleep } = require('node:timers/promises')
const { once } = require('node:events')
const mc = require('minecraft-protocol')

const jarHash = '64bb6d763bed0a9f1d632ec347938594144943ed'
const jarUrl = 'https://piston-data.mojang.com/v1/objects/' + jarHash + '/server.jar'
const image = 'eclipse-temurin@sha256:18bb4a91a3dea3f03ee31d3755af34dfb40f904fc77ab56cdc2f092e32fff9c2'
const username = 'GolemTerrain'
const maxChunk = 1874998

function atomicWrite (file, bytes) {
  const temporary = file + '.new'
  fs.writeFileSync(temporary, bytes)
  fs.renameSync(temporary, file)
}

async function runDocker (args) {
  const child = spawn('docker', args, { stdio: ['ignore', 'pipe', 'pipe'] })
  let stdout = ''
  let stderr = ''
  child.stdout.on('data', data => { stdout += data })
  child.stderr.on('data', data => { stderr += data })
  const [code] = await once(child, 'close')
  if (code !== 0) throw new Error('Docker ' + args[0] + ' failed: ' + stderr.trim())
  return stdout.trim()
}

async function getJar (directory, jarPath) {
  const filename = jarPath || path.join(directory, 'server.jar')
  if (!fs.existsSync(filename) && !jarPath) {
    console.log('Downloading Mojang Minecraft Java 1.21.11 server')
    const response = await fetch(jarUrl, { signal: AbortSignal.timeout(120000) })
    if (!response.ok) throw new Error('Mojang download returned HTTP ' + response.status)
    const bytes = Buffer.from(await response.arrayBuffer())
    assert.equal(createHash('sha1').update(bytes).digest('hex'), jarHash, 'Unexpected server JAR checksum')
    atomicWrite(filename, bytes)
  }
  assert.equal(createHash('sha1').update(fs.readFileSync(filename)).digest('hex'), jarHash, 'Supply the official Minecraft Java 1.21.11 server JAR')
  return path.resolve(filename)
}

async function launchVanilla (directory, seed, jarPath) {
  const jar = await getJar(directory, jarPath)
  const name = 'golemmc-vanilla-' + createHash('sha256').update(directory).digest('hex').slice(0, 12)
  const world = path.join(directory, 'vanilla')
  fs.mkdirSync(world, { recursive: true })
  const props = [
    'server-port=25565',
    'online-mode=false',
    'enforce-secure-profile=false',
    'network-compression-threshold=-1',
    'level-seed=' + seed,
    'level-type=minecraft:normal',
    'gamemode=spectator',
    'view-distance=5',
    'simulation-distance=3',
    'spawn-protection=0',
    'enable-rcon=false',
    'pause-when-empty-seconds=0',
    'spawn-monsters=false'
  ]
  atomicWrite(path.join(world, 'eula.txt'), 'eula=true\n')
  atomicWrite(path.join(world, 'server.properties'), props.join('\n') + '\n')
  const child = spawn('docker', [
    'run', '--rm', '-i', '--name', name, '--cpus', '3', '--memory', '3g',
    '-p', '127.0.0.1::25565',
    '--mount', 'type=bind,source=' + world + ',target=/work',
    '--mount', 'type=bind,source=' + jar + ',target=/server.jar,readonly',
    '-w', '/work', image, 'java', '-XX:ActiveProcessorCount=3', '-Xms512M', '-Xmx2G',
    '-jar', '/server.jar', 'nogui'
  ], { stdio: ['pipe', 'pipe', 'pipe'] })
  try {
    await new Promise((resolve, reject) => {
      const timer = setTimeout(() => reject(new Error('Vanilla startup timed out')), 180000)
      let tail = ''
      child.stdout.on('data', data => {
        tail = (tail + data).slice(-2048)
        if (tail.includes('For help, type "help"')) { clearTimeout(timer); resolve() }
      })
      child.stderr.on('data', data => process.stderr.write(data))
      child.once('error', error => { clearTimeout(timer); reject(error) })
      child.once('exit', code => {
        clearTimeout(timer)
        reject(new Error('Vanilla server exited (' + code + ')\n' + tail))
      })
    })
    const mapping = await runDocker(['port', name, '25565/tcp'])
    const port = Number(mapping.split(':').at(-1))
    assert.ok(Number.isInteger(port) && port > 0)
    return { child, port, name }
  } catch (error) {
    await stopVanilla({ child, name })
    throw error
  }
}

async function stopVanilla (vanilla) {
  if (vanilla.child.exitCode !== null || vanilla.child.signalCode !== null) return
  const exited = once(vanilla.child, 'exit').catch(() => {})
  vanilla.child.stdin.on('error', () => {})
  if (vanilla.child.stdin.writable) vanilla.child.stdin.write('stop\n')
  const timer = setTimeout(() => {
    runDocker(['stop', '-t', '5', vanilla.name]).catch(() => vanilla.child.kill())
  }, 15000)
  try { await exited } finally { clearTimeout(timer) }
}

function connectGenerator (port, seed, directory) {
  const seedBytes = Buffer.alloc(8)
  seedBytes.writeBigInt64LE(seed)
  const expectedHash = createHash('sha256').update(seedBytes).digest().readBigInt64LE()
  const client = mc.createClient({ host: '127.0.0.1', port, version: '1.21.11', username, auth: 'offline', keepAlive: false })
  const chunks = path.join(directory, 'chunks')
  let spawnPosition
  let verified = false
  let failure
  let connected = true
  let observed = 0
  let viewCenter
  let lastArrival = 0
  function ready () {
    if (!spawnPosition || !verified || !fs.existsSync(containingChunk(spawnPosition))) return false
    const metadata = path.join(directory, 'snapshot.txt')
    if (!fs.existsSync(metadata)) {
      atomicWrite(metadata, [774, seed, spawnPosition.x, spawnPosition.y, spawnPosition.z].join(' ') + '\n')
    }
    return true
  }
  function containingChunk (position) {
    return path.join(chunks, (position.x >> 4) + '.' + (position.z >> 4) + '.bin')
  }
  client.on('error', error => { failure = error })
  client.on('end', reason => {
    connected = false
    failure ??= new Error('Vanilla connection closed: ' + reason)
  })
  client.on('keep_alive', packet => client.write('keep_alive', { keepAliveId: packet.keepAliveId }))
  client.on('packet', (packet, meta, raw) => {
    if (failure) return
    try {
      if (meta.name === 'login') {
        assert.equal(packet.worldState.name, 'minecraft:overworld')
        assert.equal(BigInt(packet.worldState.hashedSeed), expectedHash, 'Vanilla worker has a different seed')
        verified = true
      } else if (meta.name === 'position') {
        client.write('teleport_confirm', { teleportId: packet.teleportId })
        client.write('player_loaded', {})
        client.write('position', { x: packet.x, y: packet.y, z: packet.z, flags: { onGround: false } })
        spawnPosition ??= { x: Math.floor(packet.x), y: Math.floor(packet.y), z: Math.floor(packet.z) }
      } else if (meta.name === 'update_view_position') {
        viewCenter = [packet.chunkX, packet.chunkZ]
      } else if (meta.name === 'chunk_batch_finished') {
        client.write('chunk_batch_received', { chunksPerTick: 32 })
      } else if (meta.name === 'map_chunk' && verified) {
        assert.equal(raw[0], 44)
        const output = path.join(chunks, packet.x + '.' + packet.z + '.bin')
        if (!fs.existsSync(output)) atomicWrite(output, raw.subarray(1))
        observed++
        lastArrival = Date.now()
      }
    } catch (error) { failure = error }
  })
  return {
    client, ready,
    status () { return { observed, viewCenter, lastArrival } },
    assertConnected () { if (!connected || failure) throw failure }
  }
}

async function generate (generator, directory, sendCommand, stopping) {
  const requests = path.join(directory, 'requests')
  const chunks = path.join(directory, 'chunks')
  for (let wait = 0; !generator.ready(); wait++) {
    generator.assertConnected()
    if (stopping()) return
    if (wait === 1200) throw new Error('Timed out waiting for the vanilla spawn chunk')
    await sleep(50)
  }
  console.log('Vanilla world generation ready in ' + directory)
  let waiting
  while (!stopping()) {
    generator.assertConnected()
    const status = generator.status()
    if (waiting) {
      const active = status.viewCenter?.[0] === waiting.x && status.viewCenter?.[1] === waiting.z
      const hadChunks = status.observed > waiting.before && Date.now() - status.lastArrival >= 250
      const ready = fs.existsSync(path.join(chunks, waiting.key + '.bin'))
      if (ready && active && hadChunks) waiting = undefined
      else if (Date.now() >= waiting.deadline) {
        if (!ready) console.error('Vanilla did not deliver chunk ' + waiting.key + '; retrying on the next request')
        waiting = undefined
      }
    }
    if (!waiting) {
      const files = []
      for (const request of fs.readdirSync(requests, { withFileTypes: true })) {
        const match = /^(-?\d+)\.(-?\d+)$/.exec(request.name)
        if (!request.isFile() || !match) continue
        const filename = path.join(requests, request.name)
        const cx = Number(match[1]); const cz = Number(match[2])
        if (Math.abs(cx) > maxChunk || Math.abs(cz) > maxChunk ||
            fs.existsSync(path.join(chunks, request.name + '.bin'))) {
          fs.rmSync(filename, { force: true })
        } else {
          const info = fs.statSync(filename, { throwIfNoEntry: false })
          if (info) files.push({ key: request.name, x: cx, z: cz, updated: info.mtimeMs })
        }
      }
      files.sort((a, b) => b.updated - a.updated)
      const request = files[0]
      if (request) {
        sendCommand('execute in minecraft:overworld run tp ' + username + ' ' + (request.x * 16 + 8) + ' 160 ' + (request.z * 16 + 8))
        waiting = { ...request, before: status.observed, deadline: Date.now() + 12000 }
      }
    }
    await sleep(75)
  }
}

async function main () {
  const [directoryArg, seedArg, acceptance, jarArg] = process.argv.slice(2)
  if (!directoryArg || !/^-?\d+$/.test(seedArg || '') || acceptance !== '--accept-eula') {
    throw new Error('Usage: node tools/vanilla-worldgen.cjs DIRECTORY SEED --accept-eula [SERVER_JAR]')
  }
  const directory = path.resolve(directoryArg)
  const seed = BigInt(seedArg)
  assert.equal(seed, BigInt.asIntN(64, seed), 'Seed must fit in a signed 64-bit integer')
  fs.mkdirSync(path.join(directory, 'chunks'), { recursive: true })
  fs.mkdirSync(path.join(directory, 'requests'), { recursive: true })
  const identity = path.join(directory, 'worldgen.txt')
  const expected = '774 ' + seed + '\n'
  if (fs.existsSync(identity)) {
    assert.equal(fs.readFileSync(identity, 'utf8'), expected, 'Use a separate generation directory for a different seed')
  } else {
    assert.ok(!fs.existsSync(path.join(directory, 'snapshot.txt')), 'Use a separate directory from a static snapshot')
    try { fs.writeFileSync(identity, expected, { flag: 'wx' }) } catch (error) {
      if (error.code !== 'EEXIST') throw error
      assert.equal(fs.readFileSync(identity, 'utf8'), expected, 'Use a separate generation directory for a different seed')
    }
  }

  let vanilla
  let generator
  let quitting = false
  for (const signal of ['SIGINT', 'SIGTERM']) process.once(signal, () => { quitting = true })
  try {
    vanilla = await launchVanilla(directory, seed, jarArg)
    if (quitting) return
    vanilla.child.stdin.write('gamerule minecraft:spectators_generate_chunks true\n')
    vanilla.child.stdin.write('gamerule minecraft:advance_time false\n')
    vanilla.child.stdin.write('gamerule minecraft:random_tick_speed 0\n')
    generator = connectGenerator(vanilla.port, seed, directory)
    await generate(generator, directory, command => vanilla.child.stdin.write(command + '\n'), () => quitting)
  } finally {
    if (generator?.client.socket) generator.client.socket.destroy()
    if (vanilla) await stopVanilla(vanilla)
  }
}

if (require.main === module) main().catch(error => {
  console.error(error.message)
  process.exitCode = 1
})

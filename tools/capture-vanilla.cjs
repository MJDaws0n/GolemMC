const assert = require('node:assert/strict')
const fs = require('node:fs')
const path = require('node:path')
const crypto = require('node:crypto')
const mc = require('minecraft-protocol')
const writeRegistryData = require('./registry-data.cjs')

const [directory, portArg, seedArg, radiusArg] = process.argv.slice(2)
if (!directory || !portArg || !/^-?\d+$/.test(seedArg || '')) {
  console.error('Usage: node tools/capture-vanilla.cjs NEW_DIRECTORY PORT SEED [RADIUS]')
  process.exit(2)
}
const port = Number(portArg)
const seed = BigInt(seedArg)
const radius = Number(radiusArg || 2)
assert.ok(Number.isInteger(port) && port >= 1 && port <= 65535)
assert.ok(Number.isInteger(radius) && radius >= 0 && radius <= 8)
assert.ok(seed === BigInt.asIntN(64, seed))

const seedBuffer = Buffer.alloc(8)
seedBuffer.writeBigInt64LE(seed)
const expectedHash = crypto.createHash('sha256').update(seedBuffer).digest().readBigInt64LE()
const output = path.resolve(directory)
if (fs.existsSync(output)) throw new Error('Output directory already exists: ' + output)
const temporary = fs.mkdtempSync(output + '.capture-')
const chunksDirectory = path.join(temporary, 'chunks')
fs.mkdirSync(chunksDirectory)
const configuration = []
const captured = new Set()
let position
let checkedSeed = false
let committed = false

const client = mc.createClient({ host: '127.0.0.1', port, username: 'GolemCapture', auth: 'offline', version: '1.21.11', keepAlive: false })
const timer = setTimeout(() => finish(new Error('Capture timed out. Use a fresh vanilla world and view-distance of at least radius + 1.')), 60000)

function frame (packet) {
  const prefix = []
  let remaining = packet.length
  while (remaining > 127) {
    prefix.push((remaining & 127) | 128)
    remaining >>>= 7
  }
  prefix.push(remaining)
  return Buffer.concat([Buffer.from(prefix), packet])
}

function finish (error) {
  clearTimeout(timer)
  if (committed) return
  if (error) {
    committed = true
    fs.rmSync(temporary, { recursive: true, force: true })
    client.end()
    console.error(error.message)
    process.exitCode = 1
    return
  }
  writeRegistryData(temporary)
  fs.writeFileSync(path.join(temporary, 'configuration-774.bin'), Buffer.concat(configuration))
  const { x, y, z } = position
  fs.writeFileSync(path.join(temporary, 'snapshot.txt'), [774, seed, x, y, z].join(' ') + '\n')
  fs.renameSync(temporary, output)
  committed = true
  client.end()
  console.log('Captured ' + captured.size + ' vanilla chunks for seed ' + seed + ' in ' + output)
}

client.on('error', finish)
client.on('end', reason => { if (!committed) finish(new Error('Disconnected during capture: ' + reason)) })
client.on('keep_alive', message => client.write('keep_alive', { keepAliveId: message.keepAliveId }))
client.on('packet', (message, metadata, raw) => {
  if (committed) return
  try {
    if (metadata.state === 'configuration' && ['registry_data', 'tags', 'feature_flags'].includes(metadata.name)) {
      configuration.push(frame(raw))
    } else if (metadata.name === 'login') {
      assert.equal(message.worldState.name, 'minecraft:overworld')
      assert.equal(BigInt(message.worldState.hashedSeed), expectedHash, 'The server seed does not match the requested seed')
      checkedSeed = true
    } else if (metadata.name === 'position') {
      assert.equal(message.flags._value, 0, 'Reference used a relative teleport')
      position = { x: Math.floor(message.x), y: Math.floor(message.y), z: Math.floor(message.z) }
      client.write('teleport_confirm', { teleportId: message.teleportId })
      client.write('player_loaded', {})
    } else if (metadata.name === 'chunk_batch_finished') {
      client.write('chunk_batch_received', { chunksPerTick: 64 })
    } else if (metadata.name === 'map_chunk' && position && checkedSeed) {
      if (Math.abs(message.x - (position.x >> 4)) > radius || Math.abs(message.z - (position.z >> 4)) > radius) return
      const key = message.x + '.' + message.z
      if (captured.has(key)) return
      assert.equal(raw[0], 44)
      fs.writeFileSync(path.join(chunksDirectory, key + '.bin'), raw.subarray(1))
      captured.add(key)
      if (captured.size === (radius * 2 + 1) ** 2) finish()
    }
  } catch (error) { finish(error) }
})

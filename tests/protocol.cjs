const assert = require('node:assert/strict')
const { once } = require('node:events')
const { test } = require('node:test')
const fs = require('node:fs')
const net = require('node:net')
const os = require('node:os')
const path = require('node:path')
const { spawn } = require('node:child_process')
const { setTimeout: delay } = require('node:timers/promises')
const { createRequire } = require('node:module')
const requireTool = createRequire(path.join(__dirname, '../tools/package.json'))
const mc = requireTool('minecraft-protocol')
const deserialize = mc.createDeserializer({ state: 'play', version: '1.21.11' })
const Chunk = requireTool('prismarine-chunk')('1.21.11')

const root = path.join(__dirname, '..')
const executable = process.env.GOLEM_BIN || path.join(root, 'build/darwin_arm64/GolemMC')

function packet (client, name, predicate = () => true) {
  return new Promise((resolve, reject) => {
    const timer = setTimeout(() => finish(new Error('Timed out waiting for ' + name)), 10000)
    function finish (error, data) {
      clearTimeout(timer)
      client.off(name, receive)
      client.off('error', finish)
      client.off('end', ended)
      if (error) reject(error)
      else resolve(data)
    }
    function ended (reason) { finish(new Error('Disconnected while waiting for ' + name + ' (' + reason + ')')) }
    function receive (data) { if (predicate(data)) finish(null, data) }
    client.on(name, receive)
    client.on('error', finish)
    client.on('end', ended)
  })
}

async function reservePort () {
  const socket = net.createServer()
  await new Promise(resolve => socket.listen(0, '127.0.0.1', resolve))
  const port = socket.address().port
  await new Promise(resolve => socket.close(resolve))
  return port
}

async function start (directory, extras = '') {
  const port = await reservePort()
  const properties = path.join(directory, 'server.properties')
  fs.writeFileSync(properties, 'server-port=' + port + '\nview-distance=2\n' +
    'motd=Testing "Golem" \\ status\nlevel-name=' + path.join(directory, 'world') + '\n' + extras)
  const process = spawn(executable, [properties], { cwd: root, stdio: ['pipe', 'pipe', 'pipe'] })
  let logs = ''
  process.stdout.on('data', chunk => { logs += chunk })
  process.stderr.on('data', chunk => { logs += chunk })
  for (let retry = 0; retry < 100; retry++) {
    if (logs.includes('is listening')) return { process, port, logs: () => logs }
    if (process.exitCode !== null || process.signalCode !== null) break
    await delay(20)
  }
  process.kill()
  throw new Error('Server startup failed: ' + logs)
}

async function disconnect (connection) {
  if (!connection || connection.ended) return
  const ended = new Promise(resolve => connection.once('end', resolve))
  connection.disconnecting = true
  connection.socket.destroy()
  await ended
}

async function stop (server) {
  if (!server || server.process.exitCode !== null || server.process.signalCode !== null) return
  const exited = once(server.process, 'exit')
  server.process.stdin.write('stop\n')
  const timer = setTimeout(() => server.process.kill(), 5000)
  try {
    const [code, signal] = await exited
    assert.equal(code, 0, 'Server exit ' + signal + '\n' + server.logs())
  } finally {
    clearTimeout(timer)
  }
}

function client (port, username) {
  const bot = mc.createClient({ host: '127.0.0.1', port, username, auth: 'offline', version: '1.21.11', keepAlive: false })
  bot.on('keep_alive', message => bot.write('keep_alive', { keepAliveId: message.keepAliveId }))
  bot.on('position', message => {
    bot.write('teleport_confirm', { teleportId: message.teleportId })
    bot.write('player_loaded', {})
  })
  bot.on('chunk_batch_finished', () => {
    if (!bot.disconnecting) bot.write('chunk_batch_received', { chunksPerTick: 16 })
  })
  return bot
}

function status (port) {
  return mc.ping({ host: '127.0.0.1', port, version: '1.21.11' })
}

function blockAt (message, x, y, z) {
  const chunk = new Chunk()
  chunk.load(message.chunkData)
  return chunk.getBlockStateId({ x, y, z })
}

async function sendFragmentedStatus (port) {
  const socket = net.createConnection(port, '127.0.0.1')
  await once(socket, 'connect')
  const host = Buffer.from('127.0.0.1')
  const handshake = Buffer.concat([Buffer.from([host.length + 7, 0, 0x86, 6, host.length]), host,
    Buffer.from([port >> 8, port & 255, 1]), Buffer.from([1, 0])])
  const reply = once(socket, 'data')
  for (const byte of handshake) {
    socket.write(Buffer.from([byte]))
    await delay(2)
  }
  const [data] = await reply
  assert.ok(data.includes(Buffer.from('"protocol":774')))
  socket.end()
}

test('status, concurrent play, movement, chat, chunk streaming, edits and restart', { timeout: 35000 }, async () => {
  const directory = fs.mkdtempSync(path.join(os.tmpdir(), 'golem-test-'))
  let server
  const clients = []
  try {
    server = await start(directory)
    assert.equal((await status(server.port)).description.text, 'Testing "Golem" \\ status')
    const contender = spawn(executable, [path.join(directory, 'server.properties')], { cwd: root })
    let rejection = ''
    contender.stdout.on('data', chunk => { rejection += chunk })
    assert.equal((await once(contender, 'close'))[0], 1)
    assert.match(rejection, /Cannot lock world/)
    await sendFragmentedStatus(server.port)

    const alice = client(server.port, 'Alice')
    clients.push(alice)
    const firstChunk = packet(alice, 'map_chunk', p => p.x === 0 && p.z === 0)
    const startPosition = await packet(alice, 'position')
    assert.equal(startPosition.y, -60)
    const generated = await firstChunk
    assert.equal(blockAt(generated, 1, -61, 0), 9)
    if (process.env.GOLEM_FLAT_SNAPSHOT) {
      const data = fs.readFileSync(path.join(path.resolve(root, process.env.GOLEM_FLAT_SNAPSHOT), 'chunks', '0.0.bin'))
      const reference = deserialize.parsePacketBuffer(Buffer.concat([Buffer.from([44]), data])).data.params
      const nativeChunk = new Chunk()
      const vanillaChunk = new Chunk()
      nativeChunk.load(generated.chunkData)
      vanillaChunk.load(reference.chunkData)
      for (let y = -64; y < 320; y++) {
        for (let z = 0; z < 16; z++) {
          for (let x = 0; x < 16; x++) {
            assert.equal(nativeChunk.getBlockStateId({ x, y, z }), vanillaChunk.getBlockStateId({ x, y, z }))
            assert.equal(nativeChunk.getBiome({ x, y, z }), vanillaChunk.getBiome({ x, y, z }))
          }
        }
      }
      assert.deepEqual(generated.heightmaps.map(h => [h.type, h.data.map(BigInt)]),
        reference.heightmaps.map(h => [h.type, h.data.map(BigInt)]))
      for (const property of ['skyLightMask', 'emptySkyLightMask', 'emptyBlockLightMask']) {
        assert.deepEqual(generated[property].map(BigInt), reference[property].map(BigInt))
      }
      assert.deepEqual(generated.skyLight, reference.skyLight)
    }

    const bob = client(server.port, 'Bob')
    clients.push(bob)
    const appears = packet(alice, 'spawn_entity')
    await packet(bob, 'position')
    const bobEntity = await appears
    assert.equal(bobEntity.type, 155)
    assert.equal((await status(server.port)).players.online, 2)
    const duplicate = client(server.port, 'Alice')
    clients.push(duplicate)
    assert.match((await packet(duplicate, 'disconnect')).reason, /username is already connected/)


    const moved = packet(alice, 'sync_entity_position', p => p.entityId === bobEntity.entityId && p.x === 2.75)
    bob.write('position', { x: 2.75, y: -60, z: 0.5, flags: { onGround: true } })
    await moved

    const response = packet(bob, 'system_chat', p => p.content.value === 'Seed: 0')
    bob.chat('/seed')
    await response

    const message = packet(alice, 'system_chat', p => p.content.value === '<Bob> hello')
    bob.chat('hello')
    await message

    const block = packet(alice, 'block_change', p => p.location.x === 1 && p.location.y === -60)
    const confirm = packet(bob, 'acknowledge_player_digging', p => p.sequenceId === 11)
    bob.write('set_creative_slot', {
      slot: 36,
      item: { itemCount: 64, itemId: 1, addedComponentCount: 0, removedComponentCount: 0, components: [], removeComponents: [] }
    })
    bob.write('block_place', { hand: 0, location: { x: 1, y: -61, z: 0 }, direction: 1,
      cursorX: 0.5, cursorY: 1, cursorZ: 0.5, insideBlock: false, worldBorderHit: false, sequence: 11 })
    assert.equal((await block).type, 1)
    await confirm

    const away = packet(bob, 'map_chunk', p => p.x === -3 && p.z === 0)
    bob.write('position', { x: -17.5, y: -60, z: 0.5, flags: { onGround: true } })
    await away

    const departure = packet(alice, 'entity_destroy', p => p.entityIds.includes(bobEntity.entityId))
    await disconnect(bob)
    await departure
    await disconnect(alice)
    await stop(server)
    server = await start(directory)

    const rejoined = client(server.port, 'Alice')
    clients.push(rejoined)
    const restored = await packet(rejoined, 'map_chunk', p => p.x === 0 && p.z === 0)
    assert.equal(blockAt(restored, 1, -60, 0), 1)
    const restoredBob = client(server.port, 'Bob')
    clients.push(restoredBob)
    const restoredItems = packet(restoredBob, 'window_items')
    assert.equal((await packet(restoredBob, 'position')).x, -17.5)
    assert.equal((await restoredItems).items[36].itemCount, 64)
  } finally {
    await Promise.all(clients.map(disconnect))
    await stop(server)
    fs.rmSync(directory, { recursive: true, force: true })
  }
})

test('survival mines, picks up and spends block items', { timeout: 15000 }, async () => {
  const directory = fs.mkdtempSync(path.join(os.tmpdir(), 'golem-survival-test-'))
  let server
  let bot
  try {
    server = await start(directory, 'gamemode=survival\n')
    bot = client(server.port, 'Miner')
    const center = packet(bot, 'map_chunk', p => p.x === 0 && p.z === 0)
    assert.equal((await packet(bot, 'login')).worldState.gamemode, 'survival')
    await center
    const target = { x: 1, y: -61, z: 0 }
    const dig = (status, sequence, location = target) => bot.write('block_dig', { status, location, face: 1, sequence })
    const early = packet(bot, 'block_change', p => p.location.x === 1)
    dig(2, 20)
    assert.equal((await early).type, 9)

    const mined = packet(bot, 'block_change', p => p.location.x === 1 && p.type === 0)
    const drop = packet(bot, 'spawn_entity', p => p.type === 71)
    const item = packet(bot, 'entity_metadata', p => p.metadata.some(entry => entry.type === 'item_stack'))
    const inventory = packet(bot, 'window_items', p => p.items[36].itemId === 28)
    const collect = packet(bot, 'collect')
    dig(0, 21)
    await delay(330)
    dig(2, 22)
    await mined
    assert.equal((await item).metadata.find(entry => entry.type === 'item_stack').value.itemId, 28)
    assert.equal((await collect).collectedEntityId, (await drop).entityId)
    assert.equal((await inventory).items[36].itemCount, 1)

    const placed = packet(bot, 'block_change', p => p.location.x === 1 && p.location.y === -61 && p.type === 10)
    const spent = packet(bot, 'window_items', p => p.items[36].itemCount === 0)
    bot.write('block_place', { hand: 0, location: { x: 1, y: -62, z: 0 }, direction: 1,
      cursorX: 0.5, cursorY: 1, cursorZ: 0.5, insideBlock: false, worldBorderHit: false, sequence: 23 })
    await placed
    await spent
  } finally {
    await disconnect(bot)
    await stop(server)
    fs.rmSync(directory, { recursive: true, force: true })
  }
})

test('manual inventory crafting consumes ingredients and saves output', { timeout: 15000 }, async () => {
  const directory = fs.mkdtempSync(path.join(os.tmpdir(), 'golem-crafting-test-'))
  let server
  let bot
  try {
    server = await start(directory)
    bot = client(server.port, 'Crafter')
    await packet(bot, 'position')
    const hasRecipe = packet(bot, 'window_items', p => p.items[0].itemId === 36)
    bot.write('set_creative_slot', {
      slot: 4,
      item: { itemCount: 2, itemId: 134, addedComponentCount: 0, removedComponentCount: 0, components: [], removeComponents: [] }
    })
    const preview = await hasRecipe
    assert.equal(preview.items[0].itemCount, 4)
    const click = (slot, revision) => {
      bot.write('window_click', { windowId: 0, stateId: revision, slot, mouseButton: 0,
        mode: 0, changedSlots: [], cursorItem: undefined })
    }
    const stale = packet(bot, 'window_items')
    click(0, preview.stateId - 1)
    const refreshed = await stale
    assert.equal(refreshed.items[4].itemCount, 2)
    assert.equal(refreshed.carriedItem.itemCount, 0)
    const took = packet(bot, 'window_items', p => p.carriedItem.itemId === 36)
    click(0, refreshed.stateId)
    const carried = await took
    assert.equal(carried.items[4].itemCount, 1)
    assert.equal(carried.carriedItem.itemCount, 4)
    const stored = packet(bot, 'window_items', p => p.items[36].itemId === 36)
    click(36, carried.stateId)
    assert.equal((await stored).items[36].itemCount, 4)
    await disconnect(bot)
    await stop(server)
    server = await start(directory)
    bot = client(server.port, 'Crafter')
    const reloaded = await packet(bot, 'window_items')
    assert.equal(reloaded.items[36].itemCount, 4)
    assert.equal(reloaded.items[4].itemCount, 1)
    assert.equal(reloaded.items[0].itemCount, 4)
  } finally {
    await disconnect(bot)
    await stop(server)
    fs.rmSync(directory, { recursive: true, force: true })
  }
})

test('vanilla snapshot payloads remain byte-identical and edits persist separately', {
  timeout: 20000,
  skip: !process.env.GOLEM_SNAPSHOT
}, async () => {
  const snapshot = path.resolve(root, process.env.GOLEM_SNAPSHOT)
  const [, seed, x, y, z] = fs.readFileSync(path.join(snapshot, 'snapshot.txt'), 'utf8').trim().split(' ')
  const directory = fs.mkdtempSync(path.join(os.tmpdir(), 'golem-snapshot-test-'))
  let server
  let bot
  try {
    server = await start(directory, 'level-seed=' + seed + '\nvanilla-snapshot=' + snapshot + '\n')
    bot = client(server.port, 'Snapshot')
    const remaining = new Set(fs.readdirSync(path.join(snapshot, 'chunks')).filter(file => {
      const [cx, cz] = file.split('.').map(Number)
      return Math.abs(cx - (Number(x) >> 4)) <= 2 && Math.abs(cz - (Number(z) >> 4)) <= 2
    }))
    assert.ok(remaining.size)
    const completed = new Promise((resolve, reject) => {
      const timer = setTimeout(() => reject(new Error('Missing chunks: ' + [...remaining].join(', '))), 10000)
      bot.on('packet', (data, meta, raw) => {
        if (meta.name !== 'map_chunk') return
        const filename = data.x + '.' + data.z + '.bin'
        if (!remaining.has(filename)) return
        try {
          assert.deepEqual(raw.subarray(1), fs.readFileSync(path.join(snapshot, 'chunks', filename)))
          remaining.delete(filename)
          if (!remaining.size) { clearTimeout(timer); resolve() }
        } catch (error) { clearTimeout(timer); reject(error) }
      })
    })
    await completed

    const worldX = Number(x)
    const worldY = Number(y)
    const worldZ = Number(z)
    const chunkX = worldX >> 4
    const chunkZ = worldZ >> 4
    const chunkFile = path.join(snapshot, 'chunks', chunkX + '.' + chunkZ + '.bin')
    const snapshotBytes = fs.readFileSync(chunkFile)
    const snapshotChunk = deserialize.parsePacketBuffer(Buffer.concat([Buffer.from([44]), snapshotBytes])).data.params
    let targetY = worldY - 1
    while (targetY > worldY - 4 && [0, 15090, 15091].includes(blockAt(snapshotChunk, worldX & 15, targetY, worldZ & 15))) targetY--
    assert.notEqual(blockAt(snapshotChunk, worldX & 15, targetY, worldZ & 15), 0)
    const edit = packet(bot, 'block_change', p => p.location.x === worldX && p.location.y === targetY && p.type === 0)
    bot.write('block_dig', { status: 0, location: { x: worldX, y: targetY, z: worldZ }, face: 1, sequence: 1 })
    await edit
    await disconnect(bot)
    await stop(server)
    server = await start(directory, 'level-seed=' + seed + '\nvanilla-snapshot=' + snapshot + '\n')
    bot = client(server.port, 'Snapshot')
    const edited = await packet(bot, 'map_chunk', p => p.x === chunkX && p.z === chunkZ)
    assert.equal(blockAt(edited, worldX & 15, targetY, worldZ & 15), 0)
    assert.deepEqual(snapshotBytes, fs.readFileSync(chunkFile))
  } finally {
    await disconnect(bot)
    await stop(server)
    fs.rmSync(directory, { recursive: true, force: true })
  }
})

function stateWith (name, values) {
  const block = requireTool('minecraft-data')('1.21.11').blocksByName[name]
  let result = block.defaultState - block.minStateId
  let stride = 1
  for (const property of [...block.states].reverse()) {
    if (Object.hasOwn(values, property.name)) {
      const index = (property.values || ['true', 'false']).indexOf(values[property.name])
      assert.ok(index >= 0)
      result += (index - (Math.floor(result / stride) % property.num_values)) * stride
    }
    stride *= property.num_values
  }
  return result + block.minStateId
}

function equip (bot, name) {
  const item = requireTool('minecraft-data')('1.21.11').itemsByName[name]
  bot.write('set_creative_slot', {
    slot: 36, item: { itemCount: 1, itemId: item.id, addedComponentCount: 0, removedComponentCount: 0, components: [], removeComponents: [] }
  })
}

function place (bot, x, y, z, face, sequence, cursorY = 0.5) {
  bot.write('block_place', {
    hand: 0, location: { x, y, z }, direction: face, cursorX: 0.5, cursorY, cursorZ: 0.5,
    insideBlock: false, worldBorderHit: false, sequence
  })
}

function dig (bot, x, y, z, sequence) {
  bot.write('block_dig', { status: 0, location: { x, y, z }, face: 1, sequence })
}

function lightAt (packet, sky, x, y, z) {
  const prefix = sky ? 'sky' : 'block'
  const section = ((y + 64) >> 4) + 1
  const mask = BigInt(packet[prefix + 'LightMask'][0] || 0)
  if (((mask >> BigInt(section)) & 1n) === 0n) return 0
  let arrayIndex = 0
  for (let index = 0; index < section; index++) arrayIndex += Number((mask >> BigInt(index)) & 1n)
  const data = packet[prefix + 'Light'][arrayIndex]
  const offset = ((y & 15) * 16 + (z & 15)) * 8 + ((x & 15) >> 1)
  return (data[offset] >> ((x & 1) * 4)) & 15
}

test('placement checks player collision and uses the clicked face, yaw, and hit height', { timeout: 25000 }, async () => {
  const directory = fs.mkdtempSync(path.join(os.tmpdir(), 'golem-placement-'))
  let server
  let builder
  let neighbor
  try {
    server = await start(directory)
    builder = client(server.port, 'Builder')
    const center = packet(builder, 'map_chunk', p => p.x === 0 && p.z === 0)
    await center
    let sequence = 0
    async function check (name, source, face, target, expected, cursorY) {
      equip(builder, name)
      const changed = packet(builder, 'block_change', p =>
        p.location.x === target[0] && p.location.y === target[1] && p.location.z === target[2])
      place(builder, ...source, face, ++sequence, cursorY)
      assert.equal((await changed).type, expected)
    }
    await check('stone', [0, -61, 0], 1, [0, -60, 0], 0)
    await check('stone', [1, -61, 0], 1, [1, -60, 0], stateWith('stone', {}))
    builder.write('look', { yaw: 90, pitch: 0, flags: { onGround: true } })
    await check('stone_button', [0, -61, 0], 1, [0, -60, 0], stateWith('stone_button', { face: 'floor', facing: 'west' }))
    await check('stone_button', [1, -60, 0], 5, [2, -60, 0], stateWith('stone_button', { face: 'wall', facing: 'east' }))
    await check('stone_button', [1, -60, 0], 2, [1, -60, -1], stateWith('stone_button', { face: 'wall', facing: 'north' }))
    await check('oak_log', [1, -60, 0], 3, [1, -60, 1], stateWith('oak_log', { axis: 'z' }))
    await check('torch', [1, -60, 1], 5, [2, -60, 1], stateWith('wall_torch', { facing: 'east' }))
    await check('furnace', [0, -61, 1], 1, [0, -60, 1], stateWith('furnace', { facing: 'east' }))
    await check('oak_stairs', [1, -60, 0], 1, [1, -59, 0], stateWith('oak_stairs', { facing: 'west', half: 'bottom' }))
    await check('stone_slab', [1, -60, 1], 3, [1, -60, 2], stateWith('stone_slab', { type: 'top' }), 0.75)
    await check('stone_slab', [1, -60, 2], 0, [1, -60, 2], stateWith('stone_slab', { type: 'double' }))
    const upper = packet(builder, 'block_change', p => p.location.x === -1 && p.location.y === -59 && p.location.z === 0)
    await check('oak_door', [-1, -61, 0], 1, [-1, -60, 0], stateWith('oak_door', { facing: 'west', half: 'lower' }))
    assert.equal((await upper).type, stateWith('oak_door', { facing: 'west', half: 'upper' }))
    const lowerGone = packet(builder, 'block_change', p => p.location.x === -1 && p.location.y === -60 && p.type === 0)
    dig(builder, -1, -59, 0, ++sequence)
    await lowerGone

    const present = packet(builder, 'spawn_entity')
    neighbor = client(server.port, 'Neighbor')
    await present
    const moved = packet(builder, 'sync_entity_position', p => p.x === 2.5)
    neighbor.write('position', { x: 2.5, y: -60, z: 2.5, flags: { onGround: true } })
    await moved
    await check('stone', [2, -61, 2], 1, [2, -60, 2], 0)
  } finally {
    await disconnect(neighbor)
    await disconnect(builder)
    await stop(server)
    fs.rmSync(directory, { recursive: true, force: true })
  }
})

test('lighting follows edits across a chunk boundary, movement, and restart', { timeout: 25000 }, async () => {
  const directory = fs.mkdtempSync(path.join(os.tmpdir(), 'golem-light-'))
  let server
  let bot
  try {
    server = await start(directory)
    bot = client(server.port, 'Lights')
    const neighbor = packet(bot, 'map_chunk', p => p.x === 1 && p.z === 0)
    await neighbor
    const seen = []
    bot.on('map_chunk', p => seen.push([p.x, p.z]))
    const view = packet(bot, 'update_view_position', p => p.chunkX === 1)
    const unlocked = packet(bot, 'map_chunk', p => p.x === 3 && p.z === 0)
    bot.write('position', { x: 16.5, y: -60, z: 0.5, flags: { onGround: true } })
    await view
    await unlocked
    assert.equal(seen.some(([x, z]) => x === 0 && z === 0), false, 'loaded chunks should not be resent')
    equip(bot, 'glowstone')
    const emitted = packet(bot, 'update_light', p => p.chunkX === 1 && p.chunkZ === 0 && lightAt(p, false, 0, -60, 2) === 14)
    place(bot, 15, -61, 2, 1, 1)
    await emitted
    const removed = packet(bot, 'update_light', p => p.chunkX === 1 && p.chunkZ === 0 && lightAt(p, false, 0, -60, 2) === 0)
    dig(bot, 15, -60, 2, 2)
    await removed

    equip(bot, 'stone')
    const shaded = packet(bot, 'update_light', p => p.chunkX === 0 && p.chunkZ === 0 && lightAt(p, true, 15, -60, 2) === 0)
    place(bot, 15, -61, 2, 1, 3)
    await shaded
    const restored = packet(bot, 'update_light', p => p.chunkX === 0 && p.chunkZ === 0 && lightAt(p, true, 15, -60, 2) === 15)
    dig(bot, 15, -60, 2, 4)
    await restored

    equip(bot, 'glowstone')
    const stored = packet(bot, 'block_change', p => p.location.x === 15 && p.location.z === 2 && p.type === 6815)
    place(bot, 15, -61, 2, 1, 5)
    await stored
    await disconnect(bot)
    await stop(server)
    server = await start(directory)
    bot = client(server.port, 'Lights')
    const sourceChunk = packet(bot, 'map_chunk', p => p.x === 0 && p.z === 0)
    const adjacent = await packet(bot, 'map_chunk', p => p.x === 1 && p.z === 0)
    assert.equal(lightAt(adjacent, false, 0, -60, 2), 14)
    const source = await sourceChunk
    const surface = source.heightmaps.find(h => h.type === 'world_surface').data
    const column = 2 * 16 + 15
    assert.equal((BigInt(surface[Math.floor(column / 7)]) >> BigInt((column % 7) * 9)) & 511n, 5n)
  } finally {
    await disconnect(bot)
    await stop(server)
    fs.rmSync(directory, { recursive: true, force: true })
  }
})

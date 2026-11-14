const fs = require('node:fs')
const path = require('node:path')

const horizontal = ['north', 'south', 'west', 'east']
const directions = ['down', 'up', ...horizontal]
const opposite = direction => direction ^ 1

function variant (block, changes) {
  let stride = 1
  let offset = block.defaultState - block.minStateId
  for (const property of [...block.states].reverse()) {
    const value = changes[property.name]
    if (value !== undefined) {
      const options = property.values ?? ['true', 'false']
      const digit = options.indexOf(value)
      if (digit >= 0) offset += (digit - (Math.floor(offset / stride) % property.num_values)) * stride
    }
    stride *= property.num_values
  }
  return block.minStateId + offset
}

const wallFacing = /(^ladder$|wall_(torch|sign|banner|head|skull|fan)$|_wall_hanging_sign$)/
const faceFacing = /(^end_rod$|amethyst_(cluster|bud)$|lightning_rod$|shulker_box$)/
const oppositeHorizontal = /(^|_)(furnace|smoker|chest|pumpkin|lantern|loom|stonecutter|lectern|beehive|bee_nest|bookshelf|shelf|glazed_terracotta|anvil|jack_o_lantern)$/
const oppositeVertical = /(^|_)(dispenser|dropper|piston|command_block|barrel)$/

function placedState (block, wall, face, yaw, look, upper) {
  const changes = {}
  const has = name => block.states.some(p => p.name === name)
  if (wall) {
    if (face === 0) return -1
    if (face >= 2) block = wall
  }
  if (has('axis')) changes.axis = face < 2 ? 'y' : face < 4 ? 'z' : 'x'
  if (has('rotation')) changes.rotation = String(yaw)
  if (has('vertical_direction')) changes.vertical_direction = face === 0 ? 'down' : 'up'
  if (has('hanging')) changes.hanging = face === 0 ? 'true' : 'false'
  if (block.name.endsWith('_door')) changes.half = 'lower'
  if (has('face')) changes.face = face === 0 ? 'ceiling' : face === 1 ? 'floor' : 'wall'
  if (has('attachment')) changes.attachment = face === 0 ? 'ceiling' : face === 1 ? 'floor' : 'single_wall'
  if (has('facing')) {
    const facing = block.states.find(p => p.name === 'facing')
    const bearing = [3, 4, 2, 5][((yaw + 2) & 15) >> 2]
    let direction = bearing
    if (has('face') || wallFacing.test(block.name)) {
      direction = face >= 2 ? face : bearing
      if (wallFacing.test(block.name) && face < 2) return -1
    } else if (block.name.endsWith('_trapdoor')) {
      direction = face >= 2 ? face : bearing
    } else if (block.name === 'observer') {
      direction = look
    } else if (faceFacing.test(block.name) || /amethyst_bud$/.test(block.name)) {
      direction = face
    } else if (facing.values.includes('up') && oppositeVertical.test(block.name)) {
      direction = opposite(look)
    } else if (oppositeHorizontal.test(block.name) || block.name === 'blast_furnace') {
      direction = opposite(bearing)
    }
    changes.facing = directions[direction]
  }
  if (block.name.endsWith('_stairs') || block.name.endsWith('_trapdoor')) {
    changes.half = face === 0 || (face >= 2 && upper) ? 'top' : 'bottom'
  }
  if (block.name.endsWith('_slab')) changes.type = face === 0 || (face >= 2 && upper) ? 'top' : 'bottom'
  return variant(block, changes)
}

function writePlacementData (directory, data, itemCount, stateCount) {
  const placements = Buffer.alloc(itemCount * 4, 255)
  const tables = []
  // Per-state dependent placement data: attachment, door part, or slab.
  const geometry = Buffer.alloc(stateCount * 6)
  for (const item of data.itemsArray) {
    const block = data.blocksByName[item.name]
    if (!block || !block.defaultState) continue
    const wallName = item.name.replace(/(^|_)(torch|hanging_sign|sign|banner|head|skull)$/, '$1wall_$2')
    const wall = wallName !== item.name ? data.blocksByName[wallName] : null
    if (!wall && !block.states.some(p => ['axis', 'facing', 'face', 'rotation', 'hanging', 'attachment', 'vertical_direction'].includes(p.name)) &&
        !block.name.endsWith('_slab')) continue
    const table = Buffer.alloc(6 * 16 * 3 * 2 * 2)
    let offset = 0
    for (let face = 0; face < 6; face++) {
      for (let yaw = 0; yaw < 16; yaw++) {
        for (const look of [0, 1, [3, 4, 2, 5][((yaw + 2) & 15) >> 2]]) {
          for (const upper of [false, true]) {
            table.writeUInt16BE(placedState(block, wall, face, yaw, look, upper) & 65535, offset)
            offset += 2
          }
        }
      }
    }
    const rotation = block.states.some(property => property.name === 'rotation') ? 1 : 0
    placements.writeInt32BE(placements.length + tables.length * table.length + rotation, item.id * 4)
    tables.push(table)
  }
  fs.writeFileSync(path.join(directory, 'placement-774.bin'), Buffer.concat([placements, ...tables]))

  for (const block of data.blocksArray) {
    const support = /(_button$|^lever$|(^|_)torch$|wall_torch$|^ladder$|^end_rod$|amethyst_(cluster|bud)$)/.test(block.name)
    for (let state = block.minStateId; state <= block.maxStateId; state++) {
      const offset = state * 6
      if (support) geometry[offset] = 1
      if (block.name.endsWith('_door')) {
        const half = (state - block.minStateId) & 15
        geometry[offset] = half >= 8 ? 2 : 3
        geometry.writeUInt16BE(half >= 8 ? state - 8 : state + 8, offset + 2)
      } else if (block.name.endsWith('_slab')) {
        const half = ((state - block.minStateId) >> 1) % 3
        if (half < 2) {
          geometry[offset] = 4 + half
          geometry.writeUInt16BE(variant(block, { type: 'double', waterlogged: 'false' }), offset + 2)
          geometry.writeUInt16BE(block.defaultState, offset + 4)
        }
      }
    }
  }
  fs.writeFileSync(path.join(directory, 'placement-rules-774.bin'), geometry)

  const { blocks, shapes } = data.blockCollisionShapes
  const offsets = Buffer.alloc(stateCount * 4)
  const shapeOffsets = new Map()
  const boxes = []
  let size = offsets.length
  for (const block of data.blocksArray) {
    const blockShapes = blocks[block.name]
    for (let state = block.minStateId; state <= block.maxStateId; state++) {
      const id = Array.isArray(blockShapes) ? blockShapes[state - block.minStateId] : blockShapes
      if (!shapeOffsets.has(id)) {
        const shape = shapes[id] ?? (block.boundingBox === 'block' ? [[0, 0, 0, 1, 1, 1]] : [])
        const entry = Buffer.alloc(1 + 12 * shape.length)
        entry[0] = shape.length
        for (const [i, coordinate] of shape.flat().entries()) entry.writeInt16BE(coordinate * 4096, 1 + i * 2)
        shapeOffsets.set(id, size)
        boxes.push(entry)
        size += entry.length
      }
      offsets.writeInt32BE(shapeOffsets.get(id), state * 4)
    }
  }
  fs.writeFileSync(path.join(directory, 'collision-774.bin'), Buffer.concat([offsets, ...boxes]))
}

module.exports = writePlacementData

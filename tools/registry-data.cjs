const fs = require('node:fs')
const path = require('node:path')
const data = require('minecraft-data')('1.21.11')
const writePlacementData = require('./placement-data.cjs')

function writeCarvers (directory, jarData) {
  const tags = fs.readFileSync(jarData, 'utf8').split(/\r?\n/).filter(Boolean)
  const replaceable = Buffer.alloc(Math.max(...data.blocksArray.map(block => block.maxStateId)) + 1)
  for (const name of tags) {
    const block = data.blocksByName[name.replace('minecraft:', '')]
    if (!block) throw new Error('Unknown replaceable block ' + name)
    replaceable.fill(1, block.minStateId, block.maxStateId + 1)
  }
  fs.writeFileSync(path.join(directory, 'overworld-carver-774.bin'), replaceable)
}

function writeRegistryData (directory) {
  const states = Buffer.alloc((Math.max(...data.itemsArray.map(item => item.id)) + 1) * 4, 255)
  for (const item of data.itemsArray) {
    const block = data.blocksByName[item.name]
    if (block && block.defaultState > 0) states.writeInt32BE(block.defaultState, item.id * 4)
  }
  const blocks = Buffer.alloc((Math.max(...data.blocksArray.map(block => block.maxStateId)) + 1) * 8)
  const light = Buffer.alloc(blocks.length / 4)
  const material = Buffer.alloc(blocks.length / 8)
  for (const block of data.blocksArray) {
    const minimumMs = Math.max(50, Math.floor(block.hardness * 500))
    const drop = block.drops.length && !block.harvestTools ? block.drops[0] : 0
    const names = [...block.states].reverse()
    const hasState = (state, name, value) => {
      let stride = 1
      for (const property of names) {
        if (property.name === name) {
          return (property.values ?? ['true', 'false'])[Math.floor((state - block.minStateId) / stride) % property.num_values] === value
        }
        stride *= property.num_values
      }
      return false
    }
    for (let state = block.minStateId; state <= block.maxStateId; state++) {
      let opacity = block.filterLight
      if (block.name.endsWith('_slab') && hasState(state, 'type', 'double')) opacity = 15
      if (hasState(state, 'waterlogged', 'true')) opacity = Math.max(1, opacity)
      let emission = block.emitLight
      if (names.some(p => p.name === 'lit')) {
        if (hasState(state, 'lit', 'false')) emission = 0
        else if (block.name === 'furnace' || block.name === 'blast_furnace' || block.name === 'smoker') emission = 13
        else if (block.name.endsWith('redstone_ore')) emission = 9
        else if (block.name === 'redstone_lamp') emission = 15
        else if (block.name.endsWith('candle_cake')) emission = 3
        else if (block.name.endsWith('candle')) emission = 3 * Number([1, 2, 3, 4].find(n => hasState(state, 'candles', String(n))) ?? 1)
      }
      light[state * 2] = opacity
      light[state * 2 + 1] = emission
      material[state] = (block.boundingBox === 'block' || block.name === 'water' || block.name === 'lava' || hasState(state, 'waterlogged', 'true') ? 1 : 0) |
        (block.name.endsWith('_leaves') ? 2 : 0) |
        (block.name === 'air' || block.name === 'void_air' || block.name === 'cave_air' ? 4 : 0)
      blocks.writeInt32BE(block.diggable && block.hardness >= 0 ? minimumMs : -1, state * 8)
      blocks.writeInt32BE(drop, state * 8 + 4)
    }
  }
  writePlacementData(directory, data, states.length / 4, blocks.length / 8)
  const limits = Buffer.alloc(states.length / 4)
  for (const item of data.itemsArray) limits.writeUInt8(item.stackSize, item.id)
  const recipes = Object.values(data.recipes).flat().filter(recipe => recipe.result.count > 0)
  const crafting = Buffer.alloc(recipes.length * 24)
  recipes.forEach((recipe, index) => {
    const offset = index * 24
    crafting.writeUInt16BE(recipe.result.id, offset)
    crafting.writeUInt8(recipe.result.count, offset + 2)
    if (recipe.inShape) {
      const width = Math.max(...recipe.inShape.map(row => row.length))
      crafting.writeUInt8(width, offset + 3)
      crafting.writeUInt8(recipe.inShape.length, offset + 4)
      for (let y = 0; y < recipe.inShape.length; y++) {
        for (let x = 0; x < width; x++) crafting.writeUInt16BE(recipe.inShape[y][x] || 0, offset + 6 + (y * width + x) * 2)
      }
    } else {
      const ingredients = recipe.ingredients.slice().sort((a, b) => a - b)
      crafting.writeUInt8(ingredients.length, offset + 5)
      ingredients.forEach((item, slot) => crafting.writeUInt16BE(item, offset + 6 + slot * 2))
    }
  })
  fs.writeFileSync(path.join(directory, 'crafting-774.bin'), crafting)
  fs.writeFileSync(path.join(directory, 'item-block-states-774.bin'), states)
  fs.writeFileSync(path.join(directory, 'block-rules-774.bin'), blocks)
  fs.writeFileSync(path.join(directory, 'light-rules-774.bin'), light)
  fs.writeFileSync(path.join(directory, 'block-materials-774.bin'), material)
  fs.writeFileSync(path.join(directory, 'item-limits-774.bin'), limits)
}

if (require.main === module) {
  writeRegistryData(process.argv[2] || 'data')
  if (process.argv[3]) writeCarvers(process.argv[2] || 'data', process.argv[3])
}
module.exports = writeRegistryData

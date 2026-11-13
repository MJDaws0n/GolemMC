const fs = require('node:fs')
const path = require('node:path')
const data = require('minecraft-data')('1.21.11')

function writeRegistryData (directory) {
  const states = Buffer.alloc((Math.max(...data.itemsArray.map(item => item.id)) + 1) * 4, 255)
  for (const item of data.itemsArray) {
    const block = data.blocksByName[item.name]
    if (block && block.defaultState > 0) states.writeInt32BE(block.defaultState, item.id * 4)
  }
  const blocks = Buffer.alloc((Math.max(...data.blocksArray.map(block => block.maxStateId)) + 1) * 8)
  for (const block of data.blocksArray) {
    const minimumMs = Math.max(50, Math.floor(block.hardness * 500))
    const drop = block.drops.length && !block.harvestTools ? block.drops[0] : 0
    for (let state = block.minStateId; state <= block.maxStateId; state++) {
      blocks.writeInt32BE(block.diggable && block.hardness >= 0 ? minimumMs : -1, state * 8)
      blocks.writeInt32BE(drop, state * 8 + 4)
    }
  }
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
  fs.writeFileSync(path.join(directory, 'item-limits-774.bin'), limits)
}

if (require.main === module) writeRegistryData(process.argv[2] || 'data')
module.exports = writeRegistryData

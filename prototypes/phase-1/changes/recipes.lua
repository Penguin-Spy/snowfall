-- make wooden chest stone
data.raw.recipe["wooden-chest"].ingredients = {
  { type = "item", name = "stone-brick", amount = 4 }
}

-- make stone furnace take fire bricks & copper (for resistive heating elements)
data.raw.recipe["stone-furnace"].ingredients = {
  { type = "item", name = "snowfall-fire-brick", amount = 4 },
  { type = "item", name = "copper-plate", amount = 4}
}
data.raw.recipe["stone-furnace"].energy_required = 1

-- stone power poles (todo: new graphics)
data.raw.recipe["small-electric-pole"].ingredients = {
  {type = "item", name = "stone-brick", amount = 1},
  {type = "item", name = "copper-cable", amount = 2}
}

-- disable stuff
data.raw.recipe["iron-chest"].enabled = false
data.raw.recipe["transport-belt"].enabled = false
data.raw.recipe["burner-inserter"].enabled = false
data.raw.recipe["burner-mining-drill"].enabled = false
data.raw.recipe["stone-furnace"].enabled = false
data.raw.recipe["iron-gear-wheel"].enabled = false -- the "brass gear"
data.raw.recipe["firearm-magazine"].enabled = false
data.raw.recipe["light-armor"].enabled = false

-- make belts & pneumatic inserters take lead/nickel/stone instead of iron
data.raw.recipe["burner-inserter"].ingredients = {
  { type = "item", name = "stone-brick", amount = 1 },
  { type = "item", name = "basic-gear",  amount = 1 },
  { type = "item", name = "lead-plate",  amount = 1 },
}
data.raw.recipe["transport-belt"].ingredients = {
  { type = "item", name = "basic-gear", amount = 1 },
  { type = "item", name = "lead-plate", amount = 1 },
}

data.raw.recipe["burner-mining-drill"].ingredients = {
  { type = "item", name = "stone-brick", amount = 4 },
  { type = "item", name = "lead-plate",  amount = 2 },
  { type = "item", name = "basic-gear",  amount = 2 },
}
data.raw.recipe["assembling-machine-1"].ingredients = {
  { type = "item", name = "stone-brick", amount = 6 },
  { type = "item", name = "snowfall-gearbox", amount = 2 },
  { type = "item", name = "copper-plate",  amount = 2 },
}

-- [[ remove unneeded items/recipes ]]
--?data.raw["item"]["brass-precursor"] = nil
--?data.raw["recipe"]["brass-precursor"] = nil
--?data.raw["item"]["invar-precursor"] = nil
--?data.raw["recipe"]["invar-precursor"] = nil

--?data_util.remove_technology_recipe_unlock("invar-processing", "invar-precursor")

-- make motors not use iron (nickel is ferromagnetic)
--?data_util.remove_recipe_ingredient("motor", "iron-stick")

-- make wooden chest stone
data.raw.recipe["wooden-chest"].ingredients = {
  { type = "item", name = "stone-brick", amount = 4 }
}

-- make stone furnace take bricks & fire bricks
data.raw.recipe["stone-furnace"].ingredients = {
  { type = "item", name = "stone-brick",         amount = 2 },
  { type = "item", name = "snowfall-fire-brick", amount = 4 }
}
data.raw.recipe["stone-furnace"].energy_required = 2

-- make belts & pneumatic inserters take lead/nickel/stone instead of iron
--?data.raw.recipe["burner-inserter"].ingredients = {
--?  { type = "item", name = "stone-brick", amount = 1 },
--?  { type = "item", name = "basic-gear",  amount = 1 },
--?  { type = "item", name = "lead-plate",  amount = 1 },
--?}
--?data.raw.recipe["transport-belt"].ingredients = {
--?  { type = "item", name = "basic-gear", amount = 1 },
--?  { type = "item", name = "lead-plate", amount = 1 },
--?}

-- [[ remove unneeded items/recipes ]]
--?data.raw["item"]["brass-precursor"] = nil
--?data.raw["recipe"]["brass-precursor"] = nil
--?data.raw["item"]["invar-precursor"] = nil
--?data.raw["recipe"]["invar-precursor"] = nil

--?data_util.remove_technology_recipe_unlock("invar-processing", "invar-precursor")

-- make motors not use iron (nickel is ferromagnetic)
--?data_util.remove_recipe_ingredient("motor", "iron-stick")

-- put electric stuff behind technology
--data.raw.recipe["steam-engine"].normal.enabled = false
--data.raw.recipe["steam-engine"].expensive.enabled = false
--data.raw.recipe["electric-mining-drill"].normal.enabled = false
--data.raw.recipe["electric-mining-drill"].expensive.enabled = false
--data.raw.recipe["lab"].enabled = false
--data.raw.recipe["offshore-pump"].enabled = false

-- make wooden chest stone
data.raw.recipe["wooden-chest"].ingredients = {
  { type = "item", name = "stone-brick", amount = 4 }
}

-- make stone bricks cheap
data.raw.recipe["stone-brick"]. ingredients = {
  { type = "item", name = "stone", amount = 1}
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

-- disable stuff from the start
data.raw.recipe["iron-chest"].enabled = false
data.raw.recipe["transport-belt"].enabled = false
data.raw.recipe["burner-inserter"].enabled = false
data.raw.recipe["burner-mining-drill"].enabled = false
data.raw.recipe["stone-furnace"].enabled = false
data.raw.recipe["iron-gear-wheel"].enabled = false -- the "brass gear"
data.raw.recipe["firearm-magazine"].enabled = false
data.raw.recipe["light-armor"].enabled = false

-- make belts & pneumatic machines take lead/nickel/stone instead of iron
data.raw.recipe["burner-inserter"].ingredients = {
  { type = "item", name = "stone-brick", amount = 1 },
  { type = "item", name = "lead-plate",  amount = 1 },
  { type = "item", name = "basic-gear",  amount = 1 },
}
data.raw.recipe["transport-belt"].ingredients = {
  { type = "item", name = "lead-plate", amount = 1 },
  { type = "item", name = "basic-gear", amount = 1 },
}
data.raw.recipe["underground-belt"].ingredients = {
  { type = "item", name = "lead-plate", amount = 10 },
  { type = "item", name = "transport-belt", amount = 5 },
}
data.raw.recipe["splitter"].ingredients = {
  { type = "item", name = "basic-gear", amount = 4 },
  { type = "item", name = "transport-belt", amount = 4 },
}

data.raw.recipe["burner-mining-drill"].ingredients = {
  { type = "item", name = "stone-brick", amount = 4 },
  { type = "item", name = "lead-plate",  amount = 2 },
  { type = "item", name = "basic-gear",  amount = 2 },
}
data.raw.recipe["assembling-machine-1"].ingredients = {
  { type = "item", name = "stone-brick", amount = 6 },
  { type = "item", name = "lead-plate", amount = 4 },
  { type = "item", name = "basic-gear", amount = 4 },
  { type = "item", name = "snowfall-spring", amount = 2 },
}

-- make walls & gates cheap
data.raw.recipe["stone-wall"].ingredients = {
  { type = "item", name = "stone-brick", amount = 3 }
}
data.raw.recipe["gate"].ingredients = {
  { type = "item", name = "stone-wall", amount = 1 },
  { type = "item", name = "lead-plate", amount = 2 },
  { type = "item", name = "basic-gear", amount = 2 },
}

-- make lamps, radars, and repair packs not take circuits (don't ask how the radar works. i don't know)
data.raw.recipe["small-lamp"].ingredients = {
  { type = "item", name = "stone-brick", amount = 1 },
  { type = "item", name = "copper-cable",  amount = 4 }
}
data.raw.recipe["radar"].ingredients = {
  { type = "item", name = "stone-brick", amount = 6 },
  { type = "item", name = "zinc-plate",  amount = 4 },
  { type = "item", name = "basic-gear",  amount = 4 }
}
data.raw.recipe["repair-pack"].ingredients = {
  { type = "item", name = "stone-brick", amount = 1 },
  { type = "item", name = "lead-plate",  amount = 1 },
  { type = "item", name = "copper-plate",  amount = 1 },
}

-- replace ingredients of red science, now "Manufacturing data punchcard"
data.raw.recipe["automation-science-pack"].ingredients = {
  { type = "item", name = "copper-cable", amount = 2 },
  { type = "item", name = "basic-gear", amount = 1 },
  { type = "item", name = "silica", amount = 2 },
}
data.raw.recipe["automation-science-pack"].category = "snowfall-pneumatic-research"

-- electromechanics ingredients for electric drill & inserter
data.raw.recipe["electric-mining-drill"].ingredients = {
  { type = "item", name = "lead-plate", amount = 10 },
  { type = "item", name = "basic-gear", amount = 5 },
  { type = "item", name = "snowfall-sequence-motor", amount = 3 },
}
data.raw.recipe["inserter"].ingredients = {
  { type = "item", name = "lead-plate", amount = 1 },
  { type = "item", name = "basic-gear", amount = 1 },
  { type = "item", name = "snowfall-sequence-motor", amount = 1 },
}

-- steel furnace, now "Alloy forge"
data.raw.recipe["steel-furnace"].ingredients = {
  { type = "item", name = "stone-brick", amount = 6 },
  { type = "item", name = "snowfall-fire-brick", amount = 8 },
  { type = "item", name = "lead-plate", amount = 6 },
  { type = "item", name = "pipe", amount = 2 },
}
data.raw.recipe["offshore-pump"].ingredients = {
  { type = "item", name = "basic-gear", amount = 2 },
  { type = "item", name = "pipe", amount = 3 },
}

-- replace ingredients of car & mini trains
data.raw.recipe["car"].ingredients = {
  { type = "item", name = "lead-plate", amount = 4 },
  { type = "item", name = "basic-gear", amount = 4 },
  { type = "item", name = "snowfall-steam-engine", amount = 1 },
}
data.raw.recipe["mini-locomotive"].ingredients = {
  { type = "item", name = "lead-plate", amount = 10 },
  { type = "item", name = "basic-gear", amount = 6 },
  { type = "item", name = "snowfall-spring", amount = 4 },
  { type = "item", name = "snowfall-steam-engine", amount = 2 },
}
data.raw.recipe["mini-cargo-wagon"].ingredients = {
  { type = "item", name = "lead-plate", amount = 6 },
  { type = "item", name = "basic-gear", amount = 8 },
  { type = "item", name = "snowfall-spring", amount = 4 },
}
data.raw.recipe["mini-fluid-wagon"].ingredients = {
  { type = "item", name = "lead-plate", amount = 8 },
  { type = "item", name = "basic-gear", amount = 6 },
  { type = "item", name = "snowfall-spring", amount = 4 },
}

-- [[ remove unneeded items/recipes ]]
--?data.raw["item"]["brass-precursor"] = nil
--?data.raw["recipe"]["brass-precursor"] = nil
--?data.raw["item"]["invar-precursor"] = nil
--?data.raw["recipe"]["invar-precursor"] = nil

--?data_util.remove_technology_recipe_unlock("invar-processing", "invar-precursor")

-- make motors not use iron (nickel is ferromagnetic)
--?data_util.remove_recipe_ingredient("motor", "iron-stick")

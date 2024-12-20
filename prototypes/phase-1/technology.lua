
local fake_electronics_cost = {
  count = 10,
  time = 15,
  ingredients = {{"snowfall-material-punchcard", 1}}
}
local fake_electronics_effects = {
  { type = "unlock-recipe", recipe = "electronic-circuit" },
  { type = "unlock-recipe", recipe = "lab" },
  { type = "unlock-recipe", recipe = "inserter" }
}

data:extend{
  {
    type = "technology",
    name = "snowfall-mineral-survey",
    icon = data_util.graphics .. "icons/starmap-kiwen-lete.png",
    icon_size = 512,
    essential = true,
    research_trigger = {
      type = "craft-item",
      item = "snowfall-internal-mineral-survey"
    },
    effects = {
      {
        type = "nothing",
        effect_description = { "snowfall.mineral-survey-result" },
        icon = "__base__/graphics/icons/science.png"
      },
      { type = "unlock-recipe", recipe = "copper-plate", hidden = true},
      { type = "unlock-recipe", recipe = "lead-plate", hidden = true},
      { type = "unlock-recipe", recipe = "zinc-plate", hidden = true},
      { type = "unlock-recipe", recipe = "nickel-plate", hidden = true},
      { type = "unlock-recipe", recipe = "stone-brick", hidden = true},
      { type = "unlock-recipe", recipe = "snowfall-fire-brick", hidden = true},
      { type = "unlock-recipe", recipe = "basic-gear", hidden = true},
      { type = "unlock-recipe", recipe = "wooden-chest", hidden = true}
    }
  },
  {
    type = "technology",
    name = "snowfall-pneumatics",
    icon = "__base__/graphics/technology/steam-power.png",
    icon_size = 256,
    order = "a",
    prerequisites = { "snowfall-mineral-survey" },
    research_trigger = {
      type = "craft-item",
      item = "lead-plate",
      count = 5,
    },
    effects = {
      { type = "unlock-recipe", recipe = "pipe" },
      { type = "unlock-recipe", recipe = "pipe-to-ground" },
      { type = "unlock-recipe", recipe = "snowfall-steam-vent-cap" },
      { type = "unlock-recipe", recipe = "burner-mining-drill" },
      { type = "unlock-recipe", recipe = "burner-inserter" }
    }
  },
  {
    type = "technology",
    name = "snowfall-electric-smelting",
    icon = "__base__/graphics/technology/advanced-material-processing-2.png",
    icon_size = 256,
    order = "b",
    prerequisites = { "snowfall-mineral-survey" },
    research_trigger = {
      type = "craft-item",
      item = "copper-plate",
      count = 10,
    },
    effects = {
      { type = "unlock-recipe", recipe = "copper-cable" },
      { type = "unlock-recipe", recipe = "snowfall-steam-vent-turbine" },
      { type = "unlock-recipe", recipe = "small-electric-pole" },
      { type = "unlock-recipe", recipe = "stone-furnace" }
    }
  },
  {
    type = "technology",
    name = "snowfall-material-punchcard",
    icon = data_util.graphics .. "technology/material-punchcard.png",
    icon_size = 256,
    prerequisites = { "snowfall-pneumatics", "snowfall-electric-smelting" },
    research_trigger = {
      type = "craft-item",
      item = "zinc-plate",
      count = 10,
    },
    effects = {
      { type = "unlock-recipe", recipe = "snowfall-material-punchcard" },
      { type = "unlock-recipe", recipe = "snowfall-pneumatic-lab" }
    }
  },
  { -- fake electronics to be researched earlygame
    type = "technology",
    name = "snowfall-fake-electronics",
    localised_name = {"technology-name.electronics"},
    localised_description = {"technology-description.electronics"},
    icon = "__base__/graphics/technology/electronics.png",
    icon_size = 256,
    -- enabled by default, visible_when_disabled defaults to false to hide it during runtime
    prerequisites = { "snowfall-material-punchcard" },
    effects = fake_electronics_effects,
    unit = fake_electronics_cost
  },
  { -- fake electronics to show a new description for failing
    type = "technology",
    name = "snowfall-fake-electronics-failed",
    localised_name = {"snowfall.technology-failed", {"technology-name.electronics"}},
    icon = "__base__/graphics/technology/electronics.png",
    icon_size = 256,
    enabled = false,  -- will never be enabled
    -- visible_when_disabled defaults to false and changes during runtime
    prerequisites = { "snowfall-material-punchcard" },
    effects = fake_electronics_effects,
    unit = fake_electronics_cost
  },
  --[[{
    type = "technology",
    name = "snowfall-electromechanics",
    --icon = data_util.graphics .. "technology/electromechanics.png",
    icon = "__base__/graphics/technology/electronics.png",
    icon_size = 256,
    enabled = false, -- hidden by default
    prerequisites = { "snowfall-material-punchcard" },
    effects = {

    },
    unit = {
      count = 10,
      time = 15,
      ingredients = {{"snowfall-material-punchcard", 1}}
    }
  },]]
}

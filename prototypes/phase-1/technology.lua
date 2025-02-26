
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
    icon = data_util.graphics .. "icons/starmap-kiwen-lete.png", icon_size = 512,
    essential = true,
    unit = {
      count = 1,
      time = 10,
      ingredients = {{"snowfall-internal-mineral-survey", 1}}
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
      { type = "unlock-recipe", recipe = "wooden-chest", hidden = true},
      { type = "unlock-recipe", recipe = "snowfall-fire-clay", hidden = true},
      { type = "unlock-recipe", recipe = "snowfall-fire-brick", hidden = true},
      { type = "unlock-recipe", recipe = "basic-gear", hidden = true},
    }
  },
  {
    type = "technology",
    name = "snowfall-pneumatics",
    icon = "__base__/graphics/technology/steam-power.png", icon_size = 256,
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
    icon = "__base__/graphics/technology/advanced-material-processing-2.png", icon_size = 256,
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
    icon = data_util.graphics .. "technology/material-punchcard.png", icon_size = 256,
    essential = true,
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
  {
    type = "technology",
    name = "snowfall-pneumatic-pulverizer",
    icon = data_util.graphics .. "technology/pneumatic-pulverizer.png", icon_size = 256,
    prerequisites = { "snowfall-material-punchcard" },
    unit = {
      count = 10,
      time = 15,
      ingredients = {{"snowfall-material-punchcard", 1}}
    },
    effects = {
      { type = "unlock-recipe", recipe = "snowfall-pneumatic-pulverizer" },
      { type = "unlock-recipe", recipe = "snowfall-pulverizing-stone" },
      { type = "unlock-recipe", recipe = "snowfall-pulverizing-slag" }
    }
  },
  {
    type = "technology",
    name = "snowfall-ice-bore",
    icon = data_util.graphics .. "technology/ice-bore.png", icon_size = 256,
    localised_description = {"entity-description.snowfall-burner-ice-bore"},
    prerequisites = { "snowfall-pneumatic-pulverizer" },
    unit = {
      count = 10,
      time = 10,
      ingredients = {
        {"snowfall-material-punchcard", 1},
      }
    },
    effects = {
      { type = "unlock-recipe", recipe = "snowfall-burner-ice-bore" },
    }
  },
  { -- fake electronics to be researched earlygame
    type = "technology",
    name = "snowfall-fake-electronics",
    localised_name = {"technology-name.electronics"},
    localised_description = {"technology-description.electronics"},
    icon = "__base__/graphics/technology/electronics.png", icon_size = 256,
    -- enabled by default, visible_when_disabled defaults to false to hide it during runtime
    prerequisites = { "snowfall-material-punchcard" },
    effects = fake_electronics_effects,
    unit = fake_electronics_cost
  },
  { -- fake electronics to show a new description for failing
    type = "technology",
    name = "snowfall-fake-electronics-failed",
    localised_name = {"snowfall.technology-failed", {"technology-name.electronics"}},
    icon = "__base__/graphics/technology/electronics.png", icon_size = 256,
    enabled = false,  -- will never be enabled
    -- visible_when_disabled defaults to false and changes during runtime
    prerequisites = { "snowfall-material-punchcard" },
    effects = fake_electronics_effects,
    unit = fake_electronics_cost
  },

  -- after Manufacturing research

  {
    type = "technology",
    name = "snowfall-electromechanics",
    icon = data_util.graphics .. "technology/electromechanics.png", icon_size = 256,
    order = "a",
    prerequisites = { "automation-science-pack" },
    unit = {
      count = 25,
      time = 10,
      ingredients = {
        {"snowfall-material-punchcard", 1},
        {"automation-science-pack", 1}
      }
    },
    effects = {
      { type = "unlock-recipe", recipe = "relay" },
      { type = "unlock-recipe", recipe = "snowfall-sequence-motor" },
      { type = "unlock-recipe", recipe = "snowfall-state-rotor" },
    }
  },
  {
    type = "technology",
    name = "snowfall-electric-inserter",
    icon = "__base__/graphics/technology/inserter-capacity.png", icon_size = 256,
    prerequisites = { "snowfall-electromechanics" },
    unit = {
      count = 20,
      time = 10,
      ingredients = {
        {"snowfall-material-punchcard", 1},
        {"automation-science-pack", 1}
      }
    },
    effects = {
      { type = "unlock-recipe", recipe = "inserter" }
    }
  },
  {
    type = "technology",
    name = "snowfall-electrolysis",
    icon = data_util.graphics .. "technology/electrolysis.png", icon_size = 256,
    prerequisites = { "automation-science-pack", "snowfall-ice-bore" },
    unit = {
      count = 15,
      time = 10,
      ingredients = {
        {"snowfall-material-punchcard", 1},
        {"automation-science-pack", 1}
      }
    },
    effects = {
      { type = "unlock-recipe", recipe = "snowfall-electrolyzer" },
      { type = "unlock-recipe", recipe = "snowfall-electrolysis-of-water" },
    }
  },
  {
    type = "technology",
    name = "snowfall-brass-alloying",
    icon = "__base__/graphics/technology/advanced-material-processing.png", icon_size = 256,
    order = "m",
    prerequisites = { "snowfall-electrolysis" },
    unit = {
      count = 20,
      time = 10,
      ingredients = {
        {"snowfall-material-punchcard", 1},
        {"automation-science-pack", 1}
      }
    },
    effects = {
      { type = "unlock-recipe", recipe = "steel-furnace" },
      { type = "unlock-recipe", recipe = "brass-plate" },
      { type = "unlock-recipe", recipe = "offshore-pump" }
    }
  },
  {
    type = "technology",
    name = "snowfall-pressurized-steam",
    icon = data_util.graphics .. "technology/pressurized-steam.png", icon_size = 256,
    prerequisites = { "snowfall-brass-alloying" },
    unit = {
      count = 30,
      time = 10,
      ingredients = {
        {"snowfall-material-punchcard", 1},
        {"automation-science-pack", 1}
      }
    },
    effects = {
      { type = "unlock-recipe", recipe = "brass-balls" },
      { type = "unlock-recipe", recipe = "bearing" },
      { type = "unlock-recipe", recipe = "snowfall-steam-engine" },
      { type = "unlock-recipe", recipe = "snowfall-canister-filler" },
      { type = "unlock-recipe", recipe = "empty-canister" },
      { type = "unlock-recipe", recipe = "steam-canister" },
    }
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

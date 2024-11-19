data:extend{
  {
    type = "technology",
    name = "snowfall-mineral-survey",
    icon = data_util.graphics .. "icons/starmap-kiwen-lete.png",
    icon_size = 512,
    research_trigger = {
      type = "craft-item",
      item = "snowfall-internal-mineral-survey"
    },
    effects = {
      { 
        type = "nothing",
        effect_description = { "snowfall.mineral-survey-result" },
        icon = "__base__/graphics/icons/science.png"
      }
      -- todo: unlock all plate & brick recipes as (hidden) effects here?
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
    name = "snowfall-material-research",
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
  }
}

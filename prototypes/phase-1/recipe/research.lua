data:extend{
  {
    type = "recipe-category",
    name = "snowfall-internal"
  },
  {
    type = "recipe",
    name = "snowfall-internal-mineral-survey",
    localised_name = {"technology-name.snowfall-mineral-survey"},
    localised_description = {"technology-description.snowfall-mineral-survey"},
    subgroup = "science-pack",
    order = "a-a",
    ingredients = {
      { type = "item", name = "nickel-ore", amount = 3 },
      { type = "item", name = "zinc-ore",   amount = 3 },
      { type = "item", name = "lead-ore",   amount = 3 },
      { type = "item", name = "copper-ore", amount = 3 },
      { type = "item", name = "stone",      amount = 3 }
    },
    results = {
      { type = "research-progress", research_item = "snowfall-internal-mineral-survey" }
    },
    energy_required = 10,
    category = "snowfall-internal",
    hide_from_player_crafting = true
  } --[[@as data.RecipePrototype]],
  { -- hidden lab that takes all the internal research items
    type = "lab",
    name = "snowfall-internal-lab",
    hidden = true,
    energy_usage = "1W",
    energy_source = { type = "void" },
    inputs = { "snowfall-internal-mineral-survey", "snowfall-material-punchcard", "automation-science-pack" }
  },

  {
    type = "recipe-category",
    name = "snowfall-pneumatic-research"
  }  --[[@as data.RecipeCategory]],
  {
    type = "recipe",
    name = "snowfall-material-punchcard",
    ingredients = {
      { type = "item", name = "nickel-plate", amount = 1 },
      { type = "item", name = "zinc-plate",   amount = 1 },
      { type = "item", name = "stone",        amount = 2 }
    },
    results = {
      { type = "item", name = "snowfall-material-punchcard", amount = 1, probability = 0.75 }
    },
    energy_required = 5,
    category = "snowfall-pneumatic-research",
    show_amount_in_title = false,
    always_show_products = true,
    enabled = false
  }  --[[@as data.RecipePrototype]],
}

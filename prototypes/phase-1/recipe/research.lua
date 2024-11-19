data:extend{
  {
    type = "recipe-category",
    name = "snowfall-internal"
  },
  {
    type = "recipe",
    name = "snowfall-internal-mineral-survey",
    ingredients = {
      { type = "item", name = "nickel-ore", amount = 5 },
      { type = "item", name = "zinc-ore",   amount = 5 },
      { type = "item", name = "lead-ore",   amount = 5 },
      { type = "item", name = "copper-ore", amount = 5 },
      { type = "item", name = "stone",      amount = 5 }
    },
    results = {
      { type = "item", name = "snowfall-internal-mineral-survey", amount = 1 }
    },
    energy_required = 10,
    category = "snowfall-internal",
    hidden = true
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

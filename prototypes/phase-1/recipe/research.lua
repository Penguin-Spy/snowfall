data:extend{
  {
    type = "recipe-category",
    name = "snowfall-pneumatic-research"
  }  --[[@as data.RecipeCategory]],

  {
    type = "recipe",
    name = "snowfall-material-punchcard",
    ingredients = {
      {type = "item", name = "nickel-plate", amount = 1},
      {type = "item", name = "zinc-ore",     amount = 1},
      {type = "item", name = "stone",        amount = 1}
    },
    results = {
      {type = "item", name = "snowfall-material-punchcard", amount = 1}
    },
    energy_required = 5,
    category = "snowfall-pneumatic-research"
  }  --[[@as data.RecipePrototype]],
}

data:extend{
  -- the category itself
  {
    type = "recipe-category",
    name = "snowfall-pulverizing"
  },
  -- recipes
  {
    type = "recipe",
    name = "snowfall-pulverizing-stone",
    icons = data_util.icon_with_detail("silica", "stone"),
    category = "snowfall-pulverizing",
    ingredients = {{type = "item", name = "stone", amount = 1}},
    results = {
      {type = "item", name = "silica", amount_min = 0, amount_max = 2, probability = 0.2},
      {type = "item", name = "snowfall-kaolinite", amount = 1, probability = 0.05}
    },
    enabled = false,
    energy_required = 2,
    --always_show_products = true
  }  --[[@as data.RecipePrototype]],
  {
    type = "recipe",
    name = "snowfall-pulverizing-slag",
    icons = data_util.icon_with_detail("silica", "slag"),
    category = "snowfall-pulverizing",
    ingredients = {{type = "item", name = "slag", amount = 1}},
    results = {
      {type = "item", name = "silica", amount = 1, probability = 0.15}
    },
    enabled = false,
    energy_required = 2,
    show_amount_in_title = false
    --always_show_products = true
  }  --[[@as data.RecipePrototype]]
}

log(serpent.block(data.raw.recipe["snowfall-pulverizing-stone"]))
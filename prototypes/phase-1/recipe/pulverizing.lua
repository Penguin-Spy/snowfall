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
    subgroup = "processed-stone",
    order = "b-c[pulverizing-stone]",
    category = "snowfall-pulverizing",
    ingredients = {{type = "item", name = "stone", amount = 1}},
    results = {
      {type = "item", name = "silica", amount_min = 0, amount_max = 2, probability = 0.6},
      {type = "item", name = "snowfall-kaolinite", amount = 1, probability = 0.05}
    },
    enabled = false,
    energy_required = 2
  }  --[[@as data.RecipePrototype]],
  {
    type = "recipe",
    name = "snowfall-pulverizing-slag",
    icons = data_util.icon_with_detail("silica", "slag"),
    subgroup = "processed-stone",
    order = "b-d[pulverizing-slag]",
    category = "snowfall-pulverizing",
    ingredients = {{type = "item", name = "slag", amount = 1}},
    results = {
      {type = "item", name = "silica", amount = 1, probability = 0.2}
    },
    enabled = false,
    energy_required = 2,
    show_amount_in_title = false
  }  --[[@as data.RecipePrototype]]
}

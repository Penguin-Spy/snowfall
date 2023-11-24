data:extend{
  -- the category itself
  {
    type = "recipe-category",
    name = "snowfall-melting"
  },
  -- recipes
  {
    type = "recipe",
    name = "snowfall-melting-ice",
    category = "snowfall-melting",
    ingredients = {
      {type = "item", name = "ice", amount = 1}
    },
    results = {
      {type = "fluid", name = "water", amount = 100, temperature = 15}
    },
    energy_required = 8,
    always_show_products = true
  }
}

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
      { type = "item", name = "ice", amount = 1 }
    },
    results = {
      { type = "fluid", name = "steam", amount = 100, temperature = 100 }
    },
    energy_required = 12.5,  -- -179C to +100C with 90kW, 100% efficient
    always_show_products = true,
    subgroup = "fluid-recipes",
    hide_from_player_crafting = true,
    allow_decomposition = false
  }  --[[@as data.RecipePrototype]]
}

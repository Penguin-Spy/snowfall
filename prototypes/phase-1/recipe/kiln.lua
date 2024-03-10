data:extend{
  -- the category itself
  {
    type = "recipe-category",
    name = "kiln"
  },
  -- recipes
  {
    type = "recipe",
    name = "snowfall-fire-brick",
    category = "kiln",
    ingredients = {
      {type = "item", name = "stone",              amount = 2},
      {type = "item", name = "snowfall-kaolinite", amount = 3}
    },
    results = {
      {type = "item", name = "snowfall-fire-brick", amount = 2}
    },
    energy_required = 5,
    always_show_products = true
  }  --[[@as data.RecipePrototype]]
}

-- move the stone brick recipe to the kiln category
data.raw["recipe"]["stone-brick"].category = "kiln"

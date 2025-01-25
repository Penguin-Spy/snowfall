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
      {type = "item", name = "snowfall-fire-clay", amount = 4}
    },
    results = {
      {type = "item", name = "snowfall-fire-brick", amount = 2}
    },
    enabled = false,
    energy_required = 5
  }  --[[@as data.RecipePrototype]]
}

-- move the stone brick recipe to the kiln category
data.raw["recipe"]["stone-brick"].category = "kiln"

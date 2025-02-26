-- various internal recipes & whatnot

data:extend{
  -- categories
  {
    type = "recipe-category",
    name = "snowfall-internal",
    hidden = true
  },
  {
    type = "resource-category",
    name = "snowfall-internal",
    hidden = true
  },
  {
    type = "module-category",
    name = "snowfall-spaceship-module"
  },

  -- recipes
  {
    type = "recipe",
    name = "snowfall-internal-methane-fuel-mix",
    hidden = true,
    category = "snowfall-internal",
    ingredients = {
      { type = "fluid", name = "methane", amount = 10 },
      { type = "fluid", name = "oxygen", amount = 200 }
    },
    results = {
      { type = "fluid", name = "snowfall-internal-methane-fuel-mix", amount = 10 }
    },
    energy_required = 0.1
  } --[[@as data.RecipePrototype]]
}

data:extend{
  {
    type = "recipe-category",
    name = "electrolysis"
  },
  {
    type = "recipe",
    name = "snowfall-electrolysis-of-water",
    category = "electrolysis",
    icons = {
      { icon = data.raw.fluid["water"].icon, scale = 0.3, shift = {0, -7} },
      { icon = data.raw.fluid["oxygen"].icon, scale = 0.3, shift = {-6, 8} },
      { icon = data.raw.fluid["hydrogen"].icon, scale = 0.3, shift = {6, 8} },
    },
    subgroup = "fluid-recipes",
    ingredients = {
      {type = "item", name = "ice", amount = 1} -- 1 ice is 10 water (100 steam)
    },
    results = {
      {type = "fluid", name = "oxygen", amount = 50},    -- 2 water -> 1 o2 + 2 h2,  so 10 -> 50 & 100
      {type = "fluid", name = "hydrogen", amount = 100}, -- gases are 10x units of liquid
    },
    enabled = false,
    energy_required = 4
  }
}

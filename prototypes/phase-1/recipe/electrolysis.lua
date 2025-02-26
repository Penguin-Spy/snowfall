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
      {type = "item", name = "ice", amount = 1} -- 1 ice is 20 water
    },
    results = {
      {type = "fluid", name = "oxygen", amount = 100},    -- 2 water -> 1 o2 + 2 h2,  so 20 -> 100 & 200
      {type = "fluid", name = "hydrogen", amount = 200},  -- gases are 10x units of liquid
    },
    enabled = false,
    energy_required = 4
  }
}

-- smelting ores and casting into molds directly
local graphics = "__snowfall__/graphics/"

local mold_cast_costs = {
  ingot = 4,
  gear = 2,
  rod = 3
}

local function direct_casting(metal, mold_type)
  data:extend{
    {
      type = "item",
      name = "snowfall-" .. mold_type .. "-mold-" .. metal,
      icon = graphics .. "icons/placeholder.png", icon_size = 64,
      subgroup = "snowfall-molds",
      stack_size = 10
    },
    {
      type = "recipe",
      name = "snowfall-" .. metal .. "-" .. mold_type .. "-direct-casting",
      category = "snowfall-direct-casting",
      ingredients = {
        {type = "item", name = metal .. "-ore",                     amount = mold_cast_costs[mold_type]},
        {type = "item", name = "snowfall-" .. mold_type .. "-mold", amount = 1},
      },
      results = {
        {type = "item", name = "snowfall-" .. mold_type .. "-mold-" .. metal, amount = 1}
      },
      energy_required = 3.2
    }
  }
end

data:extend{
  -- the category itself
  {
    type = "recipe-category",
    name = "snowfall-direct-casting"
  },
}

direct_casting("iron", "ingot")
direct_casting("iron", "gear")
direct_casting("iron", "rod")
direct_casting("copper", "ingot")
direct_casting("copper", "gear")
direct_casting("copper", "rod")

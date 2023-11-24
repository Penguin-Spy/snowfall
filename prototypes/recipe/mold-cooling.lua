local graphics = "__snowfall__/graphics/"

local function cooling(metal, mold_type)
  data:extend{
    {
      type = "item",
      name = "snowfall-" .. metal .. "-" .. mold_type,
      icon = graphics .. "icons/placeholder.png", icon_size = 64,
      subgroup = "snowfall-molds",
      stack_size = 100
    },
    {
      type = "recipe",
      name = "snowfall-" .. metal .. "-" .. mold_type .. "-cooling",
      category = "snowfall-mold-cooling",
      ingredients = {
        {type = "item", name = "snowfall-" .. mold_type .. "-mold-" .. metal, amount = 1},
      },
      results = {
        {type = "item", name = "snowfall-" .. metal .. "-" .. mold_type, amount = 1}
      },
      energy_required = 6.4
    }
  }
end

data:extend{
  -- the category itself
  {
    type = "recipe-category",
    name = "snowfall-mold-cooling"
  },
}

cooling("iron", "ingot")
cooling("iron", "gear")
cooling("iron", "rod")
cooling("copper", "ingot")
cooling("copper", "gear")
cooling("copper", "rod")

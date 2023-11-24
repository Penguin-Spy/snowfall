local graphics = "__snowfall__/graphics/"

data:extend{
  -- subgroups
  {
    type = "item-subgroup",
    name = "snowfall-molds",
    group = "intermediate-products",
    order = "c-a"  -- after raw-material
  },

  -- resources
  {
    type = "item",
    name = "ice",
    icon = graphics .. "icons/ice.png", icon_size = 64,
    subgroup = "raw-resource",
    order = "c[ice]",  -- before stone
    stack_size = 100
  },
  {
    type = "item",
    name = "snowfall-kaolinite",
    icon = graphics .. "icons/kaolinite.png", icon_size = 64,
    subgroup = "raw-resource",
    order = "c[kaolinite]",  -- before stone
    stack_size = 50
  },
  {
    type = "item",
    name = "snowfall-fire-brick",
    icon = graphics .. "icons/fire-brick.png", icon_size = 64,
    subgroup = "raw-material",
    order = "a[fire-brick]",  -- before iron plate
    stack_size = 50
  },

  -- molds
  {
    type = "item",
    name = "snowfall-ingot-mold",
    icon = graphics .. "icons/placeholder.png", icon_size = 64,
    subgroup = "snowfall-molds",
    order = "a",
    stack_size = 10
  },
  {
    type = "item",
    name = "snowfall-gear-mold",
    icon = graphics .. "icons/placeholder.png", icon_size = 64,
    subgroup = "snowfall-molds",
    order = "b",
    stack_size = 10
  },
  {
    type = "item",
    name = "snowfall-rod-mold",
    icon = graphics .. "icons/placeholder.png", icon_size = 64,
    subgroup = "snowfall-molds",
    order = "c",
    stack_size = 10
  },

  -- entities
  {
    type = "item",
    name = "snowfall-kiln",
    icon = "__base__/graphics/icons/stone-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "smelting-machine",
    order = "d[snowfall]-a",
    place_result = "snowfall-kiln",
    stack_size = 50
  },
  {
    type = "item",
    name = "snowfall-foundry",
    icon = "__base__/graphics/icons/stone-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "smelting-machine",
    order = "d[snowfall]-b",
    place_result = "snowfall-foundry",
    stack_size = 50
  },
  {
    type = "item",
    name = "snowfall-solid-heat-exchanger",
    icon = "__base__/graphics/icons/heat-boiler.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "smelting-machine",
    order = "d[snowfall]-c",
    place_result = "snowfall-solid-heat-exchanger",
    stack_size = 50
  },
}

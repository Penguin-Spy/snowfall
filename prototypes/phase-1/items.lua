local graphics = "__snowfall__/graphics/"

data:extend{
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
    subgroup = "processed-stone",
    order = "b-a[fire-brick]",  -- between stone brick & silica
    stack_size = 50
  },

  -- molds
  {
    type = "item",
    name = "snowfall-ingot-mold",
    icon = graphics .. "icons/placeholder.png", icon_size = 64,
    subgroup = "processed-stone",
    order = "c[snowfall-molds]-a",
    stack_size = 10
  },
  {
    type = "item",
    name = "snowfall-gear-mold",
    icon = graphics .. "icons/placeholder.png", icon_size = 64,
    subgroup = "processed-stone",
    order = "c[snowfall-molds]-b",
    stack_size = 10
  },
  {
    type = "item",
    name = "snowfall-rod-mold",
    icon = graphics .. "icons/placeholder.png", icon_size = 64,
    subgroup = "processed-stone",
    order = "c[snowfall-molds]-c",
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
    name = "snowfall-rolling-machine",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "production-machine",
    order = "c-a[snowfall]-a",  -- after assembler 3
    place_result = "snowfall-rolling-machine",
    stack_size = 50
  },
  {
    type = "item",
    name = "snowfall-drawing-machine",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "production-machine",
    order = "c-a[snowfall]-b",
    place_result = "snowfall-drawing-machine",
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

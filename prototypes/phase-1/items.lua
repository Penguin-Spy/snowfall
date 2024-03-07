local graphics = data_util.graphics

local graphics_BrassTacks = "__BrassTacks__/graphics/galdoc/icons/"
local graphics_ThemTharHills = "__ThemTharHills__/graphics/icons/"
local graphics_bzlead = "__bzlead__/graphics/icons/"
local graphics_bztitanium = "__bztitanium__/graphics/icons/"

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

  -- ingots
  {
    type = "item",
    name = "iron-ingot",
    icon = graphics .. "icons/iron-ingot.png", icon_size = 64,
    subgroup = "ingots",
    order = data.raw.item["iron-plate"].order,
    stack_size = 50
  },
  {
    type = "item",
    name = "copper-ingot",
    icon = graphics .. "icons/copper-ingot.png", icon_size = 64,
    subgroup = "ingots",
    order = data.raw.item["copper-plate"].order,
    stack_size = 50
  },
  {
    type = "item",
    name = "lead-ingot",
    icon = graphics_bzlead .. "lead-ingot.png", icon_size = 128,
    subgroup = "ingots",
    order = data.raw.item["lead-plate"].order,
    stack_size = 50
  },
  {
    type = "item",
    name = "zinc-ingot",
    icon = graphics_BrassTacks .. "zinc-ingot.png", icon_size = 64,
    subgroup = "ingots",
    order = data.raw.item["zinc-plate"].order,
    stack_size = 50
  },
  {
    type = "item",
    name = "gold-ingot",
    icon = graphics_ThemTharHills .. "gold-ingot.png", icon_size = 64,
    subgroup = "ingots",
    order = data.raw.item["gold-plate"].order,
    stack_size = 50
  },
  {
    type = "item",
    name = "titanium-ingot",
    icon = graphics_bztitanium .. "titanium-ingot.png", icon_size = 128,
    subgroup = "ingots",
    order = data.raw.item["titanium-plate"].order,
    stack_size = 50
  },
  {
    type = "item",
    name = "brass-ingot",
    icon = graphics_BrassTacks .. "brass-ingot.png", icon_size = 64,
    subgroup = "ingots",
    order = data.raw.item["brass-plate"].order,
    stack_size = 50
  },

  -- rods
  {
    type = "item",
    name = "copper-rod",
    icon = graphics .. "icons/copper-rod.png", icon_size = 64,
    subgroup = "intermediate-product",
    order = data.raw.item["copper-plate"].order,
    stack_size = 50
  },
  {
    type = "item",
    name = "gold-rod",
    icon = graphics .. "icons/gold-rod.png", icon_size = 64,
    subgroup = "intermediate-product",
    order = data.raw.item["gold-plate"].order,
    stack_size = 50
  },

  -- intermediates
  {
    type = "item",
    name = "motor",
    icon = graphics .. "icons/motor.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "intermediate-product",
    order = "a",
    stack_size = 50
  },
  {
    type = "item",
    name = "basic-gear",  -- gear actually made from iron. the brass one is "iron-gear-wheel" (the vanilla name) so other mods use it by default
    icon = "__base__/graphics/icons/iron-gear-wheel.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "intermediate-product",
    order = "b",
    stack_size = 100
  },

  ---- entities ----

  -- drills
  {
    type = "item",
    name = "snowfall-burner-ice-bore",
    icons = {
      {icon = "__base__/graphics/icons/burner-mining-drill.png", icon_size = 64, icon_mipmaps = 4, tint = {r = 0.7, g = 0.85, b = 1, a = 1}}
    },
    subgroup = "extraction-machine",
    order = "a[items]-a[burner-mining-drill]-a",
    place_result = "snowfall-burner-ice-bore-placer",
    stack_size = 50
  }  --[[@as data.ItemPrototype]],

  -- machines
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

if mods["IfNickel"] then
  data:extend{
    {
      type = "item",
      name = "nickel-ingot",
      icon = "__IfNickel__/graphics/items/nickel-ingot.png", icon_size = 64,
      subgroup = "ingots",
      order = data.raw.item["nickel-plate"].order,
      stack_size = 50
    },
    {
      type = "item",
      name = "invar-ingot",
      icon = "__IfNickel__/graphics/items/invar-ingot.png", icon_size = 64,
      subgroup = "ingots",
      order = data.raw.item["invar-plate"].order,
      stack_size = 50
    }
  }
end

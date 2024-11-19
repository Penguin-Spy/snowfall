local graphics = data_util.graphics

local graphics_BrassTacks = "__BrassTacks__/graphics/galdoc/icons/"
local graphics_ThemTharHills = "__ThemTharHills__/graphics/icons/"
local graphics_bzlead = "__bzlead__/graphics/icons/"
local graphics_bztitanium = "__bztitanium__/graphics/icons/"

data:extend{
  -- temporary item definitions, while waiting for brevven and planetfall to update their mods
  {
    type = "item",
    name = "lead-ore",
    icon = graphics .. "temporary-icons/lead-ore.png",
    subgroup = "raw-resource",
    order = "c",
    stack_size = 100
  },
  {
    type = "item",
    name = "zinc-ore",
    icon = graphics .. "temporary-icons/zinc-ore.png",
    subgroup = "raw-resource",
    order = "d",
    stack_size = 100
  },
  {
    type = "item",
    name = "nickel-ore",
    icon = graphics .. "temporary-icons/nickel-ore.png",
    subgroup = "raw-resource",
    order = "e",
    stack_size = 100
  },
  {
    type = "item",
    name = "lead-plate",
    icon = graphics .. "temporary-icons/lead-plate.png",
    subgroup = "raw-material",
    order = "c",
    stack_size = 100
  },
  {
    type = "item",
    name = "zinc-plate",
    icon = graphics .. "temporary-icons/zinc-plate.png",
    subgroup = "raw-material",
    order = "d",
    stack_size = 100
  },
  {
    type = "item",
    name = "nickel-plate",
    icon = graphics .. "temporary-icons/nickel-plate.png",
    subgroup = "raw-material",
    order = "e",
    stack_size = 100
  },
  -- end temp items
  
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
  {
    type = "item",
    name = "slag",
    icon = graphics .. "icons/slag.png", icon_size = 64,
    subgroup = "raw-resource",
    order = "c[slag]",
    stack_size = 50
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
  --[[{ --?
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
    name = "nickel-ingot",
    icon = "__IfNickel__/graphics/icons/nickel-ingot.png", icon_size = 64,
    subgroup = "ingots",
    order = data.raw.item["nickel-plate"].order,
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
  {
    type = "item",
    name = "invar-ingot",
    icon = "__IfNickel__/graphics/icons/invar-ingot.png", icon_size = 64,
    subgroup = "ingots",
    order = data.raw.item["invar-plate"].order,
    stack_size = 50
  },]]

  -- rods
  --[[{ --?
    type = "item",
    name = "copper-rod",
    icon = graphics .. "icons/copper-rod.png", icon_size = 64,
    subgroup = "intermediate-product",
    order = data.raw.item["copper-plate"].order,
    stack_size = 50
  },
  {
    type = "item",
    name = "nickel-rod",
    icon = graphics .. "icons/nickel-rod.png", icon_size = 64,
    subgroup = "intermediate-product",
    order = data.raw.item["nickel-plate"].order,
    stack_size = 50
  },
  {
    type = "item",
    name = "gold-rod",
    icon = graphics .. "icons/gold-rod.png", icon_size = 64,
    subgroup = "intermediate-product",
    order = data.raw.item["gold-plate"].order,
    stack_size = 50
  },]]

  -- intermediates
  {
    type = "item",
    name = "basic-gear",  -- gear made from nickel. the brass one is "iron-gear-wheel" (the vanilla name) so other mods use it by default
    icon = "__base__/graphics/icons/iron-gear-wheel.png",
    subgroup = "intermediate-product",
    order = "a[basic-intermediates]-a[basic-gear]",
    stack_size = 100
  },
  {
    type = "item",
    name = "snowfall-gearbox",
    icon = graphics .. "/icons/gearbox.png",
    subgroup = "intermediate-product",
    order = "a[basic-intermediates]-b[gearbox]",
    stack_size = 100
  },

  -- science items
  {
    type = "item",
    name = "snowfall-internal-mineral-survey",
    localised_name = {"technology-name.snowfall-mineral-survey"},
    icon = "__base__/graphics/icons/science.png",
    subgroup = "science-pack",
    order = "z",
    stack_size = 1,
    hidden = true
  },
  {
    type = "tool",
    name = "snowfall-material-punchcard",
    icon = graphics .. "icons/material-punchcard.png",
    subgroup = "science-pack",
    order = "a",
    stack_size = 100,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value"
  }  --[[@as data.ToolPrototype]],

  ---- entities ----

  -- drills
  {
    type = "item",
    name = "snowfall-burner-ice-bore",
    icons = {
      { icon = "__base__/graphics/icons/burner-mining-drill.png", tint = { r = 0.7, g = 0.85, b = 1, a = 1 } }
    },
    subgroup = "extraction-machine",
    order = "a[items]-a[burner-mining-drill]-a",
    place_result = "snowfall-burner-ice-bore-placer",
    stack_size = 50
  }  --[[@as data.ItemPrototype]],
  {
    type = "item",
    name = "snowfall-steam-vent-cap",
    icons = {
      { icon = "__base__/graphics/icons/pumpjack.png", tint = { r = 0.7, g = 0.85, b = 1, a = 1 } }
    },
    subgroup = "extraction-machine",
    order = "a[items]-b[pumpjack]-a[steam-vent-cap]",
    place_result = "snowfall-steam-vent-cap",
    stack_size = 50
  }  --[[@as data.ItemPrototype]],
  {
    type = "item",
    name = "snowfall-steam-vent-turbine",
    icons = {
      { icon = "__base__/graphics/icons/steam-turbine.png", tint = { r = 0.7, g = 0.85, b = 1, a = 1 } }
    },
    subgroup = "extraction-machine",
    order = "a[items]-b[pumpjack]-b[steam-vent-turbine]",
    place_result = "snowfall-steam-vent-turbine-placer",
    stack_size = 50
  }  --[[@as data.ItemPrototype]],

  -- machines
  {
    type = "item",
    name = "snowfall-pneumatic-lab",
    icons = { { icon = "__base__/graphics/icons/lab.png", icon_size = 64, icon_mipmaps = 4 } },
    subgroup = "production-machine",
    order = "gA",  -- vanilla lab is "g[lab]"
    place_result = "snowfall-pneumatic-lab",
    stack_size = 10
  },
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
  --[[{
    type = "item",
    name = "snowfall-foundry",
    icon = "__base__/graphics/icons/stone-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "smelting-machine",
    order = "d[snowfall]-b",
    place_result = "snowfall-foundry",
    stack_size = 50
  },]]
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

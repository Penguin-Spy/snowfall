data:extend{
  -- pure fluids & gases
  {
    type = "fluid",
    name = "methane",
    icon = data_util.graphics .. "icons/methane.png",
    default_temperature = -179,
    gas_temperature = -161.5,
    heat_capacity = "0.1kJ",
    base_color = {r = 0.25, g = 0.25, b = 0.25},
    flow_color = {r = 0.65, g = 0.65, b = 0.65},
    order = "a[fluid]-c[gas]-c[methane]",
    subgroup = "fluid"
  },
  {
    type = "fluid",
    name = "oxygen",
    icon = data_util.graphics .. "icons/oxygen.png",
    default_temperature = 15,
    gas_temperature = -182.962,
    heat_capacity = "0.1kJ",  -- todo: figure out how to calculate heat capacities from real-life values
    base_color = {r = 0.65, g = 0.25, b = 0.25},
    flow_color = {r = 0.65, g = 0.25, b = 0.25},
    order = "a[fluid]-c[gas]-a[oxygen]",
    subgroup = "fluid"
  },
  {
    type = "fluid",
    name = "hydrogen",
    icon = data_util.graphics .. "icons/hydrogen.png",
    default_temperature = 15,
    gas_temperature = -252.879,
    heat_capacity = "0.1kJ",
    base_color = {r = 0.95, g = 0.95, b = 0.95},
    flow_color = {r = 0.95, g = 0.95, b = 0.95},
    order = "a[fluid]-c[gas]-b[hydrogen]",
    subgroup = "fluid"
  },

  -- mixed fluids & gases
  {
    type = "fluid",
    name = "snowfall-internal-methane-fuel-mix",
    icon = data_util.graphics .. "icons/methane.png",
    localised_name = {"fluid-name.methane"},
    hidden = true,
    factoriopedia_alternative = "methane",
    default_temperature = -179,
    gas_temperature = -161.5,
    heat_capacity = "0.1kJ",
    fuel_value = "20kJ",  -- 1000 units = half of coal
    base_color = {r = 0.35, g = 0.25, b = 0.25},
    flow_color = {r = 0.70, g = 0.65, b = 0.65},
    order = "a[fluid]-c[gas]-d[methane-fuel-mix]",
    subgroup = "fluid",
    auto_barrel = false
  }
} --[[@as (data.FluidPrototype[])]]

-- see items.lua for the empty canister

---@param fluid data.FluidPrototype
---@return data.ItemPrototype
local function make_canister(fluid)
  local canister_item_name = fluid.name .. "-canister"
  local item = {
    type = "item",
    name = canister_item_name,
    localised_name = {"item-name.filled-canister", fluid.localised_name or {"fluid-name." .. fluid.name}},
    icons = {
      { icon = data_util.graphics .. "icons/pressurized-canister.png" },
      { icon = data_util.graphics .. "icons/pressurized-canister-mask.png", tint = fluid.base_color }
    },
    subgroup = "barrel",
    order = fluid.order,
    stack_size = 5
  } --[[@as data.ItemPrototype]]

  data:extend{
    item,
    {
      type = "recipe",
      name = canister_item_name,
      subgroup = "fill-barrel",
      order = fluid.order,
      category = "canister",
      ingredients = {
        { type = "item", name = "empty-canister", amount = 1, ignored_by_stats = 1 },
        { type = "fluid", name = fluid.name, amount = 50, ignored_by_stats = 50 }
      },
      results = {
        { type = "item", name = canister_item_name, amount = 1, ignored_by_stats = 1 }
      },
      allow_quality = false,
      allow_decomposition = false,
      hide_from_player_crafting = true,
      enabled = false,
      energy_required = 0.2
    }
  }

  return item
end

-- pressurized steam canister
local steam_canister = make_canister(data.raw.fluid["steam"])
steam_canister.burnt_result = "empty-canister"
steam_canister.fuel_category = "steam"
-- (temp - base temp) * heat capacity * units in a canister
steam_canister.fuel_value = tostring((200 - 15) * 200 * 50) .. "J" -- 1.85MJ

data:extend{
  { -- will have the correct icon due to the "tooltip-category-steam" sprite created by the base game
    type = "fuel-category",
    name = "steam",
  } --[[@as data.FuelCategory]],
  {
    type = "recipe-category",
    name = "canister"
  }
}

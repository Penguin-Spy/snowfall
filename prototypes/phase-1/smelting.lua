-- generates recipes & intermediate items for metal casting, cooling, and alloying

--[[
  lead    ore -> ingot -> plate

  copper  ore -> rod   -> wire

  nickel  ore -> ingot -> plate
              -> rod

  zinc + copper ore -> brass ingot -> plate
                    -> brass gear

  iron    ore -> ingot -> plate
              -> rod

  iron + nickel -> invar ingot -> plate

  gold    ore -> (fancy stuff, not in this file)
                  rod -> wire
]]

local mold_cast_costs = {
  ingot = 4,
  gear = 2,
  rod = 3
}

-- creates the direct-casting recipe & result item
---@param resource string
---@param mold string
local function smelting(resource, mold)
  data:extend{
    {
      type = "recipe",
      name = resource .. "-" .. mold,  -- "snowfall-" .. resource .. "-" .. mold .. "-direct-casting",
      category = "snowfall-direct-casting",
      ingredients = {
        {type = "item", name = resource .. "-ore",             amount = mold_cast_costs[mold]},
        {type = "item", name = "snowfall-" .. mold .. "-mold", amount = 1},
      },
      results = {
        {type = "item", name = resource .. "-" .. mold,        amount = 1},
        {type = "item", name = "snowfall-" .. mold .. "-mold", amount = 1, probability = 0.95}
      },
      main_product = resource .. "-" .. mold,
      energy_required = 3.2,
      allow_decomposition = false
    }
  }
end

-- creates just the direct-alloying recipe
---@param params {ingredients:table<string,integer>, result:string, mold:string, amount:integer?}
local function alloy(params)
  local result = params.result
  local mold = params.mold
  local result_amount = params.amount or 1

  local ingredients = {}
  for resource, amount in pairs(params.ingredients) do
    table.insert(ingredients, {
      type = "item", name = resource .. "-ore", amount = amount
    })
  end
  table.insert(ingredients, {type = "item", name = "snowfall-" .. mold .. "-mold", amount = 1})

  data:extend{
    {
      type = "recipe",
      name = result,  --"snowfall-" .. result .. "-" .. mold .. "-alloying",
      category = "snowfall-direct-alloying",
      ingredients = ingredients,
      results = {
        {type = "item", name = result,                         amount = result_amount},
        {type = "item", name = "snowfall-" .. mold .. "-mold", amount = 1,            probability = 0.95}
      },
      main_product = result,
      energy_required = 6.4,
      allow_decomposition = false
    }
  }
end


data:extend{
  {
    type = "recipe-category",
    name = "snowfall-direct-casting"  -- ore -> result
  },
  {
    type = "recipe-category",
    name = "snowfall-direct-alloying"  -- ore + ore -> result
  },
  {
    type = "recipe-category",
    name = "snowfall-advanced-smelting"  -- ore -> molten ore
  },
  {
    type = "recipe-category",
    name = "snowfall-advanced-casting"  -- molten resource (ore|alloy) -> result
  },
  {
    type = "recipe-category",
    name = "snowfall-advanced-alloying"  -- ore + ore -> molten alloy
  },
}

smelting("lead", "ingot")      -- item-name.lead-ingot
smelting("copper", "ingot")    -- item-name.copper-ingot
smelting("copper", "rod")      -- item-name.copper-rod
smelting("iron", "ingot")      -- item-name.iron-ingot
--smelting("iron", "rod")        -- item-name.iron-rod
smelting("zinc", "ingot")      -- item-name.zinc-ingot
smelting("gold", "rod")        -- item-name.gold-rod
smelting("titanium", "ingot")  -- item-name.titanium-ingot


alloy{  -- item-name.brass-ingot
  ingredients = {copper = 3, zinc = 1},
  result = "brass-ingot", amount = 2,
  mold = "ingot"
}
alloy{  -- item-name.iron-gear-wheel
  ingredients = {copper = 3, zinc = 1},
  result = "iron-gear-wheel", amount = 2,
  mold = "gear"
}


if mods["IfNickel"] then
  smelting("nickel", "ingot")  -- item-name.nickel-ingot
  smelting("nickel", "rod")    -- item-name.nickel-rod

  alloy{                       -- item-name.invar-ingot
    ingredients = {iron = 2, nickel = 2},
    result = "invar-ingot", amount = 2,
    mold = "ingot"
  }
end

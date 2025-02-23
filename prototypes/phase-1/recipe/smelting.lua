---@param name string
---@return data.RecipePrototype
local function smelt(name)
  return {
    type = "recipe",
    name = name .. "-plate",
    energy_required = 3.2,
    category = "smelting",
    ingredients = {
      {type = "item", name = name .. "-ore", amount = 1}
    },
    results = {
      {type = "item", name = name .. "-plate", amount = 1},
      {type = "item", name = "slag",           amount = 1, probability = 0.5}
    },
    main_product = name .. "-plate"
  }
end

---@param first string
---@param first_amount number
---@param second string
---@param second_amount number
---@param result string
---@param result_amount number
---@return data.RecipePrototype
local function alloy(first, first_amount, second, second_amount, result, result_amount)
  return {
    type = "recipe",
    name = result,
    energy_required = 16,
    category = "alloying",
    ingredients = {
      {type = "item", name = first .. "-ore",  amount = first_amount},
      {type = "item", name = second .. "-ore", amount = second_amount}
    },
    results = {
      {type = "item", name = result, amount = result_amount},
      {type = "item", name = "slag", amount = 1,            probability = 0.5}
    },
    main_product = result
  }
end

data:extend{
  smelt("iron"),
  smelt("lead"),
  smelt("copper"),
  smelt("zinc"),
  smelt("nickel"),
  alloy("copper", 2, "zinc", 1, "brass-plate", 3),
  --?alloy("nickel", 2, "iron", 2, "invar-plate", 2)
}  --[=[@as data.RecipePrototype[]]=]

data:extend{{
  type = "recipe-category",
  name = "alloying"
}}
data:extend{
  {
    type = "recipe-category",
    name = "rolling"
  },
  {
    type = "recipe-category",
    name = "wire-drawing"
  }
}

local function rolling(metal)
  local ingredient_name = metal .. "-ingot"
  local result_name = metal .. "-plate"
  data:extend{
    {
      type = "recipe",
      name = "snowfall-rolling-" .. result_name,
      category = "rolling",
      hide_from_player_crafting = true,
      ingredients = {
        {type = "item", name = ingredient_name, amount = 1}
      },
      results = {
        {type = "item", name = result_name, amount = 2}
      },
      energy_required = 2
    }  --[[@as data.RecipePrototype]]
  }
end

--?rolling("iron")
--?rolling("copper")
--?rolling("zinc")
--?rolling("lead")
--?rolling("nickel")
--?--rolling("gold")
--?rolling("brass")
--?--rolling("steel")  -- ?
--?rolling("invar")

local function drawing(metal, result_name)
  local ingredient_name = metal .. "-rod"
  data:extend{
    {
      type = "recipe",
      name = "snowfall-drawing-" .. result_name,
      category = "wire-drawing",
      hide_from_player_crafting = true,
      ingredients = {
        {type = "item", name = ingredient_name, amount = 1}
      },
      results = {
        {type = "item", name = result_name, amount = 2}
      },
      energy_required = 2
    }  --[[@as data.RecipePrototype]]
  }
end

--?drawing("copper", "copper-cable")
--?drawing("gold", "gold-wire")

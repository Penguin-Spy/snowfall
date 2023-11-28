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
      name = result_name,
      category = "rolling",
      ingredients = {
        {type = "item", name = ingredient_name, amount = 1}
      },
      results = {
        {type = "item", name = result_name, amount = 2}
      },
      energy_required = 2
    }
  }
end

rolling("iron")
rolling("copper")
rolling("zinc")
rolling("lead")
--rolling("gold")
rolling("brass")
--rolling("steel")  -- ?

if mods["IfNickel"] then
  rolling("nickel")
  rolling("invar")
end

local function drawing(metal, result_name)
  local ingredient_name = metal .. "-rod"
  data:extend{
    {
      type = "recipe",
      name = result_name,
      category = "wire-drawing",
      ingredients = {
        {type = "item", name = ingredient_name, amount = 1}
      },
      results = {
        {type = "item", name = result_name, amount = 2}
      },
      energy_required = 2
    }
  }
end

drawing("copper", "copper-cable")
drawing("gold", "gold-wire")

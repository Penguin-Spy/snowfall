-- [[ Coal ]]
-- remove coal
data.raw["resource-category"]["coal"] = nil
data_util.remove_autoplace("resource", "coal")
data.raw["resource"]["coal"] = nil
data.raw["item"]["coal"] = nil
-- remove uses of coal
-- todo: figure out chemistry prerequisites needed to make polyproplyene
data.raw.recipe["plastic-bar"].ingredients = {
  {type = "fluid", name = "methane", amount = 20}
}
data.raw["recipe"]["coal-liquefaction"] = nil
data.raw["technology"]["coal-liquefaction"] = nil
data_util.remove_recipe_ingredient("grenade", "coal")
data_util.remove_recipe_ingredient("poison-capsule", "coal")
data_util.remove_recipe_ingredient("slowdown-capsule", "coal")
data_util.remove_recipe_ingredient("explosives", "coal")

-- Oil
data_util.remove_autoplace("resource", "crude-oil")

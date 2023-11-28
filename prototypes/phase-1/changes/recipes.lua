-- modify formaldehyde recipe
data_util.replace_recipe_ingredients("formaldehyde", {
  {type = "fluid", name = "methane", amount = 10}
})
data_util.replace_recipe_results("formaldehyde", {
  {type = "fluid", name = "formaldehyde", amount = 10}  -- change count from 9 to 10
})

-- modify phenol recipe, unlock, & technology
data_util.replace_recipe_ingredients("phenol", {
  {type = "fluid", name = "methane", amount = 10},
  {type = "fluid", name = "steam",   amount = 10}  --, minimum_temperature = 100}
})
data.raw["recipe"]["phenol"].category = "chemistry"
data_util.remove_technology_recipe_unlock("automation", "phenol")
data_util.add_technology_recipe_unlock("basic-chemistry", "phenol")
data.raw["technology"]["basic-chemistry"].prerequisites = {"silica-processing"}

-- make wooden chest stone
data_util.replace_recipe_ingredients("wooden-chest", {
  {type = "item", name = "stone-brick", amount = 4}
})


-- [[ remove unneeded items/recipes ]]
data.raw["item"]["brass-precursor"] = nil
data.raw["recipe"]["brass-precursor"] = nil

if mods["IfNickel"] then
  data.raw["item"]["invar-precursor"] = nil
  data.raw["recipe"]["invar-precursor"] = nil

  data_util.remove_technology_recipe_unlock("invar-processing", "invar-precursor")
end

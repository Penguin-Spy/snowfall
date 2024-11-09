--[[ data_util.lua © Penguin_Spy 2023
  General utilities for modifying prototypes, handling shorthand forms and edge cases.
]]

-- appends the snowfall mod prefix, including the hyphen (`snowfall-`)
---@param name string
---@return string
local function prefix(name)
  return "snowfall-" .. name
end

-- removes the `unlock-recipe` effect for the recipe from the technology
---@param technology_name string
---@param recipe string
local function remove_technology_recipe_unlock(technology_name, recipe)
  local technology = data.raw.technology[technology_name]
  if not technology then error("[snowfall.data_util] unknown technology: '" .. tostring(technology_name) .. "', cannot remove recipe unlock '" .. tostring(recipe) .. "' from it!") end
  local effects = technology.effects
  if effects then
    for i, effect in pairs(effects) do
      if effect.type == "unlock-recipe" and effect.recipe == recipe then
        effects[i] = nil
      end
    end
  else
    for i, effect in pairs(technology.normal.effects) do
      if effect.type == "unlock-recipe" and effect.recipe == recipe then
        effects[i] = nil
      end
    end
    for i, effect in pairs(technology.expensive.effects) do
      if effect.type == "unlock-recipe" and effect.recipe == recipe then
        effects[i] = nil
      end
    end
  end
end

-- adds an `unlock-recipe` effect for the recipe to the technology
---@param technology_name string
---@param recipe string
local function add_technology_recipe_unlock(technology_name, recipe)
  local technology = data.raw.technology[technology_name]
  if not technology then error("[snowfall.data_util] unknown technology: '" .. tostring(technology_name) .. "', cannot add recipe unlock '" .. tostring(recipe) .. "' to it!") end
  local effects = technology.effects
  if effects then
    table.insert(effects, { type = "unlock-recipe", recipe = recipe })
  else
    table.insert(technology.normal.effects, { type = "unlock-recipe", recipe = recipe })
    table.insert(technology.expensive.effects, { type = "unlock-recipe", recipe = recipe })
  end
end

-- internal function to handle the ingredients shorthand
---@param array data.IngredientPrototype[]
---@param name string
---@param ingredient_type string?
local function remove_from_ingredients_array(array, name, ingredient_type)
  for i, ingredient in pairs(array) do
    if ingredient[1] and ingredient[1] == name then  -- shorthand formt 👎
      array[i] = nil
    else
      if ingredient.name == name and  -- full format + optional type check
          (not ingredient_type or ingredient.type == ingredient_type) then
        array[i] = nil
      end
    end
  end
end

-- removes an ingredient from a recipe
---@param recipe_name string
---@param ingredient_name string
---@param ingredient_type string? if not specified, removes both `item` and `fluid` ingredients with matching names
local function remove_recipe_ingredient(recipe_name, ingredient_name, ingredient_type)
  local recipe = data.raw.recipe[recipe_name]
  if not recipe then error("[snowfall.data_util] unknown recipe: '" .. tostring(recipe) .. "', cannot remove ingredient '" .. tostring(ingredient_name) .. "' from it!") end
  local ingredients = recipe.ingredients
  if ingredients then
    remove_from_ingredients_array(ingredients, ingredient_name, ingredient_type)
  else
    remove_from_ingredients_array(recipe.normal.ingredients, ingredient_name, ingredient_type)
    remove_from_ingredients_array(recipe.expensive.ingredients, ingredient_name, ingredient_type)
  end
end

-- adds an ingredient to a recipe
---@param recipe_name string
---@param ingredient data.IngredientPrototype
local function add_recipe_ingredient(recipe_name, ingredient)
  local recipe = data.raw.recipe[recipe_name]
  if not recipe then
    local name, type, amount = ingredient.name, ingredient.type, ingredient.amount
    error("[snowfall.data_util] unknown recipe: '" .. tostring(recipe) .. "', cannot add ingredient '"
      .. tostring(name) .. "' ('" .. tostring(type) .. "') x" .. tostring(amount) .. " to it!")
  end
  local ingredients = recipe.ingredients
  if ingredients then
    table.insert(ingredients, ingredient)
  else
    table.insert(recipe.normal.ingredients, ingredient)
    table.insert(recipe.expensive.ingredients, ingredient)
  end
end

-- replaces the recipes' ingredients. removes normal/expensive distinction.
---@param recipe_name string
---@param ingredients data.IngredientPrototype[]
local function replace_recipe_ingredients(recipe_name, ingredients)
  local recipe = data.raw.recipe[recipe_name]
  if not recipe then error("[snowfall.data_util] unknown recipe: '" .. tostring(recipe) .. "', cannot replace ingredients!") end
  recipe.normal = nil
  recipe.expensive = nil
  recipe.ingredients = ingredients
end


-- replaces the recipes' results. clears the .result and .result_count shorthand
---@param recipe_name string
---@param results data.ProductPrototype[]
local function replace_recipe_results(recipe_name, results)
  local recipe = data.raw.recipe[recipe_name]
  if not recipe then error("[snowfall.data_util] unknown recipe: '" .. tostring(recipe) .. "', cannot replace results!") end
  recipe.result = nil
  recipe.result_count = nil
  recipe.results = results
end

-- generates a dummy "placer entity" to use it's placement restrictions for a different entity type
---@param entity_to_place data.EntityPrototype  the prototype table for the entity to mimic
---@param placer_prototype string               the type string for the entity that gets placed
---@param additional_properties data.EntityPrototype           additional properties to assign to the placer prototype
---@return data.EntityPrototype
local function generate_placer(entity_to_place, placer_prototype, additional_properties)
  local placer = table.deepcopy(entity_to_place)

  placer.type = placer_prototype
  placer.name = entity_to_place.name .. "-placer"
  placer.localised_name = { "entity-name." .. entity_to_place.name }
  placer.localised_description = { "entity-description." .. entity_to_place.name }

  for k, v in pairs(additional_properties) do
    placer[k] = v
  end

  return placer
end

-- creates a script trigger effect table
---@param effect_id string
---@return data.Trigger
local function created_effect(effect_id)
  ---@type data.Trigger
  return {
    type = "direct",
    action_delivery = {
      type = "instant",
      source_effects = {
        type = "script",
        effect_id = effect_id,
      }
    }
  }
end

return {
  --- the graphics path prefix, including the final slash
  graphics = "__snowfall__/graphics/",
  prefix = prefix,
  remove_technology_recipe_unlock = remove_technology_recipe_unlock,
  add_technology_recipe_unlock = add_technology_recipe_unlock,
  remove_recipe_ingredient = remove_recipe_ingredient,
  add_recipe_ingredient = add_recipe_ingredient,
  replace_recipe_ingredients = replace_recipe_ingredients,
  replace_recipe_results = replace_recipe_results,
  generate_placer = generate_placer,
  created_effect = created_effect,

  -- include some convenient requires from base
  sounds = require("__base__.prototypes.entity.sounds"),
  hit_effects = require("__base__.prototypes.entity.hit-effects"),
}

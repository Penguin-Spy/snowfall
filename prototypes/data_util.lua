--[[ data_util.lua © Penguin_Spy 2023-2024
  General utilities for modifying prototypes.
]]

local data_util = {
  --- the graphics path prefix, including the final slash
  graphics = "__snowfall__/graphics/",

  -- include some convenient requires from base
  sounds = require("__base__.prototypes.entity.sounds"),
  hit_effects = require("__base__.prototypes.entity.hit-effects")
}

-- removes the `unlock-recipe` effect for the recipe from the technology
---@param technology_name string
---@param recipe string
function data_util.remove_technology_recipe_unlock(technology_name, recipe)
  local technology = data.raw.technology[technology_name]
  if not technology then error("[snowfall.data_util] unknown technology: '" .. tostring(technology_name) .. "', cannot remove recipe unlock '" .. tostring(recipe) .. "' from it!") end
  for i, effect in pairs(technology.effects) do
    if effect.type == "unlock-recipe" and effect.recipe == recipe then
      technology.effects[i] = nil
    end
  end
end

-- removes an ingredient from a recipe
---@param recipe_name string
---@param ingredient_name string
---@param ingredient_type string? if not specified, removes both `item` and `fluid` ingredients with matching names
function data_util.remove_recipe_ingredient(recipe_name, ingredient_name, ingredient_type)
  local recipe = data.raw.recipe[recipe_name]
  if not recipe then error("[snowfall.data_util] unknown recipe: '" .. tostring(recipe) .. "', cannot remove ingredient '" .. tostring(ingredient_name) .. "' from it!") end
  for i, ingredient in pairs(recipe.ingredients) do
    if ingredient.name == ingredient_name and  -- full format + optional type check
        (not ingredient_type or ingredient.type == ingredient_type) then
      table.remove(recipe.ingredients, i)
    end
  end
end

-- generates a dummy "placer entity" to use it's placement restrictions for a different entity type
---@param entity_to_place data.EntityPrototype  the prototype table for the entity to mimic
---@param placer_prototype string               the type string for the entity that gets placed
---@param additional_properties data.EntityPrototype           additional properties to assign to the placer prototype
---@return data.EntityPrototype
function data_util.generate_placer(entity_to_place, placer_prototype, additional_properties)
  local placer = table.deepcopy(entity_to_place)

  placer.type = placer_prototype
  placer.name = entity_to_place.name .. "-placer"
  placer.localised_name = { "entity-name." .. entity_to_place.name }
  placer.localised_description = { "entity-description." .. entity_to_place.name }
  placer.hidden = true

  for k, v in pairs(additional_properties) do
    placer[k] = v
  end

  return placer
end

-- creates a script trigger effect table
---@param effect_id string
---@return data.Trigger
function data_util.created_effect(effect_id)
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

function data_util.remove_autoplace(prototype_type, name, control_name, settings_name)
  control_name = control_name or name
  settings_name = settings_name or name
  local group = (prototype_type == "tile" and tile) or (prototype_type == "optimized-decorative" and "decorative") or "entity"

  -- remove entity's autoplace and the control prototype
  data.raw[prototype_type][name].autoplace = nil
  data.raw["autoplace-control"][control_name] = nil

  -- remove control & setting from map gen settings presets. unknown if settings is ever defined in a preset but ¯\_(ツ)_/¯
  for _, preset in pairs(data.raw["map-gen-presets"].default) do
    if type(preset) == "table" and preset.basic_settings then
      if preset.basic_settings.autoplace_controls then
        preset.basic_settings.autoplace_controls[control_name] = nil
      end
      if preset.basic_settings.autoplace_settings and preset.basic_settings.autoplace_settings[group] then
        preset.basic_settings.autoplace_settings[group].settings[settings_name] = nil
      end
    end
  end

  -- remove control & setting from planet map gen settings
  for _, planet in pairs(data.raw["planet"]) do
    if planet.map_gen_settings.autoplace_controls then
      planet.map_gen_settings.autoplace_controls[control_name] = nil
    end
    if planet.map_gen_settings.autoplace_settings and planet.map_gen_settings.autoplace_settings[group] then
      planet.map_gen_settings.autoplace_settings[group].settings[settings_name] = nil
    end
  end
end

return data_util

-- changes to vanilla/dependencies' prototypes

local function remove_technology_recipe_unlock(technology, recipe)
  local tech = data.raw.technology[technology]
  local effects = tech.effects
  if effects then
    for i, effect in pairs(effects) do
      if effect.type == "unlock-recipe" and effect.recipe == recipe then
        effects[i] = nil
      end
    end
  else
    for i, effect in pairs(tech.normal.effects) do
      if effect.type == "unlock-recipe" and effect.recipe == recipe then
        effects[i] = nil
      end
    end
    for i, effect in pairs(tech.expensive.effects) do
      if effect.type == "unlock-recipe" and effect.recipe == recipe then
        effects[i] = nil
      end
    end
  end
end

local function add_technology_recipe_unlock(technology, recipe)
  local tech = data.raw.technology[technology]
  local effects = tech.effects
  if effects then
    table.insert(effects, {type = "unlock-recipe", recipe = recipe})
  else
    table.insert(tech.normal.effects, {type = "unlock-recipe", recipe = recipe})
    table.insert(tech.expensive.effects, {type = "unlock-recipe", recipe = recipe})
  end
end

-- offshore pump methane
data.raw["offshore-pump"]["offshore-pump"].fluid = "methane"
data.raw["offshore-pump"]["offshore-pump"].fluid_box.filter = "methane"

-- mining stone produces kaolinite
data.raw["resource"]["stone"].minable.result = nil
data.raw["resource"]["stone"].minable.results = {
  {type = "item", name = "stone",              amount = 1},
  {type = "item", name = "snowfall-kaolinite", amount = 1, probability = 0.5},
}

-- replace coal in rocks with kaolinite
-- should also modify Alien Biomes' rocks
for _, simple_entity in pairs(data.raw["simple-entity"]) do
  if simple_entity.name:gmatch("-?rock%-?") then
    local minable = simple_entity.minable
    -- minable properties
    if minable then
      if minable.results then
        for _, result in pairs(simple_entity.minable.results) do
          if result.name == "coal" then
            result.name = "snowfall-kaolinite"
          end
        end
      elseif minable.result == "coal" then
        minable.result = "snowfall-kaolinite"
      end
    end
    -- loot properties (for killing (driving over) the rock)
    local loot = simple_entity.loot
    if loot then
      for _, entry in pairs(loot) do
        if entry.item == "coal" then
          entry.item = "snowfall-kaolinite"
        end
      end
    end
  end
end

-- burner mining drill powered by methane
data.raw["mining-drill"]["burner-mining-drill"].energy_source =
{
  type = "fluid",
  burns_fluid = true,
  scale_fluid_usage = true,
  effectivity = 1,
  emissions_per_minute = 12,
  fluid_box = {
    production_type = "input-output",
    filter = "methane",
    base_area = 1,   -- storage volume of 100 (base_area*height*100)
    height = 1,      -- default
    base_level = 0,  -- default
    pipe_connections = {
      {type = "input-output", position = {-1.5, 0.5}},
      {type = "input-output", position = {1.5, 0.5}},
    },
    secondary_draw_orders = {north = -1},
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
  },
  light_flicker = {color = {0, 0, 0}},
  smoke = {
    {
      name = "smoke",
      deviation = {0.1, 0.1},
      frequency = 3
    }
  }
}

-- [[ Natural Gas ]]

-- remove natural gas
data.raw["resource-category"]["gas"] = nil
data.raw["autoplace-control"]["gas"] = nil
data.raw["noise-layer"]["gas"] = nil
data.raw["resource"]["gas"] = nil
--data.raw["fluid"]["gas"] = nil
-- map-gen-presets changes are done in data-updates

-- remove extractor
-- todo: re-use for flash-steam geothermal wellhead?
data.raw["item"]["gas-extractor"] = nil
data.raw["recipe"]["gas-extractor"] = nil
data.raw["mining-drill"]["gas-extractor"] = nil
data.raw["technology"]["gas-extraction"] = nil

-- modify formaldehyde recipe
local formaldehyde = data.raw["recipe"]["formaldehyde"]
formaldehyde.ingredients = {
  {type = "fluid", name = "methane", amount = 10}
}
formaldehyde.results = {
  {type = "fluid", name = "formaldehyde", amount = 10}  -- change count from 9 to 10
}

-- modify phenol recipe, unlock, & technology
local phenol = data.raw["recipe"]["phenol"]
phenol.ingredients = {
  {type = "fluid", name = "methane", amount = 10},
  {type = "fluid", name = "steam",   amount = 10}  --, minimum_temperature = 100}
}
phenol.category = "chemistry"
remove_technology_recipe_unlock("automation", "phenol")
add_technology_recipe_unlock("basic-chemistry", "phenol")
data.raw["technology"]["basic-chemistry"].prerequisites = {"silica-processing"}



-- [[ remove unneeded items/recipes ]]
data.raw["item"]["brass-precursor"] = nil
data.raw["recipe"]["brass-precursor"] = nil
data.raw["item"]["invar-precursor"] = nil
data.raw["recipe"]["invar-precursor"] = nil

remove_technology_recipe_unlock("invar-processing", "invar-precursor")

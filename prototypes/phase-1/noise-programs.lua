data:extend{
  {
    type = "noise-function",
    name = "slider_to_linear_center",
    parameters = {"slider_value", "center", "deviation"},
    expression = "slider_to_linear(slider_value, center - deviation, center + deviation)"
  },
  {
    type = "noise-expression",
    name = "elevation",
    expression = "snowfall_elevation_combined_islands + snowfall_elevation_detail"
  },
  {
    type = "noise-expression",
    name = "snowfall_elevation_combined_islands",
    expression = "max(snowfall_elevation_islands_limited, snowfall_elevation_starting_island)"
  },
  {
    type = "noise-expression",
    name = "snowfall_elevation_islands_limited",
    expression = "snowfall_elevation_islands_limit * (snowfall_elevation_islands+1) - 1"
  },
  {
    type = "noise-expression",
    name = "snowfall_elevation_islands_limit",
    expression = "min(1,max(debug_scaled_distance/radius - 1,0))",
    local_expressions = {
      -- radius = "slider_to_linear_center(" .. noise_debug.temp_control("start", "scale") .. ", 500, 500)"
      radius = 1000,
    }
  },
  {
    type = "noise-expression",
    name = "snowfall_elevation_islands",
    -- output is 0+ (usually maxes out at 1, but can get higher in large cells)
    expression = [[1 - falloff * voronoi_spot_noise{
x = x * debug_thing_scale,
y = y * debug_thing_scale,
seed0 = map_seed,
seed1 = 1337,
grid_size = 400 * separation,
distance_type = 2,
jitter = 1}]],
    local_expressions = {
      -- falloff = "slider_to_linear_center(" .. noise_debug.temp_control("island", "scale") .. ", 4, 2)",
      falloff = 3,
      --separation = "slider_to_linear_center(" .. noise_debug.temp_control("island", "scale") .. ", 12, 4)",
      separation = 12,
    }
  },
  {
    type = "noise-expression",
    name = "snowfall_elevation_starting_island",
    expression = "1 - 2 * debug_scaled_distance * 1/radius",
    local_expressions = {
      -- radius = "slider_to_linear_center(" .. noise_debug.temp_control("start", "scale") .. ", 1000, 900)"
      radius = 1000,
    }
  },
  {
    type = "noise-expression",
    name = "snowfall_elevation_detail",
    -- output is -2 to about 3
    expression = "nauvis_detail * strength",
    local_expressions = {
      distance = "debug_scaled_distance",
      x = "x*debug_thing_scale",
      y = "y*debug_thing_scale",
      -- strength = "slider_to_linear_center(" .. noise_debug.temp_control("island", "coverage") .. ", 0.25, 0.25)", -- 0.125
      -- strength = "log2("..noise_debug.temp_control("island", "coverage")..")/16 + 0.25"
      strength = 1/16 + 0.25
    }
  },
  --[[{
    type = "noise-expression",
    name = "snowfall_elevation_macro",
    -- output is -1 to 1?
    expression = "nauvis_macro * strength",
    local_expressions = {
      strength = "slider_to_linear_center(" .. noise_debug.temp_control("macro", "coverage") .. ", 1, 0.9)",
    }
  },]]

  {
    type = "noise-expression",
    name = "debug_thing_scale",
    -- expression = "slider_to_linear(" .. noise_debug.temp_control("scale", "coverage") .. ", 0.1, 10)"
    expression = "1"
  },
  {
    type = "noise-expression",
    name = "debug_scaled_distance",
    expression = "distance * debug_thing_scale"
  },
  {
    type = "noise-expression",
    name = "nauvis_segmentation_multiplier",
    -- expression = "1.5 * control:water:frequency"
    expression = "1.5 * 1/6"
  },
  {
    type = "noise-expression",
    name = "nauvis_persistance",
    expression = "clamp(amplitude_corrected_multioctave_noise{x = x * debug_thing_scale,\z
                                                              y = y * debug_thing_scale,\z
                                                              seed0 = map_seed,\z
                                                              seed1 = 500,\z
                                                              octaves = 5,\z
                                                              input_scale = nauvis_segmentation_multiplier / 2,\z
                                                              offset_x = 10000 / nauvis_segmentation_multiplier,\z
                                                              persistence = 0.7,\z
                                                              amplitude = 0.5} + 0.55,\z
                      0.5, 0.65)"
  },
  {
    type = "noise-expression",
    name = "nauvis_detail", -- the small scale details with variable persistance for a mix of smooth and jagged coastline
    expression = "variable_persistence_multioctave_noise{x = x * debug_thing_scale,\z
                                                         y = y * debug_thing_scale,\z
                                                         seed0 = map_seed,\z
                                                         seed1 = 600,\z
                                                         input_scale = nauvis_segmentation_multiplier / 14,\z
                                                         output_scale = 0.03,\z
                                                         offset_x = 10000 / nauvis_segmentation_multiplier,\z
                                                         octaves = 5,\z
                                                         persistence = nauvis_persistance}"
  },
}

-- spot 0 is squares
-- spot 1 is diagonal squares
-- spot 2 is round cells
-- spot 3 is squircle cells
-- facet 0 is smoother evil
-- facet 1 is less evil
-- facet 2 is paralellograms
-- facet 3 is lumpy paralellograms
-- pyramid 0,1,2 are weird (2 is smooth, 0&1 are "evil")

-- remove other elevation types
data.raw["noise-expression"]["elevation_lakes"].intended_property = nil
data.raw["noise-expression"]["elevation_island"] = nil



data:extend{
  {
    type = "noise-expression",
    name = "temperature",
    intended_property = "temperature",
    -- temperature should be a range of -50 to 50
    -- output scale of 2.5 to adjust from a range of ±20 to ±50   (* 33% to make it actually work)
    -- Scale = control:cold:frequency
    -- Coverage = control:cold:size
    expression = [[clamp(quick_multioctave_noise{
  x = x,
  y = y,
  seed0 = map_seed,
  seed1 = 5,
  octaves = 4,
  input_scale = var('control:cold:frequency') / 32,
  output_scale = 0.825 * var('control:cold:size'),
  offset_x = 40000 / var('control:cold:frequency'),
  octave_output_scale_multiplier = 3,
  octave_input_scale_multiplier = 1/3
} * min(1, 0.5 * tier_from_start) - 10, -50, 50)]] -- if within the starting area, force temperature to be -50
  } -- (60 * starting_area_weight)
}

-- locale key provided by alien biomes
data.raw["autoplace-control"]["cold"].localised_name = {"autoplace-control-names.temperature"}
-- these control things that have been removed, but can't be hidden without outright removing them (which breaks a lot of autoplace stuff)
--data.raw["autoplace-control"]["trees"].hidden = true
--data.raw["autoplace-control"]["hot"].hidden = true
-- it doesn't seem like alien biomes uses this one at all
--data.raw["autoplace-control"]["starting_area_moisture"].hidden = true

-- put starting area resources closer
data.raw["noise-function"]["resource_autoplace_all_patches"].local_expressions.starting_resource_placement_radius = 60
data.raw["noise-function"]["resource_autoplace_all_patches"].local_expressions.starting_patches_split = 1
-- remove the starting lake (it's methane now, which we don't need early game)
data.raw["noise-function"]["elevation_nauvis_function"].expression = "wlc_elevation" -- originally "min(wlc_elevation, starting_lake)"


--[[
-- alien biomes biome temperature ranges
  ice:               -50 - 0     -25 ± 25
  black mineral:      0  - 30     15 ± 15
  grey mineral:       0  - 30     15 ± 15
  white mineral       0  - 30     15 ± 15
  aubergine mineral:  30 - 60     45 ± 15
  dustyrose mineral:  30 - 60     45 ± 15
  
  shallow water:     -20 - 100    40 ± 60
  marsh:              0  - 100    50 ± 50

  (not used)
  beige mineral:      30 - 60
  cream mineral:      30 - 60
  brown mineral:      60 - 100
  purple mineral:     60 - 100
  red mineral:        60 - 100
  tan mineral:        60 - 100
  violet mineral:     60 - 100
]]

-- remove vegetation (not using the alien biomes setting, since it prints an annoying message at the start of the game)
local nauvis_map_gen = data.raw.planet.nauvis.map_gen_settings ---@cast nauvis_map_gen -nil
local nauvis_tile_settings = nauvis_map_gen.autoplace_settings.tile.settings
local nauvis_decorative_settings = nauvis_map_gen.autoplace_settings.decorative.settings

-- prevent alien biomes re-adding excluded biome tiles when remapping base game tiles
for old in pairs(alien_biomes.tile_alias) do
  nauvis_tile_settings[old] = nil
end

-- remove any decorative that is even remotely alive
local block_decorative_words = {"grass", "asterisk", "fluff", "garballo", "bush", "croton", "pita", "cane"}
for _, decorative in pairs(data.raw["optimized-decorative"]) do
  for _, word in pairs(block_decorative_words) do
    if string.find(decorative.name, word) then
      nauvis_decorative_settings[decorative.name] = nil
    end
  end
end

-- no trees or fish either
nauvis_map_gen.autoplace_controls["trees"] = nil
nauvis_map_gen.autoplace_settings.entity.settings["fish"] = nil

-- remove some decoratives that spawn on ice because of the adjusted noise expressions
nauvis_decorative_settings["cracked-mud-decal"] = nil
nauvis_decorative_settings["dark-mud-decal"] = nil

local function tiles_with_any_tag(tags)
  return alien_biomes.list_tiles(alien_biomes.require_tag(alien_biomes.all_tiles(), tags))
end
local function tiles_with_all_tags(tags)
  return alien_biomes.list_tiles(alien_biomes.require_tags(alien_biomes.all_tiles(), tags))
end

-- prevent rock patch decoratives from spawning on snow
data.raw["optimized-decorative"]["sand-decal-white"].autoplace.tile_restriction = tiles_with_all_tags{"dirt", "white"}
data.raw["optimized-decorative"]["stone-decal-white"].autoplace.tile_restriction = tiles_with_all_tags{"dirt", "white"}

-- puddle also on snow 7 & 8 (lumpy old ice)
data.raw["optimized-decorative"]["puddle-decal"].autoplace.tile_restriction = tiles_with_any_tag{"dirt", "grass", "snow-0", "snow-1", "snow-7", "snow-8"}

-- craters also on snow 2, 3, 8, & 9 (hard snow, old ice)
for _, crater in pairs { "crater1-large", "crater2-medium", "crater4-small" } do
  data.raw["optimized-decorative"][crater].autoplace.tile_restriction = tiles_with_any_tag{"dirt", "sand", "snow-2", "snow-3", "snow-8", "snow-9"}
end

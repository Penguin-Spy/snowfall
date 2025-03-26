data:extend{
  -- additional noise debug expressions
  {
    type = "noise-function",
    name = "slider_to_linear_center",
    parameters = {"slider_value", "center", "deviation"},
    expression = "slider_to_linear(slider_value, center - deviation, center + deviation)"
  },
  --[[{
    type = "noise-expression",
    name = "debug_scale",
    expression = noise_debug.temp_control("scale", "coverage") .. "^2" -- 1/36 to 36, still centered on 1
  },
  { -- redefines distance
    type = "noise-expression",
    name = "distance",
    expression = "distance_from_nearest_point{x = scaled_x, y = scaled_y, points = starting_positions}"
  },
  { type = "noise-expression", name = "scaled_x", expression = "x*debug_scale" },
  { type = "noise-expression", name = "scaled_y", expression = "y*debug_scale" },]]

  {
    type = "autoplace-control",
    name = "snowfall_islands",
    category = "terrain",
    can_be_disabled = false
  },
  {
    type = "noise-expression",
    name = "elevation",
    expression = "(snowfall_elevation_combined_islands + snowfall_elevation_detail) * 20"
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
    expression = "min(1,max(distance*slope/radius - slope,0))",
    local_expressions = {
      radius = "starting_area_radius * 4",
      slope = 7
    }
  },
  {
    type = "noise-expression",
    name = "snowfall_elevation_islands",
    expression = [[
      1 - falloff * voronoi_spot_noise{
        x = x,
        y = y,
        seed0 = map_seed,
        seed1 = 1337,
        grid_size = 75 * separation,
        distance_type = 3,
        jitter = 1
      }
    ]],
    local_expressions = {
      falloff = "slider_to_linear_center(1/control:snowfall_islands:size, 3.5, 0.5)",     -- Coverage
      separation = "slider_to_linear_center(1/control:snowfall_islands:frequency, 8, 4)", -- Scale
    }
  },
  {
    type = "noise-expression",
    name = "snowfall_elevation_starting_island",
    expression = "1 - 2 * distance * 1/radius",
    local_expressions = {
      radius = "starting_area_radius * 4"
    }
  },
  {
    type = "noise-expression",
    name = "snowfall_elevation_detail",
    -- output is -2 to about 3
    expression = "detail * strength",
    local_expressions = {
      strength = 1/16 + 0.25,
      detail = [[
        variable_persistence_multioctave_noise{
          x = x,
          y = y,
          seed0 = map_seed,
          seed1 = 600,
          input_scale = segmentation_multiplier / 14,
          output_scale = 0.03,
          offset_x = 10000 / segmentation_multiplier,
          octaves = 5,
          persistence = persistence
        }
      ]],
      persistence = [[
        clamp(
          amplitude_corrected_multioctave_noise{
            x = x,
            y = y,
            seed0 = map_seed,
            seed1 = 500,
            octaves = 5,
            input_scale = segmentation_multiplier / 2,
            offset_x = 10000 / segmentation_multiplier,
            persistence = 0.7,
            amplitude = 0.5
          } + 0.55,
          0.5,
          0.65
        )
      ]],
      segmentation_multiplier = "1.5 * control:water:frequency * control:snowfall_islands:frequency"
    }
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

-- remove other elevation types (elevation_lakes is used by ore autoplace (for some reason...))
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

-- add island control to nauvis
data.raw.planet.nauvis.map_gen_settings.autoplace_controls["snowfall_islands"] = {}

-- locale key provided by alien biomes
data.raw["autoplace-control"]["cold"].localised_name = {"autoplace-control-names.temperature"}

-- remove unused autoplace controls
data.raw["autoplace-control"]["trees"] = nil
for _, tree in pairs(data.raw["tree"]) do
  tree.autoplace = nil
end
data.raw["autoplace-control"]["hot"] = nil
data.raw["autoplace-control"]["starting_area_moisture"] = nil
-- controls are removed from nauvis in data-final-fixes (after alien biomes)

-- put starting area resources closer
data.raw["noise-function"]["resource_autoplace_all_patches"].local_expressions.starting_resource_placement_radius = 60
data.raw["noise-function"]["resource_autoplace_all_patches"].local_expressions.starting_patches_split = 1
-- remove the starting lake (it's methane now, which we don't need early game)
data.raw["noise-function"]["elevation_nauvis_function"].expression = "wlc_elevation"


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

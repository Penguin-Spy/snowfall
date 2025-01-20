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
-- these control things that have been removed
data.raw["autoplace-control"]["trees"].hidden = true
data.raw["autoplace-control"]["hot"].hidden = true
-- it doesn't seem like alien biomes uses this one at all
data.raw["autoplace-control"]["starting_area_moisture"].hidden = true

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

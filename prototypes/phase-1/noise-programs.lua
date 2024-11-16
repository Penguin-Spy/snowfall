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

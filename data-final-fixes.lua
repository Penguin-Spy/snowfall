--[[ data-final-fixes.lua © Penguin_Spy 2023-2024
  Modifications to vanilla/dependencies' prototypes that must happen last (after their data-final-fixes.lua)
]]

for _, planet in pairs(data.raw.planet) do
  planet.subgroup = "planet"
end

-- remove all map gen presets (todo: re-add ones that are relevant and balance them)
data.raw["map-gen-presets"].default = {
  type = "map-gen-presets",
  name = "default",
  default = {
    default = true,
    order = "a"
  }
}

-- require("__noise-tools__/experiments/nauvis-debug")
--[[noise_debug.hide_map_cliffs()
noise_debug.remove_non_tile_autoplace()

noise_debug.tiles_to_visualisation("visualisation", -1, 2, "3-band")

-- noise_debug.add_visualisation_target("moisture", nil, 0.9)
-- noise_debug.add_visualisation_target("aux", nil, 0.9)

noise_debug.add_visualisation_target("elevation", nil, 1)
noise_debug.add_visualisation_target("snowfall_elevation_islands", nil, 1)
noise_debug.add_visualisation_target("snowfall_elevation_starting_island", nil, 1)
noise_debug.add_visualisation_target("snowfall_elevation_combined_islands", nil, 1)
noise_debug.add_visualisation_target("snowfall_elevation_islands_limited", nil, 1)
noise_debug.add_visualisation_target("snowfall_elevation_detail", nil, 1)

-- noise_debug.add_visualisation_target("snowfall_elevation_macro", nil, 1)

-- data.raw["noise-expression"].visualisation.expression = "debug_elevation"
noise_debug.apply_controls()

data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity = nil
]]

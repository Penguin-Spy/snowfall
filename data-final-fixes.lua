--[[ data-final-fixes.lua © Penguin_Spy 2023-2024
  Modifications to vanilla/dependencies' prototypes that must happen last (after their data-final-fixes.lua)
]]

for _, planet in pairs(data.raw.planet) do
  planet.subgroup = "planet"
end

-- temp fix for bzlead bug
data.raw.furnace["snowfall-spaceship-furnace"].result_inventory_size = 1

data.raw.planet.nauvis.icon = data_util.graphics .. "icons/kiwen-lete.png"
data.raw.planet.nauvis.starmap_icon = data_util.graphics .. "icons/starmap-kiwen-lete.png"
data.raw.planet.nauvis.surface_properties = {
  gravity = 7.4,
  pressure = 0.2,
  ["magnetic-field"] = 14,
  ["solar-power"] = 22,
  ["day-night-cycle"] = 0 -- locale is overridden to display this as "N/A"
}

--data.raw["surface-property"]["day-night-cycle"].localised_unit_key = "surface-property-unit.day-night-cycle"

-- put all alien biomes tiles in the nauvis tiles group
for _, tile in pairs(alien_biomes.all_tiles()) do
  data.raw.tile[tile.name].subgroup = "nauvis-tiles"
end

-- hide unused vanilla tiles
for _, name in pairs{"grass-1", "dry-dirt", "dirt-1", "sand-1", "red-desert-0"} do
  data.raw.tile[name].hidden = true
end

-- put "wrecks" alien biomes rocks in "grass" with the rest of them
for _, name in pairs{"sand-rock-big-black", "sand-rock-big-purple", "sand-rock-big-red", "sand-rock-big-white"} do
  data.raw["simple-entity"][name].subgroup = "grass"
end

-- hide tree remnants (stumps) (they have no locale key)
for _, name in pairs{"tree-oaktapus-stump", "tree-greypine-stump", "tree-ash-stump", "tree-scarecrow-stump", "tree-specter-stump", 
"tree-willow-stump", "tree-mangrove-stump", "tree-pear-stump", "tree-baobab-stump"} do
  data.raw.corpse[name].hidden = true
end


data.raw["resource"]["stone"].subgroup = "mineable-fluids"  -- to put it with the geothermal vent, since it can't be associated with the stone item (mining it gives 2 things)

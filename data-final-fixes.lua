--[[ data-final-fixes.lua © Penguin_Spy 2023-2024
  Modifications to vanilla/dependencies' prototypes that must happen last (after their data-final-fixes.lua)
]]

-- help alien biomes finish removing vegetation
if settings.startup["alien-biomes-disable-vegetation"].value == "Enabled" then
  --for _, prototype in pairs(data.raw['tree']) do
  --  prototype.autoplace = nil
  --end

  local autoplace_tile_settings_to_remove = {
    "vegetation-green-grass-1" ,
    "vegetation-green-grass-2" ,
    "vegetation-green-grass-3" ,
    "vegetation-green-grass-4" ,
    "mineral-tan-dirt-1" ,
    "mineral-tan-dirt-2" ,
    "mineral-tan-dirt-1" ,
    "mineral-tan-dirt-2" ,
    "mineral-tan-dirt-3" ,
    "mineral-tan-dirt-5" ,
    "mineral-tan-dirt-4" ,
    "mineral-tan-dirt-6" ,
    "vegetation-olive-grass-2" ,
    "mineral-brown-dirt-1" ,
    "mineral-brown-dirt-5" ,
    "mineral-brown-dirt-6" ,
    "mineral-brown-sand-1" ,
    "mineral-brown-sand-1" ,
    "mineral-brown-sand-2" ,
    "mineral-brown-sand-3" ,
  }
  for _, prototype in pairs(data.raw['tile']) do
    if string.find(prototype.name, "grass") then
      --prototype.autoplace = nil
      table.insert(autoplace_tile_settings_to_remove, prototype.name)
    end
  end

  local autoplace_decorative_settings_to_remove = {}
  local block_decorative_words = {"grass", "asterisk", "fluff", "garballo", "bush", "croton", "pita", "cane"}
  for _, prototype in pairs(data.raw['optimized-decorative']) do
    for _, word in pairs(block_decorative_words) do
      if string.find(prototype.name, word) then
        --prototype.autoplace = nil
        table.insert(autoplace_decorative_settings_to_remove, prototype.name)
      end
    end
  end

  for _, planet in pairs(data.raw["planet"]) do
    local mgsas = planet.map_gen_settings.autoplace_settings
    if mgsas then
      if mgsas.decorative then
        for _, name in pairs(autoplace_decorative_settings_to_remove) do
          mgsas.decorative.settings[name] = nil
        end
      end
      if mgsas.tile then
        for _, name in pairs(autoplace_tile_settings_to_remove) do
          mgsas.tile.settings[name] = nil
        end
      end
      if mgsas.entity then
        mgsas.entity.settings['fish'] = nil
      end
    end
  end
  --data.raw['fish']['fish'].autoplace = nil
end

data.raw.planet.nauvis.map_gen_settings.autoplace_settings.decorative.settings["cracked-mud-decal"] = nil
data.raw.planet.nauvis.map_gen_settings.autoplace_settings.decorative.settings["dark-mud-decal"] = nil

for _, planet in pairs(data.raw.planet) do
  planet.subgroup = "planet"
end

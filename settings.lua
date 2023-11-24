--[[ settings.lua © Penguin_Spy 2023
  overrides other mods' settings to fit snowfall's theming
]]


-- alien biomes config
data.raw["string-setting"]["alien-biomes-disable-vegetation"].hidden = true
data.raw["string-setting"]["alien-biomes-disable-vegetation"].allowed_values = {"Enabled"}
data.raw["string-setting"]["alien-biomes-disable-vegetation"].default_value = "Enabled"

data.raw["string-setting"]["alien-biomes-include-rivers"].hidden = true
data.raw["string-setting"]["alien-biomes-include-rivers"].allowed_values = {"Enabled"}
data.raw["string-setting"]["alien-biomes-include-rivers"].default_value = "Enabled"

data.raw["bool-setting"]["enable-upscaled-hr-resolution"].hidden = true
data.raw["bool-setting"]["enable-upscaled-hr-resolution"].default_value = false
data.raw["bool-setting"]["enable-upscaled-hr-resolution"].forced_value = false

--[[ settings.lua © Penguin_Spy 2023-2024
  overrides other mods' settings to fit snowfall's theming
]]

-- alien biomes config
local function alien_biomes_set(name, enabled)
  data.raw["string-setting"]["alien-biomes-" .. name].hidden = true
  data.raw["string-setting"]["alien-biomes-" .. name].allowed_values = { enabled and "Enabled" or "Disabled" }
  data.raw["string-setting"]["alien-biomes-" .. name].default_value = enabled and "Enabled" or "Disabled"
end

alien_biomes_set("disable-vegetation", true)
alien_biomes_set("include-inland-shallows", false)
alien_biomes_set("include-rivers", true)

-- disable biomes we don't want
for _, setting in pairs{
  "grass-blue",
  "grass-green",
  "grass-mauve",
  "grass-olive",
  "grass-orange",
  "grass-purple",
  "grass-red",
  "grass-turquoise",
  "grass-violet",
  "grass-yellow",
  "volcanic-blue",
  "volcanic-green",
  "volcanic-orange",
  "volcanic-purple",
  "dirt-beige",
  "dirt-brown",
  "dirt-cream",
  "dirt-purple",
  "dirt-red",
  "dirt-tan",
  "dirt-violet",
  "sand-beige",
  "sand-brown",
  "sand-cream",
  "sand-purple",
  "sand-red",
  "sand-tan",
  "sand-violet",
} do
  alien_biomes_set("include-"..setting, false)
end
-- make sure the biomes we do want are enabled
for _, setting in pairs{
  "frozen",
  "dirt-black",
  "sand-black",
  "dirt-grey",
  "sand-grey",
  "dirt-white",
  "sand-white",
  "dirt-aubergine",
  "sand-aubergine",
  "dirt-dustyrose",
  "sand-dustyrose",
} do
  alien_biomes_set("include-"..setting, true)
end

-- informatron (force disable "Show at start" so it doesn't interrupt the intro cutscene)
data.raw["bool-setting"]["informatron-show-at-start"].hidden = true
data.raw["bool-setting"]["informatron-show-at-start"].default_value = false
data.raw["bool-setting"]["informatron-show-at-start"].forced_value = false

-- todo: settings for Rohlinheatagtmuf_Hdhaotaotfnllsape-atnsasri

--[[ settings.lua © Penguin_Spy 2023-2024
  overrides other mods' settings to fit snowfall's theming
]]

local function set_bool(name, enabled)
  local setting = data.raw["bool-setting"][name]
  setting.hidden = true
  setting.default_value = enabled
  setting.forced_value = enabled
end
local function set_string(name, value)
  local setting = data.raw["string-setting"][name]
  setting.hidden = true
  setting.default_value = value
  setting.allowed_values = { value }
end

-- alien biomes config
set_string("alien-biomes-disable-vegetation", "Disabled")
set_string("alien-biomes-include-inland-shallows", "Disabled")
set_string("alien-biomes-include-rivers", "Disabled")
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
  set_string("alien-biomes-include-"..setting, "Disabled")
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
  set_string("alien-biomes-include-"..setting, "Enabled")
end

-- informatron (force disable "Show at start" so it doesn't interrupt the intro cutscene)
set_bool("informatron-show-at-start", false)

-- BZ lead
set_bool("bzlead-byproduct", false)
set_string("bzlead-more-entities", "no")

-- BZ silica
set_string("bzsilicon-more-intermediates", "yes")


-- todo: settings for Rohlinheatagtmuf_Hdhaotaotfnllsape-atnsasri

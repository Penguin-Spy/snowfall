-- [[ Coal ]]
-- remove coal
data.raw["resource-category"]["coal"] = nil
data.raw["autoplace-control"]["coal"] = nil
data.raw["noise-layer"]["coal"] = nil
data.raw["resource"]["coal"] = nil
data.raw["item"]["coal"] = nil
-- remove uses of coal
-- todo: figure out chemistry prerequisites needed to make polyproplyene
data_util.replace_recipe_ingredients("plastic-bar", {
  {type = "fluid", name = "methane", amount = 20}
})
data.raw["recipe"]["coal-liquefaction"] = nil
data.raw["technology"]["coal-liquefaction"] = nil
data_util.remove_recipe_ingredient("grenade", "coal")
data_util.remove_recipe_ingredient("poison-capsule", "coal")
data_util.remove_recipe_ingredient("slowdown-capsule", "coal")
data_util.remove_recipe_ingredient("explosives", "coal")

for _, module in pairs(data.raw.module) do
  if module.limitation then
    util.remove_from_list(module.limitation, "coal-liquefaction")
  end
end

-- [[ Natural Gas ]]

-- remove natural gas
data.raw["resource-category"]["gas"] = nil
data.raw["autoplace-control"]["gas"] = nil
data.raw["noise-layer"]["gas"] = nil
data.raw["resource"]["gas"] = nil
--data.raw["fluid"]["gas"] = nil --todo: helium expects this still. should probably leave it and just work it into the chemistry somehow
-- map-gen-presets changes are done in data-updates

-- remove extractor
-- todo: re-use for flash-steam geothermal wellhead?
data.raw["item"]["gas-extractor"] = nil
data.raw["recipe"]["gas-extractor"] = nil
data.raw["mining-drill"]["gas-extractor"] = nil
data.raw["technology"]["gas-extraction"] = nil

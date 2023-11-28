-- removing natural gas autoplace presets (created in data-updates)
for _, preset in pairs(data.raw["map-gen-presets"].default) do
  if type(preset) == "table" and
      preset.basic_settings and
      preset.basic_settings.autoplace_controls then
    preset.basic_settings.autoplace_controls["gas"] = nil
    preset.basic_settings.autoplace_controls["coal"] = nil
  end
end

-- BrassTacks re-adds brass plates when it shouldn't
for i, ingredient in pairs(data.raw.recipe["iron-gear-wheel"].ingredients) do
  if ingredient[1] == "brass-plate" then
    data.raw.recipe["iron-gear-wheel"].ingredients[i] = nil
  end
end

-- move bolted flange to underground pipes, make pipes even cheaper (1 plate -> 2 pipes)
data_util.replace_recipe_ingredients("pipe", {
  {type = "item", name = "lead-plate", amount = 1}
})
data_util.replace_recipe_results("pipe", {
  {type = "item", name = "pipe", amount = 2}
})
data_util.replace_recipe_ingredients("pipe-to-ground", {
  {type = "item", name = "pipe",          amount = 10},
  {type = "item", name = "lead-plate",    amount = 2},
  {type = "item", name = "bolted-flange", amount = 2}
})

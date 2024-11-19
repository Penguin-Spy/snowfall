-- move bolted flange to underground pipes, make pipes even cheaper (1 plate -> 2 pipes)
data.raw.recipe["pipe"].ingredients = {
  { type = "item", name = "lead-plate", amount = 1 }
}
data.raw.recipe["pipe"].results = {
  { type = "item", name = "pipe", amount = 2 }
}
data.raw.recipe["pipe-to-ground"].ingredients = {
  { type = "item", name = "pipe",          amount = 10 },
  { type = "item", name = "lead-plate",    amount = 2 },
  --?{ type = "item", name = "bolted-flange", amount = 2 }
}

--local steam_vent = data.raw["resource"]["geothermal-vent"]
--steam_vent.autoplace.starting_area_amount = 150
--steam_vent.order = "aaa"

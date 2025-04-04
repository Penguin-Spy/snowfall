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
}

-- hidden at the start, unlocked by mineral survey (except for iron)
for _, name in pairs{"copper-plate", "lead-plate", "zinc-plate", "nickel-plate", "stone-brick", "wooden-chest", "iron-plate"} do
  data.raw.recipe[name].enabled = false
end

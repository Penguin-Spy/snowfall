local automation = data.raw["technology"]["automation"]

-- is overridden by bzgas
automation.unit.ingredients = {
  { type = "item", name = "automation-science-pack", amount = 1 }
}

-- remove steam power research
data.raw.technology["steam-power"] = nil

-- automation is pneumatic and depends on pnuematics & electric smelting
local automation = data.raw.technology["automation"]
automation.prerequisites = { "snowfall-pneumatics", "snowfall-electric-smelting" }
automation.unit = nil
automation.research_trigger = {
  type = "craft-item",
  item = "nickel-plate",
  count = 10
}
table.insert(automation.effects, {type = "unlock-recipe", recipe = "snowfall-gearbox"})

--
local electronics = data.raw.technology["electronics"]
electronics.prerequisites = { "snowfall-material-research" }
electronics.research_trigger = nil
electronics.unit = {
  count = 10,
  time = 15,
  ingredients = {
    {"snowfall-material-punchcard", 1}
  }
}

-- 
local automation_pack = data.raw.technology["automation-science-pack"]
automation_pack.prerequisites = { "electronics", "automation" }
automation_pack.research_trigger = nil
automation_pack.unit = {
  count = 20,
  time = 15,
  ingredients = {
    {"snowfall-material-punchcard", 1}
  }
}
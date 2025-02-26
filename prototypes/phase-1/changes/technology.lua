-- replaces a prerequisite for a list of techs
---@param old_tech string
---@param new_tech string
---@param techs string[]
local function rebase_technologies(old_tech, new_tech, techs)
  for _, name in pairs(techs) do
    local tech = data.raw.technology[name]
    for i, prereq in pairs(tech.prerequisites) do
      if prereq == old_tech then
        tech.prerequisites[i] = new_tech
      end
    end
  end
end

-- replaces a pack ingredient for a list of techs
---@param old_pack string
---@param new_pack string
---@param techs string[]
local function replace_tech_ingredients(old_pack, new_pack, techs)
  -- replace direct prerequisite on pack
  rebase_technologies(old_pack, new_pack, techs)
  -- replace pack in research cost
  for _, name in pairs(techs) do
    local tech = data.raw.technology[name]
    for _, pack in pairs(tech.unit.ingredients) do
      if pack[1] == old_pack then
        pack[1] = new_pack
      end
    end
  end
end

-- remove steam power research
data.raw.technology["steam-power"] = nil

-- stone walls are now factory buildings
local stone_wall = data.raw.technology["stone-wall"]
stone_wall.prerequisites = { "snowfall-electric-smelting" }
stone_wall.unit = nil
stone_wall.research_trigger = {
  type = "craft-item",
  item = "stone-brick",
  count = 25
}
table.insert(stone_wall.effects, {type = "unlock-recipe", recipe = "gate"})
--table.insert(stone_wall.effects, {type = "unlock-recipe", recipe = "snowfall-space-heater"})

-- automation is pneumatic and depends on interiors
local automation = data.raw.technology["automation"]
automation.prerequisites = { "snowfall-material-punchcard", "stone-wall" }
-- spring, belt, assembler, (other mods' stuff), no longserter
table.insert(automation.effects, 1, {type = "unlock-recipe", recipe = "transport-belt"})
table.insert(automation.effects, 1, {type = "unlock-recipe", recipe = "snowfall-spring"})
data_util.remove_technology_recipe_unlock("automation", "long-handed-inserter")

-- logistics also depends on interiors
data.raw.technology["logistics"].prerequisites = { "snowfall-material-punchcard", "stone-wall" }

-- automation science pack depends on automation and pulverizing
local automation_pack = data.raw.technology["automation-science-pack"]
automation_pack.icon = data_util.graphics .. "technology/manufacturing-punchcard.png"
automation_pack.prerequisites = { "automation", "snowfall-pneumatic-pulverizer" }
automation_pack.research_trigger = nil
automation_pack.unit = {
  count = 20,
  time = 5,
  ingredients = {
    {"snowfall-material-punchcard", 1}
  }
}
table.insert(automation_pack.effects, {type = "unlock-recipe", recipe = "snowfall-mechanical-calculator"})

-- electronics comes later in progression
local electronics = data.raw.technology["electronics"]
electronics.prerequisites = { "logistic-science-pack" } -- TODO: build the tech tree out to where electronics can be made
electronics.research_trigger = nil
electronics.unit = {
  count = 10,
  time = 15,
  ingredients = {
    {"snowfall-material-punchcard", 1}
  }
}
-- steel processing also will come later
data.raw.technology["steel-processing"].prerequisites = { "logistic-science-pack" }

-- put some stuff earlier
replace_tech_ingredients("automation-science-pack", "snowfall-material-punchcard", {"lamp", "logistics", "radar", "automation"})

-- electric drill depends on electromechanics
data.raw.technology["electric-mining-drill"].prerequisites = {"snowfall-electromechanics"}
table.insert(data.raw.technology["electric-mining-drill"].unit.ingredients, 1, {"snowfall-material-punchcard", 1})

-- move fast inserter later (to solid state electronics eventually)
data.raw.technology["fast-inserter"].prerequisites = {"snowfall-electric-inserter", "electronics"}

-- remove BZ's silica-processing tech
data.raw.technology["silica-processing"] = nil
for _, tech in pairs{"concrete", "silicon-processing", "fiber-optics"} do
  util.remove_from_list(data.raw.technology[tech].prerequisites, "silica-processing")
end
table.insert(data.raw.technology["fiber-optics"].prerequisites, "logistic-science-pack")

-- cars & mini trains depend on steam engine
local car, mini_trains = data.raw.technology["automobilism"], data.raw.technology["mini-trains"]
car.prerequisites = {"snowfall-pressurized-steam"}
car.unit.count = 50 -- cheaper car tech
car.unit.ingredients = {
  {"snowfall-material-punchcard", 1},
  {"automation-science-pack", 1}
}
mini_trains.prerequisites = {"snowfall-pressurized-steam", "logistics"}
mini_trains.unit.ingredients = {
  {"snowfall-material-punchcard", 1},
  {"automation-science-pack", 1}
}
table.insert(mini_trains.effects, 1, {type = "unlock-recipe", recipe = "rail"})

-- hide military techs for now
-- TODO: move these later in the tech tree and un-hide them when enemies are discovered
for _, name in pairs{"gun-turret", "military", "military-2", "repair-pack"} do
  data.raw.technology[name].enabled = false
end

-- temporary victory condition
local victory = data.raw.technology["rocket-silo"]
victory.unit = nil
victory.research_trigger = {
  type = "craft-item",
  item = "mini-locomotive"
}
victory.prerequisites = { "mini-trains", "electric-mining-drill"}
victory.effects = {}
victory.localised_name = {"", {"gui-game-finished.victory"}, {"snowfall.victory-disclaimer"}}
victory.localised_description = {"snowfall.victory-final-message"}
data.raw.technology["space-science-pack"].prerequisites = { "production-science-pack", "utility-science-pack" }

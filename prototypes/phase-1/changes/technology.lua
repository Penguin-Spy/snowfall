-- replaces a pack ingredient for a list of techs, and updates prerequsistes on the tech that unlocks the pack if necessary
---@param old_pack string
---@param new_pack string
---@param techs string[]
local function rebase_technologies(old_pack, new_pack, techs)
  for _, name in pairs(techs) do
    local tech = data.raw.technology[name]
    -- replace direct prerequisite on pack
    for i, prereq in pairs(tech.prerequisites) do
      if prereq == old_pack then
        tech.prerequisites[i] = new_pack
      end
    end
    -- replace pack in research cost
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

-- put some stuff earlier
rebase_technologies("automation-science-pack", "snowfall-material-punchcard", {"lamp", "logistics", "radar", "automation"})

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
for _, name in pairs{"gun-turret", "military", "military-2"} do
  data.raw.technology[name].enabled = false
end

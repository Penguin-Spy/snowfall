--[[ technology.lua © Penguin_Spy 2024
  Manages hiding/showing technologies based on progress
]]

-- don't touch certain techs that are used for other scripting
local ignore_techs = util.list_to_map{
  --"snowfall-fake-electronics" -- prevent it being re-enabled
}
for name, proto in pairs(prototypes.technology) do
  if not proto.enabled then ignore_techs[name] = true end
end

---@param tech LuaTechnology
---@param visited {[string]: true}
local function check(tech, visited)
  local name = tech.name
  --log("check " .. name)
  if visited[name] or ignore_techs[name] then
    --log("  visited, enabled: " .. tostring(tech.enabled))
    return tech.enabled
  end
  --log("  first visit")
  visited[name] = true

  -- this tech should be disabled if
  --  it has a prereq that is essential & not researched
  --  any of it's prereqs are disabled (i.e. missing an essential prereq)
  for _, prereq in pairs(tech.prerequisites) do
    if (prereq.prototype.essential and not prereq.researched) or not check(prereq, visited) then
      tech.enabled = false
      --log("  " .. name .. " not enabled: " .. prereq.name .. ", " .. tostring(prereq.prototype.essential and not prereq.researched) .. ", " .. tostring(prereq.enabled))
      return false
    end
  end

  --log("  " .. name .. " yes enabled")
  tech.enabled = true
  return true
end

---@param force LuaForce
local function check_techs(force)
  local visited = {}

  -- prevent fake electronics being re-enabled
  if force.technologies["snowfall-fake-electronics-failed"].visible_when_disabled then
    visited["snowfall-fake-electronics"] = true
  end

  for _, tech in pairs(force.technologies) do
    check(tech, visited)
  end
end


---@param event EventData.on_research_finished
events.on(events.on_research_finished, function(event)
  local tech = event.research
  --log("unlocked " .. tech.name .. ", " .. tostring(tech.prototype.essential))
  -- if an essential tech was unlocked, reveal all techs past it
  if tech.prototype.essential then
    check_techs(tech.force)
  end
end)

---@param force LuaForce
local function initalize_force(force)
  check_techs(force)
end

---@param event EventData.on_force_created|EventData.on_force_reset
events.on({events.on_force_created, events.on_force_reset}, function(event)
  initalize_force(event.force)
end)
---@param event EventData.on_forces_merged
events.on(events.on_forces_merged, function(event)
  initalize_force(event.destination)
end)
events.on(events.initalize, function()
  for _, force in pairs(game.forces) do
    initalize_force(force)
  end
end)

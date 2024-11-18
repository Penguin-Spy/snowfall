trigger_effects = {}

-- places the entity that a placer entity is for. the placer is destroyed by this function!
---@param placer LuaEntity
---@return boolean # true if this was a placer, false if its the target entity
local function place_placer_target(placer)
  if placer.name:sub(-7) ~= "-placer" then return false end -- not a placer, tell caller to not return early
  local entity = placer.surface.create_entity{
    name = placer.name:sub(0, -8),  -- remove the "-placer" suffix
    direction = placer.direction,
    position = placer.position,
    force = placer.force,
    player = placer.last_user
  }
  if not entity or not entity.valid then
    log(serpent.block{ name = placer.name, unit_number = placer.unit_number, position = placer.position })
    error("creating placer target for " .. tostring(placer.name) .. " failed unexpectedly")
  end
  placer.destroy()
  return true
end


-- Pneumatic ice bore

---@param event EventData.on_script_trigger_effect
trigger_effects["snowfall_placed_ice_bore"] = function(event)
  local drill = event.source_entity  ---@cast placer -nil
  if place_placer_target(drill) then return end

  local resource = drill.surface.create_entity{
    name = "snowfall-internal-ice",
    position = drill.position,
    amount = 5
  }
  drill.update_connections() -- let the drill know there's a resource under it now

  destroy_handling.register(drill, "snowfall_removed_ice_bore", {
    resource = resource
  })
end

trigger_effects["snowfall_removed_ice_bore"] = function(data)
  local resource = data.resource
  if resource and resource.valid then
    resource.destroy()
  end
end


-- Steam vent turbine
---@param event EventData.on_script_trigger_effect
trigger_effects["snowfall_placed_steam_vent_turbine"] = function(event)
  local turbine = event.source_entity  ---@cast turbine -nil
  -- placing the actual turbine will create the drill  
  if place_placer_target(turbine) then return end

  local drill = turbine.surface.create_entity{
    name = "snowfall-steam-vent-turbine-internal-drill",
    direction = turbine.direction,
    position = turbine.position,
    force = turbine.force,
    player = turbine.last_user
  }

  destroy_handling.register(turbine, "snowfall_removed_steam_vent_turbine", {
    drill = drill
  })
end

trigger_effects["snowfall_removed_steam_vent_turbine"] = function(data)
  local drill = data.drill
  if drill and drill.valid then
    drill.destroy()
  end
end


-- Solar mirrors

---@param data {mirror:LuaEntity,reactor:LuaEntity?}
local function solar_mirror_ensure_reactor(data)
  local old_reactor = data.reactor
  local previous_temperature
  if old_reactor and old_reactor.valid then
    previous_temperature = old_reactor.temperature
    old_reactor.destroy()
  end

  local new_reactor_name = "snowfall-solar-mirror-reactor-"
  if data.mirror.direction == defines.direction.north then
    new_reactor_name = new_reactor_name .. "north"
  elseif data.mirror.direction == defines.direction.east then
    new_reactor_name = new_reactor_name .. "east"
  elseif data.mirror.direction == defines.direction.south then
    new_reactor_name = new_reactor_name .. "south"
  elseif data.mirror.direction == defines.direction.west then
    new_reactor_name = new_reactor_name .. "west"
  end

  local mirror = data.mirror
  local new_reactor = mirror.surface.create_entity{
    name = new_reactor_name,
    position = mirror.position,
    force = mirror.force
  }
  if not new_reactor or not new_reactor.valid then
    error("creating " .. tostring(new_reactor_name) .. " failed unexpectedly")
  end
  data.reactor = new_reactor

  if previous_temperature then
    new_reactor.temperature = previous_temperature
  end
end

---@param event EventData.on_script_trigger_effect
trigger_effects["snowfall_placed_solar_mirror"] = function(event)
  local mirror = event.source_entity  ---@cast mirror -nil

  local data = { mirror = mirror }
  solar_mirror_ensure_reactor(data)

  destroy_handling.register(mirror, "snowfall_removed_solar_mirror", data)
end

---@param unit_number uint
trigger_effects["snowfall_rotated_solar_mirror"] = function(unit_number)
  solar_mirror_ensure_reactor(destroy_handling.get_param_from_unit_number(unit_number))
end

trigger_effects["snowfall_removed_solar_mirror"] = function(data)
  local reactor = data.reactor
  if reactor and reactor.valid then
    reactor.destroy()
  end
end

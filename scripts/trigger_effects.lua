trigger_effects = {}

---@param event EventData.on_script_trigger_effect
events.on(events.on_script_trigger_effect, function(event)
  local handler = trigger_effects[event.effect_id]
  if handler then handler(event) end  -- don't tail call so the debugger is happy :)
end)

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
  local drill = event.source_entity  ---@cast drill -nil
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


-- Steel furnace fuel mixer
---@param event EventData.on_script_trigger_effect
trigger_effects["snowfall_placed_steel_furnace"] = function(event)
  local steel_furnace = event.source_entity  ---@cast steel_furnace -nil

  local mixer = steel_furnace.surface.create_entity{
    name = "snowfall-internal-steel-furnace-fuel-mixer",
    direction = steel_furnace.direction,
    position = steel_furnace.position,
    force = steel_furnace.force,
    player = steel_furnace.last_user
  }

  destroy_handling.register(steel_furnace, "snowfall_removed_steel_furnace", {
    mixer = mixer
  })
end
trigger_effects["snowfall_removed_steel_furnace"] = function(data)
  local mixer = data.mixer
  if mixer and mixer.valid then
    mixer.destroy()
  end
end

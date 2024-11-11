trigger_effects = {}

---@param entity LuaEntity
local function entity_to_string(entity)
  return "'" .. tostring(entity.name) .. "'[id=" .. tostring(entity.unit_number) .. ",x=" .. tostring(entity.position.x) .. ",y=" .. tostring(entity.position.y) .. "]"
end

-- places the entity that a placer entity is for. the placer is destroyed by this function!
---@param placer LuaEntity
---@return LuaEntity
local function place_placer_target(placer)
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
  return entity
end


-- Pneumatic ice bore

---@param event EventData.on_script_trigger_effect
trigger_effects["snowfall_placed_ice_bore"] = function(event)
  --game.print("placed ice bore. source: " .. entity_to_string(event.source_entity) .. " target: " .. entity_to_string(event.target_entity))
  local placer = event.source_entity  ---@cast placer -nil

  local real_bore = place_placer_target(placer)
  local resource = real_bore.surface.create_entity{
    name = "snowfall-internal-ice",
    position = real_bore.position,
    amount = 5
  }
  real_bore.update_connections() -- let the drill know there's a resource under it now

  destroy_handling.register(real_bore, "snowfall_removed_ice_bore", {
    resource = resource
  })
end

trigger_effects["snowfall_removed_ice_bore"] = function(data)
  local resource = data.resource
  if resource and resource.valid then
    resource.destroy()
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

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
    log(serpent.block{name = placer.name, unit_number = placer.unit_number, position = placer.position})
    error("creating placer target for " .. tostring(placer.name) .. " failed unexpectedly")
  end
  placer.destroy()
  return entity
end

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

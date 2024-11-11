-- handles deciding what to do when an entity registered with script.on_entity_destroyed is destroyed

destroy_handling = {}

---@class destroy_handler_data
---@field handler string
---@field param any


-- registers the "trigger_effect" handler name to use when an entity is destroyed
---@param entity LuaEntity  the entity to watch for destruction
---@param handler string    the trigger_effect handler
---@param param any         an arbitrary parameter passed to the handler
function destroy_handling.register(entity, handler, param)
  local id = script.register_on_object_destroyed(entity)

  storage.destroy_handler_map[id] = {
    handler = handler,
    param = param
  }
  if entity.unit_number then
    storage.unit_id_to_destroy_handler_id_map[entity.unit_number] = id
  end
end

-- handle the on_entity_destroyed_event
---@param event EventData.on_entity_destroyed
function destroy_handling.handle_event(event)
  local handler_data = storage.destroy_handler_map[event.registration_number]
  if handler_data then
    trigger_effects[handler_data.handler](handler_data.param)
  end
  storage.destroy_handler_map[event.registration_number] = nil
  if event.useful_id then
    storage.unit_id_to_destroy_handler_id_map[event.useful_id] = nil
  end
end

-- gets the destroy_handling paramater associated with the given unit number
---@param unit_number uint
---@return any
function destroy_handling.get_param_from_unit_number(unit_number)
  local id = storage.unit_id_to_destroy_handler_id_map[unit_number]
  if not id then
    error("given unit number was not registered for destroy handling: " .. tostring(unit_number))
  end
  local handler_data = storage.destroy_handler_map[id]
  if not handler_data or not handler_data.param then
    error("given unit number was not registered for destroy handling with a paramater: " .. tostring(unit_number)
      .. "\nhandler_data: " .. type(handler_data)
      .. "\nhandler_data.param: " .. handler_data and type(handler_data.param) or "n/a")
  end
  return handler_data.param
end

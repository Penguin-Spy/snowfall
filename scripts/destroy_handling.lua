-- handles deciding what to do when an entity registered with script.on_entity_destroyed is destroyed

destroy_handling = {}

---@class destroy_handler_data
---@field handler string
---@field param any


-- registers the "trigger_effect" handler name to use when an entity is destroyed
---@param entity LuaEntity  the entity to watch for destruction
---@param handler string    the trigger_effect handler
---@param param any       an arbitrary parameter passed to the handler
function destroy_handling.register(entity, handler, param)
  local id = script.register_on_entity_destroyed(entity)

  global.destroy_handler_map[id] = {
    handler = handler,
    param = param
  }
end

-- handle the on_entity_destroyed_event
---@param event EventData.on_entity_destroyed
function destroy_handling.handle_event(event)
  local handler_data = global.destroy_handler_map[event.registration_number]
  if handler_data then
    trigger_effects[handler_data.handler](handler_data.param)
  end
  global.destroy_handler_map[event.registration_number] = nil
end

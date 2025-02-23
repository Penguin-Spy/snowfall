---@diagnostic disable: inject-field

events = table.deepcopy(defines.events)
events.initalize = -1
events.initalize_player = -2

---@type table<LuaEventType, fun(event:EventData)[]>
local handlers = {}

-- Register a handler to run on the specified event(s).
---@param event (LuaEventType)|((LuaEventType)[])  The event(s) or custom-input to invoke the handler on.
---@param handler fun(event: EventData) The handler for this event.
---@overload fun(event:-1, handler: fun())
---@overload fun(event:-2, handler: fun(player:LuaPlayer))
function events.on(event, handler)
  if type(event) ~= "table" then
    event = {event}
  end
  for _, id in pairs(event) do
    handlers[id] = handlers[id] or {}
    table.insert(handlers[id], handler)
  end
end

-- Raise an event for all listeners in this mod only.
---@param event LuaEventType
---@param data any
function events.raise(event, data)
  for _, handler in pairs(handlers[event]) do
    handler(data)
  end
end

-- Register the actual event listeners.
function events.register_events()
  for id, event_handlers in pairs(handlers) do
    if id < 0 then goto continue end
    if #event_handlers == 1 then
      script.on_event(id, event_handlers[1])
    else
      script.on_event(id, function (data)
        for _, handler in pairs(event_handlers) do
          handler(data)
        end
      end)
    end
  end
  ::continue::
end

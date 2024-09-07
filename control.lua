--[[ control.lua © Penguin_Spy 2023
  Control-stage scripting for Snowfall mechanics
]]

require "scripts.trigger_effects"
require "scripts.destroy_handling"

if script.active_mods["gvv"] then require("__gvv__.gvv")() end

local function prepare_map()
  if remote.interfaces["freeplay"] then
    remote.call("freeplay", "set_created_items", {
      --["pistol"] = 1,
      --["firearm-magazine"] = 10
    })
    remote.call("freeplay", "set_ship_items", {
      ["burner-mining-drill"] = 10,
      --["snowfall-kiln"] = 1,
      ["snowfall-steam-vent-cap"] = 2,
      ["snowfall-solar-mirror"] = 3,
      ["snowfall-solid-heat-exchanger"] = 3,
      ["snowfall-burner-ice-bore"] = 2
    })
    remote.call("freeplay", "set_debris_items", {
      ["lead-plate"] = 10,
      ["brass-plate"] = 18,
      ["iron-gear-wheel"] = 2
    })
  else
    game.print("[snowfall] Warning: freeplay interface not found! Snowfall does not support other scenarios yet.\nThe game may crash or it may be impossible to progress.")
  end
end

script.on_event(defines.events.on_script_trigger_effect, function(event)
  local handler = trigger_effects[event.effect_id]
  if handler then handler(event) end  -- don't tail call so the debugger is happy :)
end)

script.on_event(defines.events.on_entity_destroyed, destroy_handling.handle_event)


function initalize()
  ---@type table<uint64, destroy_handler_data>
  global.destroy_handler_map = global.destroy_handler_map or {}
end

script.on_init(function()
  initalize()
  prepare_map()
end)
script.on_configuration_changed(initalize)


commands.add_command("snowfall", "debugging command", function(command)
  local player = game.get_player(command.player_index)  --[[@as LuaPlayer]]
  player.set_goal_description([[
Collect material samples:
- [img=utility/questionmark] Solid sample #1 (0/5)
- [img=utility/questionmark] Solid sample #2 (0/5)
- [item=lead-ore] Lead ore (3/5)]])
end)

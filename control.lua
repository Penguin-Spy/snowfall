--[[ control.lua © Penguin_Spy 2023
  Control-stage scripting for Snowfall mechanics
]]

require "scripts.trigger_effects"
require "scripts.destroy_handling"

if script.active_mods["gvv"] then require("__gvv__.gvv")() end

script.on_init(function(event)
  if remote.interfaces["freeplay"] then
    remote.call("freeplay", "set_created_items", {
      ["pistol"] = 1,
      ["firearm-magazine"] = 10
    })
    remote.call("freeplay", "set_ship_items", {
      ["offshore-pump"] = 2,
      ["burner-mining-drill"] = 10,
      ["snowfall-kiln"] = 1,
      ["firearm-magazine"] = 20
    })
    remote.call("freeplay", "set_debris_items", {
      ["lead-plate"] = 10,
      ["brass-plate"] = 6,
      ["iron-gear-wheel"] = 2
    })
  else
    game.print("[snowfall] Warning: freeplay interface not found! Snowfall does not support other scenarios yet.\nThe game may crash or it may be impossible to progress.")
  end

  --[[
  local ship = game.get_surface("crash-site-spaceship")
  if not ship then
    error("crash-site-spaceship surface not found!")
  end

  ---@diagnostic disable-next-line: missing-fields
  ship.create_entity{name = "stone-furnace", position = {7, 0}}
  ]]
end)

script.on_event(defines.events.on_script_trigger_effect, function(event)
  local handler = trigger_effects[event.effect_id]
  if handler then handler(event) end  -- don't tail call so the debugger is happy :)
end)

script.on_event(defines.events.on_entity_destroyed, destroy_handling.handle_event)

function initalize()
  ---@type table<uint64, destroy_handler_data>
  global.destroy_handler_map = global.destroy_handler_map or {}
end

script.on_init(initalize)
script.on_configuration_changed(initalize)

commands.add_command("snowfall", "debugging command", function(command)
  local player = game.get_player(command.player_index)  --[[@as LuaPlayer]]
  player.set_goal_description([[
Collect material samples:
- [img=utility/questionmark] Solid sample #1 (0/5)
- [img=utility/questionmark] Solid sample #2 (0/5)
- [item=lead-ore] Lead ore (3/5)]])
end)

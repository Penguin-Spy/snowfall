--[[ control.lua © Penguin_Spy 2023
  Control-stage scripting for Snowfall mechanics
]]

local util = require "util"

require "scripts.trigger_effects"
require "scripts.destroy_handling"

if script.active_mods["gvv"] then require("__gvv__.gvv")() end

-- runs when the save is first created, before the freeplay crash site has been created
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
    remote.call("freeplay", "set_skip_intro", true)  -- dont show_message_dialog
  else
    game.print{"snowfall.error-no-freeplay-interface"}
  end
end

-- runs when the first player is created, after the freeplay crash site has been created
local function postpare_map()
  storage.postpare_map_ran = true

  local kiwen_lete = game.get_surface("nauvis")
  kiwen_lete.freeze_daytime = true
  kiwen_lete.daytime = 0.68
end

script.on_event(defines.events.on_script_trigger_effect, function(event)
  local handler = trigger_effects[event.effect_id]
  if handler then handler(event) end  -- don't tail call so the debugger is happy :)
end)

script.on_event(defines.events.on_object_destroyed, destroy_handling.handle_event)

script.on_event(defines.events.on_player_rotated_entity, function(event)
  if event.entity.name == "snowfall-solar-mirror" then
    trigger_effects["snowfall_rotated_solar_mirror"](event.entity.unit_number)
  end
end)


function initalize()
  ---@type table<uint64, destroy_handler_data>
  storage.destroy_handler_map = storage.destroy_handler_map or {}

  ---@type table<uint64, uint64>
  storage.unit_id_to_destroy_handler_id_map = storage.unit_id_to_destroy_handler_id_map or {}
end

script.on_init(function()
  if game.tick ~= 0 then
    game.print{"snowfall.error-not-new-save"}
  end
  initalize()
  prepare_map()
end)
script.on_configuration_changed(initalize)

script.on_event(defines.events.on_player_created, function()
  if not storage.postpare_map_ran then
    postpare_map()
  end
end)


commands.add_command("snowfall", "debugging command", function(command)
  local player = game.get_player(command.player_index)  --[[@as LuaPlayer]]
  player.set_goal_description([[
Collect material samples:
- [img=utility/questionmark] Solid sample #1 (0/5)
- [img=utility/questionmark] Solid sample #2 (0/5)
- [item=lead-ore] Lead ore (3/5)]])
end)

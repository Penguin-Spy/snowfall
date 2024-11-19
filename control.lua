--[[ control.lua © Penguin_Spy 2023
  Control-stage scripting for Snowfall mechanics
]]

local util = require "util"

require "scripts.trigger_effects"
require "scripts.destroy_handling"
local spaceship_gui = require "scripts.spaceship_gui"

if script.active_mods["gvv"] then require("__gvv__.gvv")() end

-- runs when the save is first created, before the freeplay crash site has been created
local function prepare_map()
  if remote.interfaces["freeplay"] then
    remote.call("freeplay", "set_created_items", {
      --["pistol"] = 1,
      --["firearm-magazine"] = 10
    })
    remote.call("freeplay", "set_ship_items", {})
    remote.call("freeplay", "set_debris_items", {
      ["lead-plate"] = 10,
      --?["brass-plate"] = 18,
      ["basic-gear"] = 2
    })
    remote.call("freeplay", "set_skip_intro", true)  -- dont show_message_dialog
  else
    game.print{"snowfall.error-no-freeplay-interface"}
  end
end

-- runs when the first player is created, after the freeplay crash site has been created
local function postpare_map()
  storage.postpare_map_ran = true

  -- do this here after the crash site sets it to 0.7
  local kiwen_lete = game.get_surface("nauvis")
  kiwen_lete.freeze_daytime = true
  kiwen_lete.daytime = 0.68
  
  local spaceship = kiwen_lete.find_entity("crash-site-spaceship", {-5,-6})
  storage.crash_site = {
    spaceship = spaceship,
    furnace = kiwen_lete.create_entity{
      name = "snowfall-spaceship-furnace",
      position = spaceship.position,
      force = spaceship.force
    },
    lab = kiwen_lete.create_entity{
      name = "snowfall-spaceship-lab",
      position = spaceship.position,
      force = spaceship.force
    },
    assembling_machine = kiwen_lete.create_entity{
      name = "snowfall-spaceship-assembling-machine",
      position = spaceship.position,
      force = spaceship.force
    }
  }
  storage.crash_site.lab.backer_name = "Kasane Teto"
end

script.on_event(defines.events.on_script_trigger_effect, function(event)
  local handler = trigger_effects[event.effect_id]
  if handler then handler(event) end  -- don't tail call so the debugger is happy :)
end)

script.on_event(defines.events.on_object_destroyed, destroy_handling.handle_event)

script.on_event(defines.events.on_gui_opened, function(event)
  local entity, crash_site = event.entity, storage.crash_site
  if entity == crash_site.furnace 
    or entity == crash_site.lab
    or entity == crash_site.assembling_machine
  then
    spaceship_gui.on_open(game.get_player(event.player_index), entity)
  end
end)
script.on_event(defines.events.on_gui_click, function(event)
  spaceship_gui.on_click(event)
end)

function initalize_player(player)
  log("Initalizing player "..player.name.."["..player.index.."]")
  spaceship_gui.initalize_player(player)
end

function initalize()
  log("Initalizing global data")
  ---@type table<uint64, destroy_handler_data>
  storage.destroy_handler_map = storage.destroy_handler_map or {}

  ---@type table<uint64, uint64>
  storage.unit_id_to_destroy_handler_id_map = storage.unit_id_to_destroy_handler_id_map or {}

  storage.crash_site = storage.crash_site or {}

  for _, player in pairs(game.players) do
    initalize_player(player)
  end
end

script.on_init(function()
  if game.tick ~= 0 then
    game.print{"snowfall.error-not-new-save"}
  end
  initalize()
  prepare_map()
end)
script.on_configuration_changed(initalize)

script.on_event(defines.events.on_player_created, function(event)
  if not storage.postpare_map_ran then
    postpare_map()
  end
  initalize_player(game.get_player(event.player_index))
end)


commands.add_command("snowfall", "debugging command", function(command)
  local player = game.get_player(command.player_index)  --[[@as LuaPlayer]]
  player.set_goal_description([[
Collect material samples:
- [img=utility/questionmark] Solid sample #1 (0/5)
- [img=utility/questionmark] Solid sample #2 (0/5)
- [item=lead-ore] Lead ore (3/5)]])
end)

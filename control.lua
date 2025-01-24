--[[ control.lua © Penguin_Spy 2023-2024
  Control-stage scripting for Snowfall mechanics
]]

require "util"
require "scripts.event_handler"

require "scripts.trigger_effects"
require "scripts.destroy_handling"
require "scripts.technology"
require "scripts.spaceship_gui"

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
  local kiwen_lete = game.get_surface("nauvis") ---@cast kiwen_lete -nil
  kiwen_lete.freeze_daytime = true
  kiwen_lete.daytime = 0.68

  local spaceship = kiwen_lete.find_entity("crash-site-spaceship", {-5,-6}) ---@cast spaceship -nil
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


local no_sound = {sound=defines.print_sound.never}
local lea_color = {color={129, 255, 80}}
script.on_nth_tick(30, function(event)
  -- crash site lore
  if event.tick <= (60 * 22) then
    local second = event.tick / 60
    if second == 0 then game.print({"snowfall.lea-intro-1"}, no_sound)
    elseif second == 2.5 then game.print({"snowfall.lea-intro-2"}, no_sound)
    elseif second == 4 then game.print({"snowfall.lea-intro-3"}, no_sound)
    elseif second == 5 then game.print({"snowfall.lea-intro-4"}, no_sound)
    elseif second == 7.5 then for _, player in pairs(game.players) do player.print({"snowfall.lea-intro-5", player.name}, lea_color) end
    elseif second == 12.5 then game.print({"snowfall.lea-intro-6"}, lea_color)
    elseif second == 17 then game.print({"snowfall.lea-intro-7"}, lea_color)
    elseif second == 22 then
      game.print({"snowfall.lea-intro-8"}, lea_color)
      for _, force in pairs(game.forces) do if #force.players > 0 then force.add_research("snowfall-mineral-survey") end end
    end
  end

  -- electronics research failing earlygame
  for _, force in pairs(game.forces) do
    if force.current_research and force.current_research.name == "snowfall-fake-electronics" then
      if force.research_progress > 0.75 then
        force.print({"snowfall.lea-electronics-research-failed"}, lea_color)
        -- hide researched electronics, show failed electronics
        force.technologies["snowfall-fake-electronics"].enabled = false
        force.technologies["snowfall-fake-electronics-failed"].visible_when_disabled = true
        force.technologies["snowfall-fake-electronics-failed"].saved_progress = 0.75
        --force.technologies["snowfall-electromechanics"].saved_progress = 0.5 -- some of the knowledge carries over
        force.technologies["automation-science-pack"].enabled = true
        force.cancel_current_research()
        -- set the most recent research to the failed version (assigning a TechnologyID works)
        ---@diagnostic disable-next-line: assign-type-mismatch
        force.previous_research = "snowfall-fake-electronics-failed"
      elseif force.research_progress > 0.5 and not storage.lore_progress_forces[force.index].electronics_not_working_shown then
        force.print({"snowfall.lea-electronics-research-not-working"}, lea_color)
        storage.lore_progress_forces[force.index].electronics_not_working_shown = true
      end
    end
  end
end)


function initalize()
  log("Initalizing global data")
  ---@type table<uint64, destroy_handler_data>
  storage.destroy_handler_map = storage.destroy_handler_map or {}

  ---@type table<uint64, uint64>
  storage.unit_id_to_destroy_handler_id_map = storage.unit_id_to_destroy_handler_id_map or {}

  storage.crash_site = storage.crash_site or {}

  ---@type table<integer, table>
  storage.lore_progress_forces = storage.lore_progress_forces or {}
  for _, force in pairs(game.forces) do -- also handle forces created/deleted
    storage.lore_progress_forces[force.index] = storage.lore_progress_forces[force.index] or {}
  end

  events.raise(events.initalize)

  for _, player in pairs(game.players) do
    log("Initalizing player "..player.name.."["..player.index.."]")
    events.raise(events.initalize_player, player)
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
  local player = game.get_player(event.player_index)  ---@cast player -nil
  log("Initalizing new player "..player.name.."["..player.index.."]")
  events.raise(events.initalize_player, player)
end)


commands.add_command("snowfall", "<survey|resources>", function(command)
  local player = game.get_player(command.player_index)  --[[@as LuaPlayer]]

  local paramaters = command.parameter and util.split(command.parameter, " ") or {}
  if paramaters[1] == "survey" then
    player.force.technologies["snowfall-mineral-survey"].researched = true

  elseif paramaters[1] == "resources" then
    player.insert{name="zinc-ore", count = 10}
    player.insert{name="lead-ore", count = 10}
    player.insert{name="nickel-ore", count = 10}

  elseif paramaters[1] == "reveal-techs" then -- note that this reveals all versions of the fake electronics
    for _, tech in pairs(player.force.technologies) do
      tech.enabled = true
    end

  else
    player.print[[/snowfall <survey|resources>
  survey    - completes the mineral survey research
  resources - gives 10 zinc, lead, & nickel ore
  reveal-techs - reveal all techs in the tech tree; will break stuff]]
  end
end)

events.register_events()
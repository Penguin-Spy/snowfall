--[[ scripts/misc.lua © Penguin_Spy 2025
  miscellaneous scripting for small Snowfall features
]]

---@param event EventData.on_player_mined_entity
events.on({events.on_player_mined_entity, events.on_robot_mined_entity, events.on_space_platform_mined_entity}, function (event)
  local burner = event.entity.burner
  if burner and burner.fuel_categories.steam and burner.currently_burning then
    event.buffer.insert{name = "empty-canister", amount = 1}
  end
end)

-- change victory screen info
events.on(events.initalize, function()
  game.set_win_ending_info{
    image_path = "__base__/script/freeplay/victory.png",
    title = {"", {"gui-game-finished.victory"}, {"snowfall.victory-disclaimer"}},
    message = {"snowfall.victory-message"},
    final_message = {"snowfall.victory-final-message"},
  }
end)

-- trigger victory when completing victory tech
---@param event EventData.on_research_finished
events.on(events.on_research_finished, function (event)
  if event.research.name == "rocket-silo" then
    game.reset_game_state()
    game.set_game_state{
      game_finished = true,
      player_won = true,
      can_continue = true,
      victorious_force = event.research.force
    }
  end
end)
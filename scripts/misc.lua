--[[ scripts/misc.lua © Penguin_Spy 2025
  miscellaneous scripting for small Snowfall features
]]

---@param event EventData.on_player_mined_entity
events.on({defines.events.on_player_mined_entity, defines.events.on_robot_mined_entity, defines.events.on_space_platform_mined_entity}, function (event)
  local burner = event.entity.burner
  if burner and burner.fuel_categories.steam and burner.currently_burning then
    event.buffer.insert{name = "empty-canister", amount = 1}
  end
end)

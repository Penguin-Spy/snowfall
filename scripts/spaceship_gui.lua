local spaceship_gui = {}

local function action(s)
  return {
    mod = script.mod_name,
    action = s
  }
end
local relative_gui_name = "snowfall_spaceship_gui_"

local function create_tabs(player, name, anchor)
  local relative = player.gui.relative
  local flow = relative.add{ type = "flow", style = "snowfall_tab_flow", name = name, anchor = anchor }
  flow.add{ type = "button", name = "furnace", caption = {"entity-name.snowfall-spaceship-furnace"}, style = "snowfall_tab_button", tags = action "open_furnace" }
  flow.add{ type = "button", name = "research", caption = {"entity-name.snowfall-spaceship-lab"}, style = "snowfall_tab_button", tags = action "open_research" }
end

local anchors = {
  furnace = { gui = defines.relative_gui_type.furnace_gui, position = defines.relative_gui_position.top, name = "snowfall-spaceship-furnace" },
  lab = { gui = defines.relative_gui_type.lab_gui, position = defines.relative_gui_position.top, name = "snowfall-spaceship-lab" },
  assembling_machine = { gui = defines.relative_gui_type.assembling_machine_gui, position = defines.relative_gui_position.top, name = "snowfall-spaceship-assembling-machine" },
}

function spaceship_gui.initalize_player(player)
  local relative = player.gui.relative
  for name, anchor in pairs(anchors) do
    local element = relative[relative_gui_name .. name]
    if element then element.destroy() end
    create_tabs(player, relative_gui_name .. name, anchor)
  end
end

function spaceship_gui.on_open(player, entity)
  -- set the current entity's tab to disabled to show the "selected" graphics
  if entity.name == "snowfall-spaceship-furnace" then
    player.gui.relative[relative_gui_name.."furnace"].furnace.enabled = false
    player.gui.relative[relative_gui_name.."furnace"].research.enabled = true
  else
    player.gui.relative[relative_gui_name.."lab"].furnace.enabled = true
    player.gui.relative[relative_gui_name.."lab"].research.enabled = false
    player.gui.relative[relative_gui_name.."assembling_machine"].furnace.enabled = true
    player.gui.relative[relative_gui_name.."assembling_machine"].research.enabled = false
  end
end

function spaceship_gui.on_click(event)
  local element = event.element
  if not (element and element.valid) then return end

  if element.tags.mod == script.mod_name then
    local player = game.players[event.player_index]

    local target
    if element.tags.action == "open_furnace" then
      target = storage.crash_site.furnace
    elseif element.tags.action == "open_research" then
      -- show the assembling machine before researching the mineral survey, and the lab afterwards
      target = player.force.technologies["snowfall-mineral-survey"].researched
        and storage.crash_site.lab or storage.crash_site.assembling_machine
    end

    if target then
      player.opened = target
      target.teleport(target.position) -- bring it to the front to be selected
    end
  end
end

return spaceship_gui
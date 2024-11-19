local styles = data.raw["gui-style"].default

styles["snowfall_tab_button"] = {
  type = "button_style",
  font = "default-bold",
  default_font_color = button_default_font_color,
  disabled_font_color = gui_color.caption,  -- instead of selected, the button is disabled when it's the active tab
  minimal_width = 84,
  height = 36,
  horizontal_align = "center",
  vertical_align = "center",
  top_padding = 7,
  right_padding = 8,
  bottom_padding = 9,
  left_padding = 8,
  default_graphical_set = {
    base = {position = {102, 0}, corner_size = 8},
    shadow = tab_glow(default_shadow_color, 0.5)
  },
  hovered_graphical_set = {
    base = {position = {153, 0}, corner_size = 8},
    glow = tab_glow(default_glow_color, 0.5)
  },
  game_controller_selected_hovered_graphical_set = {
    base = {position = {136, 0}, corner_size = 8},
    glow = tab_glow(default_glow_color, 0.5)
  },
  clicked_graphical_set = {
    base = {position = {170, 0}, corner_size = 8},
    shadow = tab_glow(default_shadow_color, 0.5)
  },
  disabled_graphical_set = {  -- actual disabled graphics for a tab, because it matches the color of the outer frame of the entity window
    base = {position = {119, 0}, corner_size = 8},
    shadow = tab_glow(default_shadow_color, 0.5)
  },
  left_click_sound = { filename = "__core__/sound/gui-tab.ogg" }
}

styles["snowfall_tab_flow"] = {
  type = "horizontal_flow_style",
  horizontal_spacing = 0,
  left_padding = 12,
  right_padding = 12,
}
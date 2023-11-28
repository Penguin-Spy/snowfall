data:extend{
  {
    type = "fluid",
    name = "methane",
    icon = data_util.graphics "icons/methane.png", icon_size = 64,
    default_temperature = -179,
    max_temperature = 25,
    gas_temperature = -161.5,
    heat_capacity = "0.1KJ",
    fuel_value = "20kJ",  -- 1000 units = half of coal
    base_color = {r = 0.25, g = 0.25, b = 0.25},
    flow_color = {r = 0.65, g = 0.65, b = 0.65},
    order = "a[fluid]-a[methane]"
  }
}

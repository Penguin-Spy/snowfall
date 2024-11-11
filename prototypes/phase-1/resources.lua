data:extend{
  {
    type = "resource-category",
    name = "snowfall-internal",
    hidden = true
  },
  { -- Ice bore hidden resource
    type = "resource",
    name = "snowfall-internal-ice",
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    stage_counts = {1},
    stages = {
      {
        filename = "__core__/graphics/empty.png",
        width = 1, height = 1, priority = "very-low"
      }
    },
    infinite = true,
    minimum = 1,
    infinite_depletion_amount = 0,
    minable = {mining_time = 1, result = "ice"},
    category = "snowfall-internal",
    hidden = true

  }  --[[@as data.ResourceEntityPrototype]],
  { -- Steam vent category
    type = "resource-category",
    name = "geothermal-vent"
  }
}

local steam_vent = table.deepcopy(data.raw["resource"]["crude-oil"])
steam_vent.name = "geothermal-vent"
steam_vent.category = "geothermal-vent"
steam_vent.minable ={
  mining_time = 1,
  results = {
    {
      type = "fluid",
      name = "steam",
      amount_min = 20,
      amount_max = 30,
      probability = 1,
      temperature = 200
    }
  }
}
data:extend{steam_vent}

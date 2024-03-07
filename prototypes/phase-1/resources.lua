-- Ice bore hidden resource
data:extend{
  {
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

  }  --[[@as data.ResourceEntityPrototype]],
  {
    type = "resource-category",
    name = "snowfall-internal"
  }
}

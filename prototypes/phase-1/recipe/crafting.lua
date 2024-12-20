data:extend{
  -- intermediates
  {
    type = "recipe",
    name = "basic-gear",  -- gear made from nickel. the brass one is "iron-gear-wheel" (the vanilla name) so other mods use it by default
    ingredients = {
      {type = "item", name = "nickel-plate", amount = 1}
    },
    results = {
      {type = "item", name = "basic-gear", amount = 2}
    },
    energy_required = 0.5
  },
  {
    type = "recipe",
    name = "snowfall-gearbox",
    ingredients = {
      {type = "item", name = "basic-gear", amount = 2},
      {type = "item", name = "nickel-plate", amount = 1}
    },
    results = {
      {type = "item", name = "snowfall-gearbox", amount = 1}
    },
    enabled = false,
    energy_required = 0.5
  },

  ---- entities ----

  -- drills
  {
    type = "recipe",
    name = "snowfall-burner-ice-bore",
    ingredients = { -- TODO: different recipe (so it's not too similar to the pneumatic drill)
      {type = "item", name = "stone-brick", amount = 4},
      {type = "item", name = "lead-plate",  amount = 2},
      {type = "item", name = "snowfall-gearbox", amount = 1},
    },
    results = {
      {type = "item", name = "snowfall-burner-ice-bore", amount = 1}
    },
    enabled = false,
    energy_required = 1
  },
  {
    type = "recipe",
    name = "snowfall-steam-vent-cap",
    ingredients = {
      {type = "item", name = "stone-brick", amount = 4},
      {type = "item", name = "lead-plate",  amount = 2},
      {type = "item", name = "pipe",        amount = 2},
    },
    results = {
      {type = "item", name = "snowfall-steam-vent-cap", amount = 1}
    },
    enabled = false,
    energy_required = 1
  },
  {
    type = "recipe",
    name = "snowfall-steam-vent-turbine",
    ingredients = {
      {type = "item", name = "stone-brick", amount = 4},
      {type = "item", name = "nickel-plate",  amount = 3},
      {type = "item", name = "copper-cable", amount = 12},
      {type = "item", name = "pipe",        amount = 2},
    },
    results = {
      {type = "item", name = "snowfall-steam-vent-turbine", amount = 1}
    },
    enabled = false,
    energy_required = 1
  },

  -- machines
  {
    type = "recipe",
    name = "snowfall-pneumatic-lab",
    ingredients = {
      {type = "item", name = "stone-brick", amount = 4},
      {type = "item", name = "basic-gear",  amount = 4},
      {type = "item", name = "lead-plate",  amount = 6},
    },
    results = {
      {type = "item", name = "snowfall-pneumatic-lab", amount = 1}
    },
    enabled = false,
    energy_required = 2
  },
  {
    type = "recipe",
    name = "snowfall-kiln",
    ingredients = {
      {type = "item", name = "stone", amount = 5},
    },
    results = {
      {type = "item", name = "snowfall-kiln", amount = 1}
    },
    enabled = false,
    energy_required = 1
  },
  --[[{
    type = "recipe",
    name = "snowfall-foundry",
    ingredients = {
      {type = "item", name = "stone-brick",         amount = 4},
      {type = "item", name = "snowfall-fire-brick", amount = 6},
    },
    results = {
      {type = "item", name = "snowfall-foundry", amount = 1}
    },
    energy_required = 2
  },]]
  {
    type = "recipe",
    name = "snowfall-rolling-machine",
    ingredients = {
      {type = "item", name = "stone-brick", amount = 4},
      {type = "item", name = "iron-stick",  amount = 4},
      {type = "item", name = "basic-gear",  amount = 2},
      --{type = "item", name = "motor",       amount = 1},
    },
    results = {
      {type = "item", name = "snowfall-rolling-machine", amount = 1}
    },
    energy_required = 3,
    enabled = false
  },
  {
    type = "recipe",
    name = "snowfall-drawing-machine",
    ingredients = {
      {type = "item", name = "stone-brick", amount = 4},
      {type = "item", name = "iron-plate",  amount = 4},
      {type = "item", name = "basic-gear",  amount = 2},
      --{type = "item", name = "motor",       amount = 1},
    },
    results = {
      {type = "item", name = "snowfall-drawing-machine", amount = 1}
    },
    energy_required = 3,
    enabled = false
  },
  {
    type = "recipe",
    name = "snowfall-solid-heat-exchanger",
    ingredients = {
      {type = "item", name = "iron-plate",   amount = 2},
      {type = "item", name = "copper-plate", amount = 10},
      {type = "item", name = "stone-brick",  amount = 5},
    },
    results = {
      {type = "item", name = "snowfall-solid-heat-exchanger", amount = 1}
    },
    enabled = false,
    energy_required = 2
  }
}

data:extend{
  -- items
  {
    type = "recipe",
    name = "snowfall-ingot-mold",
    ingredients = {
      {type = "item", name = "snowfall-fire-brick", amount = 2},
    },
    results = {
      {type = "item", name = "snowfall-ingot-mold", amount = 1}
    },
    energy_required = 3
  },
  {
    type = "recipe",
    name = "snowfall-gear-mold",
    ingredients = {
      {type = "item", name = "snowfall-fire-brick", amount = 2},
    },
    results = {
      {type = "item", name = "snowfall-gear-mold", amount = 1}
    },
    energy_required = 3
  },
  {
    type = "recipe",
    name = "snowfall-rod-mold",
    ingredients = {
      {type = "item", name = "snowfall-fire-brick", amount = 2},
    },
    results = {
      {type = "item", name = "snowfall-rod-mold", amount = 1}
    },
    energy_required = 3
  },

  -- machines
  {
    type = "recipe",
    name = "snowfall-kiln",
    ingredients = {
      {type = "item", name = "stone", amount = 5},
    },
    results = {
      {type = "item", name = "snowfall-kiln", amount = 1}
    },
    energy_required = 2
  },
  {
    type = "recipe",
    name = "snowfall-foundry",
    ingredients = {
      {type = "item", name = "stone-brick",         amount = 4},
      {type = "item", name = "snowfall-fire-brick", amount = 8},
    },
    results = {
      {type = "item", name = "snowfall-foundry", amount = 1}
    },
    energy_required = 3
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
    energy_required = 2
  }
}

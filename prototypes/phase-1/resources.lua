local resource_autoplace = require("resource-autoplace")
resource_autoplace.initialize_patch_set("geothermal-vent", true)

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
  },
  { -- Steam vent
    type = "resource",
    name = "geothermal-vent",
    icon = "__base__/graphics/icons/fluid/steam.png",
    flags = { "placeable-neutral" },
    category = "geothermal-vent",
    subgroup = "mineable-fluids",
    order = "a-b-b",
    infinite = true,
    highlight = true,
    minimum = 60000,
    normal = 300000,
    infinite_depletion_amount = 0, -- don't deplete
    resource_patch_search_radius = 12,
    tree_removal_probability = 0.7,
    tree_removal_max_distance = 32 * 32,
    minable = {
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
    },
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings{
      name = "geothermal-vent",
      order = "b", -- same as iron, copper, etc.
      base_density = 12,
      base_spots_per_km2 = 2.5,   -- same as ores
      random_probability = 1/12,
      random_spot_size_minimum = 1,
      random_spot_size_maximum = 1,
      additional_richness = 220000,
      has_starting_area_placement = true,
      regular_rq_factor_multiplier = 1
    },
    stage_counts = {0},
    stages = {
      {
        filename = data_util.graphics .. "entity/geothermal-vent/geothermal-vent.png",
        width = 168,
        height = 124,
        shift = util.by_pixel( 0.5, -2.0),
        line_length = 4,
        priority = "extra-high",
        scale = 0.5,
        variation_count = 1,
        frame_count = 4,
      }
    },
    draw_stateless_visualisation_under_building = false,
    stateless_visualisation = {
      {
        count = 1,
        render_layer = "smoke",
        animation = {
          filename = data_util.graphics .. "entity/geothermal-vent/vent-steam-outer.png",
          frame_count = 47,
          line_length = 16,
          width = 90,
          height = 188,
          animation_speed = 0.3,
          shift = util.by_pixel(-2, 24 -152),
          scale = 1.5,
          tint = util.multiply_color({r=0.3, g=0.3, b=0.3}, 0.5)
        }
      },
      {
        count = 1,
        render_layer = "smoke",
        animation = {
          filename = data_util.graphics .. "entity/geothermal-vent/vent-steam-inner.png",
          frame_count = 47,
          line_length = 16,
          width = 40,
          height = 84,
          animation_speed = 0.3,
          shift = util.by_pixel(0, 24 -78),
          scale = 1.5,
          tint = util.multiply_color({r=0.4, g=0.4, b=0.4}, 0.65)
        }
      }
    },
    map_color = {0.75, 0.7, 0.7},
    map_grid = false
  },
  {
    type = "autoplace-control",
    name = "geothermal-vent",
    localised_name = {"", "[entity=geothermal-vent] ", {"entity-name.geothermal-vent"}},
    order = "a-d", -- same as coal (which we remove)
    category = "resource",
    richness = true
  }
}

-- add steam vents to nauvis' autoplacement
data.raw.planet.nauvis.map_gen_settings.autoplace_settings.entity.settings["geothermal-vent"] = {}

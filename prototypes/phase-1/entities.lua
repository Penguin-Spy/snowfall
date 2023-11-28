data:extend{
  -- kiln
  {
    type = "assembling-machine",
    name = "snowfall-kiln",
    icon = "__base__/graphics/icons/stone-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "snowfall-kiln"},
    max_health = 200,
    corpse = "stone-furnace-remnants",
    dying_explosion = "stone-furnace-explosion",
    repair_sound = data_util.sounds.manual_repair,
    mined_sound = data_util.sounds.deconstruct_bricks(0.8),
    open_sound = data_util.sounds.machine_open,
    close_sound = data_util.sounds.machine_close,
    vehicle_impact_sound = data_util.sounds.car_stone_impact,
    working_sound = {
      sound = {
        {
          filename = "__base__/sound/furnace.ogg",
          volume = 0.6
        }
      },
      fade_in_ticks = 4,
      fade_out_ticks = 20,
      audible_distance_modifier = 0.4
    },
    resistances = {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "explosion",
        percent = 30
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-1.29, -0.79}, {1.29, 0.79}},
    selection_box = {{-1.5, -1}, {1.5, 1}},
    damaged_trigger_effect = data_util.hit_effects.rock(),
    crafting_categories = {"kiln"},
    energy_usage = "90kW",
    crafting_speed = 1,
    energy_source = {
      type = "fluid",
      burns_fluid = true,
      scale_fluid_usage = true,
      effectivity = 1,
      emissions_per_minute = 2,
      fluid_box = {
        production_type = "input-output",
        filter = "methane",
        base_area = 1,   -- storage volume of 100 (base_area*height*100)
        height = 1,      -- default
        base_level = 0,  -- default
        pipe_connections = {
          {type = "input-output", position = {0, -1.5}},
          {type = "input-output", position = {0, 1.5}},
        },
        secondary_draw_orders = {north = -1},
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
      },
      light_flicker =
      {
        color = {0, 0, 0},
        minimum_intensity = 0.6,
        maximum_intensity = 0.95
      },
      smoke = {
        {
          name = "smoke",
          deviation = {0.1, 0.1},
          frequency = 5,
          position = {0.0, -0.8},
          starting_vertical_speed = 0.08,
          starting_frame_deviation = 60
        }
      }
    },
    animation = {
      layers = {
        {
          filename = "__base__/graphics/entity/stone-furnace/stone-furnace.png",
          priority = "extra-high",
          width = 81,
          height = 64,
          frame_count = 1,
          shift = util.by_pixel(14.5, 2),
          hr_version =
          {
            filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace.png",
            priority = "extra-high",
            width = 151,
            height = 146,
            frame_count = 1,
            shift = util.by_pixel(-0.25, 6),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/stone-furnace/stone-furnace-shadow.png",
          priority = "extra-high",
          width = 81,
          height = 64,
          frame_count = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(14.5, 2),
          hr_version =
          {
            filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-shadow.png",
            priority = "extra-high",
            width = 164,
            height = 74,
            frame_count = 1,
            draw_as_shadow = true,
            force_hr_shadow = true,
            shift = util.by_pixel(14.5, 13),
            scale = 0.5
          }
        }
      }
    },
    working_visualisations = {
      {
        draw_as_light = true,
        fadeout = true,
        effect = "flicker",
        animation =
        {
          layers =
          {
            {
              filename = "__base__/graphics/entity/stone-furnace/stone-furnace-fire.png",
              priority = "extra-high",
              line_length = 8,
              width = 20,
              height = 49,
              frame_count = 48,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(-0.5, 5.5),
              hr_version =
              {
                filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-fire.png",
                priority = "extra-high",
                line_length = 8,
                width = 41,
                height = 100,
                frame_count = 48,
                axially_symmetrical = false,
                direction_count = 1,
                shift = util.by_pixel(-0.75, 5.5),
                scale = 0.5
              }
            },
            {
              filename = "__base__/graphics/entity/stone-furnace/stone-furnace-light.png",
              blend_mode = "additive",
              width = 54,
              height = 74,
              repeat_count = 48,
              shift = util.by_pixel(0, 4),
              hr_version =
              {
                filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-light.png",
                blend_mode = "additive",
                width = 106,
                height = 144,
                repeat_count = 48,
                shift = util.by_pixel(0, 5),
                scale = 0.5,
              }
            },
          }
        }
      },
      {
        draw_as_light = true,
        draw_as_sprite = false,
        fadeout = true,
        effect = "flicker",
        animation =
        {
          filename = "__base__/graphics/entity/stone-furnace/stone-furnace-ground-light.png",
          blend_mode = "additive",
          draw_as_sprite = false,
          width = 56,
          height = 56,
          repeat_count = 48,
          shift = util.by_pixel(0, 44),
          hr_version =
          {
            filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-ground-light.png",
            blend_mode = "additive",
            draw_as_sprite = false,
            width = 116,
            height = 110,
            repeat_count = 48,
            shift = util.by_pixel(-1, 44),
            scale = 0.5,
          }
        },
      },
    },
    water_reflection = {
      pictures =
      {
        filename = "__base__/graphics/entity/stone-furnace/stone-furnace-reflection.png",
        priority = "extra-high",
        width = 16,
        height = 16,
        shift = util.by_pixel(0, 35),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    }
  },

  -- foundry
  {
    type = "assembling-machine",
    name = "snowfall-foundry",
    icon = "__base__/graphics/icons/stone-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "snowfall-foundry"},
    max_health = 200,
    corpse = "stone-furnace-remnants",
    dying_explosion = "stone-furnace-explosion",
    repair_sound = data_util.sounds.manual_repair,
    mined_sound = data_util.sounds.deconstruct_bricks(0.8),
    open_sound = data_util.sounds.machine_open,
    close_sound = data_util.sounds.machine_close,
    vehicle_impact_sound = data_util.sounds.car_stone_impact,
    working_sound = {
      sound = {
        {
          filename = "__base__/sound/furnace.ogg",
          volume = 0.6
        }
      },
      fade_in_ticks = 4,
      fade_out_ticks = 20,
      audible_distance_modifier = 0.4
    },
    resistances = {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "explosion",
        percent = 30
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-1.29, -0.79}, {1.29, 0.79}},
    selection_box = {{-1.5, -1}, {1.5, 1}},
    damaged_trigger_effect = data_util.hit_effects.rock(),
    crafting_categories = {"snowfall-direct-casting", "snowfall-direct-alloying"},
    energy_usage = "90kW",
    crafting_speed = 1,
    energy_source = {
      type = "fluid",
      burns_fluid = true,
      scale_fluid_usage = true,
      effectivity = 1,
      emissions_per_minute = 2,
      fluid_box = {
        production_type = "input-output",
        filter = "methane",
        base_area = 1,   -- storage volume of 100 (base_area*height*100)
        height = 1,      -- default
        base_level = 0,  -- default
        pipe_connections = {
          {type = "input-output", position = {0, -1.5}},
          {type = "input-output", position = {0, 1.5}},
        },
        secondary_draw_orders = {north = -1},
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
      },
      light_flicker =
      {
        color = {0, 0, 0},
        minimum_intensity = 0.6,
        maximum_intensity = 0.95
      },
      smoke = {
        {
          name = "smoke",
          deviation = {0.1, 0.1},
          frequency = 5,
          position = {0.0, -0.8},
          starting_vertical_speed = 0.08,
          starting_frame_deviation = 60
        }
      }
    },
    animation = {
      layers = {
        {
          filename = "__base__/graphics/entity/stone-furnace/stone-furnace.png",
          priority = "extra-high",
          width = 81,
          height = 64,
          frame_count = 1,
          shift = util.by_pixel(14.5, 2),
          hr_version =
          {
            filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace.png",
            priority = "extra-high",
            width = 151,
            height = 146,
            frame_count = 1,
            shift = util.by_pixel(-0.25, 6),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/stone-furnace/stone-furnace-shadow.png",
          priority = "extra-high",
          width = 81,
          height = 64,
          frame_count = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(14.5, 2),
          hr_version =
          {
            filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-shadow.png",
            priority = "extra-high",
            width = 164,
            height = 74,
            frame_count = 1,
            draw_as_shadow = true,
            force_hr_shadow = true,
            shift = util.by_pixel(14.5, 13),
            scale = 0.5
          }
        }
      }
    },
    working_visualisations = {
      {
        draw_as_light = true,
        fadeout = true,
        effect = "flicker",
        animation =
        {
          layers =
          {
            {
              filename = "__base__/graphics/entity/stone-furnace/stone-furnace-fire.png",
              priority = "extra-high",
              line_length = 8,
              width = 20,
              height = 49,
              frame_count = 48,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(-0.5, 5.5),
              hr_version =
              {
                filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-fire.png",
                priority = "extra-high",
                line_length = 8,
                width = 41,
                height = 100,
                frame_count = 48,
                axially_symmetrical = false,
                direction_count = 1,
                shift = util.by_pixel(-0.75, 5.5),
                scale = 0.5
              }
            },
            {
              filename = "__base__/graphics/entity/stone-furnace/stone-furnace-light.png",
              blend_mode = "additive",
              width = 54,
              height = 74,
              repeat_count = 48,
              shift = util.by_pixel(0, 4),
              hr_version =
              {
                filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-light.png",
                blend_mode = "additive",
                width = 106,
                height = 144,
                repeat_count = 48,
                shift = util.by_pixel(0, 5),
                scale = 0.5,
              }
            },
          }
        }
      },
      {
        draw_as_light = true,
        draw_as_sprite = false,
        fadeout = true,
        effect = "flicker",
        animation =
        {
          filename = "__base__/graphics/entity/stone-furnace/stone-furnace-ground-light.png",
          blend_mode = "additive",
          draw_as_sprite = false,
          width = 56,
          height = 56,
          repeat_count = 48,
          shift = util.by_pixel(0, 44),
          hr_version =
          {
            filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-ground-light.png",
            blend_mode = "additive",
            draw_as_sprite = false,
            width = 116,
            height = 110,
            repeat_count = 48,
            shift = util.by_pixel(-1, 44),
            scale = 0.5,
          }
        },
      },
    },
    water_reflection = {
      pictures =
      {
        filename = "__base__/graphics/entity/stone-furnace/stone-furnace-reflection.png",
        priority = "extra-high",
        width = 16,
        height = 16,
        shift = util.by_pixel(0, 35),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    }
  },

  -- caster
  --[[
  {
    type = "assembling-machine",
    name = "snowfall-caster",
    icon = "__base__/graphics/icons/stone-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "snowfall-caster"},
    max_health = 200,
    corpse = "stone-furnace-remnants",
    dying_explosion = "stone-furnace-explosion",
    repair_sound = data_util.sounds.manual_repair,
    mined_sound = data_util.sounds.deconstruct_bricks(0.8),
    open_sound = data_util.sounds.machine_open,
    close_sound = data_util.sounds.machine_close,
    vehicle_impact_sound = data_util.sounds.car_stone_impact,
    working_sound = {
      sound = {
        {
          filename = "__base__/sound/furnace.ogg",
          volume = 0.6
        }
      },
      fade_in_ticks = 4,
      fade_out_ticks = 20,
      audible_distance_modifier = 0.4
    },
    resistances = {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "explosion",
        percent = 30
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-0.79, -0.79}, {0.79, 0.79}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = data_util.hit_effects.rock(),
    crafting_categories = {"snowfall-caster"},
    energy_usage = "0kW",
    crafting_speed = 1,
    energy_source = {
      type = "void",
    },
    animation = {
      layers = {
        {
          filename = "__base__/graphics/entity/stone-furnace/stone-furnace.png",
          priority = "extra-high",
          width = 81,
          height = 64,
          frame_count = 1,
          shift = util.by_pixel(14.5, 2),
          hr_version =
          {
            filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace.png",
            priority = "extra-high",
            width = 151,
            height = 146,
            frame_count = 1,
            shift = util.by_pixel(-0.25, 6),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/stone-furnace/stone-furnace-shadow.png",
          priority = "extra-high",
          width = 81,
          height = 64,
          frame_count = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(14.5, 2),
          hr_version =
          {
            filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-shadow.png",
            priority = "extra-high",
            width = 164,
            height = 74,
            frame_count = 1,
            draw_as_shadow = true,
            force_hr_shadow = true,
            shift = util.by_pixel(14.5, 13),
            scale = 0.5
          }
        }
      }
    },
    working_visualisations = {
      {
        draw_as_light = true,
        fadeout = true,
        effect = "flicker",
        animation =
        {
          layers =
          {
            {
              filename = "__base__/graphics/entity/stone-furnace/stone-furnace-fire.png",
              priority = "extra-high",
              line_length = 8,
              width = 20,
              height = 49,
              frame_count = 48,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(-0.5, 5.5),
              hr_version =
              {
                filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-fire.png",
                priority = "extra-high",
                line_length = 8,
                width = 41,
                height = 100,
                frame_count = 48,
                axially_symmetrical = false,
                direction_count = 1,
                shift = util.by_pixel(-0.75, 5.5),
                scale = 0.5
              }
            },
            {
              filename = "__base__/graphics/entity/stone-furnace/stone-furnace-light.png",
              blend_mode = "additive",
              width = 54,
              height = 74,
              repeat_count = 48,
              shift = util.by_pixel(0, 4),
              hr_version =
              {
                filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-light.png",
                blend_mode = "additive",
                width = 106,
                height = 144,
                repeat_count = 48,
                shift = util.by_pixel(0, 5),
                scale = 0.5,
              }
            },
          }
        }
      },
      {
        draw_as_light = true,
        draw_as_sprite = false,
        fadeout = true,
        effect = "flicker",
        animation =
        {
          filename = "__base__/graphics/entity/stone-furnace/stone-furnace-ground-light.png",
          blend_mode = "additive",
          draw_as_sprite = false,
          width = 56,
          height = 56,
          repeat_count = 48,
          shift = util.by_pixel(0, 44),
          hr_version =
          {
            filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-ground-light.png",
            blend_mode = "additive",
            draw_as_sprite = false,
            width = 116,
            height = 110,
            repeat_count = 48,
            shift = util.by_pixel(-1, 44),
            scale = 0.5,
          }
        },
      },
    },
    water_reflection = {
      pictures =
      {
        filename = "__base__/graphics/entity/stone-furnace/stone-furnace-reflection.png",
        priority = "extra-high",
        width = 16,
        height = 16,
        shift = util.by_pixel(0, 35),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
]]

  -- rolling machine
  {
    type = "assembling-machine",
    name = "snowfall-rolling-machine",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "snowfall-rolling-machine"},
    max_health = 300,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "assembling-machine-1-explosion",
    resistances = {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = {{-0.75, -0.35}, {0.75, 0.35}},
    selection_box = {{-1, -0.5}, {1, 0.5}},
    damaged_trigger_effect = data_util.hit_effects.entity(),
    alert_icon_shift = util.by_pixel(-3, -12),
    animation = {
      layers = {
        {
          filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1.png",
          priority = "high",
          width = 108,
          height = 114,
          frame_count = 32,
          line_length = 8,
          shift = util.by_pixel(0, 2),
          hr_version = {
            filename = "__base__/graphics/entity/assembling-machine-1/hr-assembling-machine-1.png",
            priority = "high",
            width = 214,
            height = 226,
            frame_count = 32,
            line_length = 8,
            shift = util.by_pixel(0, 2),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1-shadow.png",
          priority = "high",
          width = 95,
          height = 83,
          frame_count = 1,
          line_length = 1,
          repeat_count = 32,
          draw_as_shadow = true,
          shift = util.by_pixel(8.5, 5.5),
          hr_version = {
            filename = "__base__/graphics/entity/assembling-machine-1/hr-assembling-machine-1-shadow.png",
            priority = "high",
            width = 190,
            height = 165,
            frame_count = 1,
            line_length = 1,
            repeat_count = 32,
            draw_as_shadow = true,
            shift = util.by_pixel(8.5, 5),
            scale = 0.5
          }
        }
      }
    },
    crafting_categories = {"rolling"},
    crafting_speed = 4,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4
    },
    energy_usage = "75kW",
    open_sound = data_util.sounds.machine_open,
    close_sound = data_util.sounds.machine_close,
    vehicle_impact_sound = data_util.sounds.generic_impact,
    working_sound = {
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t1-1.ogg",
          volume = 0.5
        }
      },
      audible_distance_modifier = 0.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    }
  },

  -- drawing machine
  {
    type = "assembling-machine",
    name = "snowfall-drawing-machine",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "snowfall-drawing-machine"},
    max_health = 300,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "assembling-machine-1-explosion",
    resistances = {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = {{-0.8, -0.4}, {0.8, 0.4}},
    selection_box = {{-1, -0.5}, {1, 0.5}},
    damaged_trigger_effect = data_util.hit_effects.entity(),
    alert_icon_shift = util.by_pixel(-3, -12),
    animation = {
      layers = {
        {
          filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1.png",
          priority = "high",
          width = 108,
          height = 114,
          frame_count = 32,
          line_length = 8,
          shift = util.by_pixel(0, 2),
          hr_version = {
            filename = "__base__/graphics/entity/assembling-machine-1/hr-assembling-machine-1.png",
            priority = "high",
            width = 214,
            height = 226,
            frame_count = 32,
            line_length = 8,
            shift = util.by_pixel(0, 2),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1-shadow.png",
          priority = "high",
          width = 95,
          height = 83,
          frame_count = 1,
          line_length = 1,
          repeat_count = 32,
          draw_as_shadow = true,
          shift = util.by_pixel(8.5, 5.5),
          hr_version = {
            filename = "__base__/graphics/entity/assembling-machine-1/hr-assembling-machine-1-shadow.png",
            priority = "high",
            width = 190,
            height = 165,
            frame_count = 1,
            line_length = 1,
            repeat_count = 32,
            draw_as_shadow = true,
            shift = util.by_pixel(8.5, 5),
            scale = 0.5
          }
        }
      }
    },
    crafting_categories = {"wire-drawing"},
    crafting_speed = 4,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4
    },
    energy_usage = "75kW",
    open_sound = data_util.sounds.machine_open,
    close_sound = data_util.sounds.machine_close,
    vehicle_impact_sound = data_util.sounds.generic_impact,
    working_sound = {
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t1-1.ogg",
          volume = 0.5
        }
      },
      audible_distance_modifier = 0.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    }
  },

  -- Solid Heat Exchanger
  {
    type = "furnace",
    name = "snowfall-solid-heat-exchanger",
    icon = "__base__/graphics/icons/stone-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "snowfall-solid-heat-exchanger"},
    max_health = 200,
    corpse = "heat-exchanger-remnants",
    dying_explosion = "heat-exchanger-explosion",
    repair_sound = data_util.sounds.manual_repair,
    mined_sound = data_util.sounds.deconstruct_bricks(0.8),
    open_sound = data_util.sounds.machine_open,
    close_sound = data_util.sounds.machine_close,
    vehicle_impact_sound = data_util.sounds.generic_impact,
    working_sound = {
      sound = {
        {
          filename = "__base__/sound/furnace.ogg",
          volume = 0.6
        }
      },
      fade_in_ticks = 4,
      fade_out_ticks = 20,
      audible_distance_modifier = 0.4
    },
    resistances = {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "explosion",
        percent = 30
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-1.29, -0.79}, {1.29, 0.79}},
    selection_box = {{-1.5, -1}, {1.5, 1}},
    damaged_trigger_effect = data_util.hit_effects.rock(),
    crafting_categories = {"snowfall-melting"},
    cant_insert_at_source_message_key = "inventory-restriction.snowfall-cant-be-melted",
    result_inventory_size = 0,
    energy_usage = "90kW",
    crafting_speed = 1,
    source_inventory_size = 1,
    fluid_boxes = {
      {  -- crafting machine docs example
        production_type = "output",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{type = "output", position = {0, -1.5}}},
        secondary_draw_orders = {north = -1}
      }
    },

    energy_source = {
      type = "heat",
      max_temperature = 100,
      specific_heat = "1MJ",
      max_transfer = "500MW",
      min_working_temperature = 15,
      minimum_glow_temperature = 1,
      connections = {
        {
          position = {0, 0.5},
          direction = defines.direction.south
        }
      },
      --[[pipe_covers = make_4way_animation_from_spritesheet{
        filename = "__base__/graphics/entity/heat-exchanger/heatex-endings.png",
        width = 32,
        height = 32,
        direction_count = 4,
        hr_version = {
          filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-endings.png",
          width = 64,
          height = 64,
          direction_count = 4,
          scale = 0.5
        }
      },]]
      heat_pipe_covers = make_4way_animation_from_spritesheet(
        apply_heat_pipe_glow{
          filename = "__base__/graphics/entity/heat-exchanger/heatex-endings-heated.png",
          width = 32,
          height = 32,
          direction_count = 4,
          hr_version = {
            filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-endings-heated.png",
            width = 64,
            height = 64,
            direction_count = 4,
            scale = 0.5
          }
        }),
      heat_picture = {
        north = apply_heat_pipe_glow{
          filename = "__base__/graphics/entity/heat-exchanger/heatex-N-heated.png",
          priority = "extra-high",
          width = 24,
          height = 48,
          shift = util.by_pixel(-1, 8),
          hr_version = {
            filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-N-heated.png",
            priority = "extra-high",
            width = 44,
            height = 96,
            shift = util.by_pixel(-0.5, 8.5),
            scale = 0.5
          }
        },
        east = apply_heat_pipe_glow{
          filename = "__base__/graphics/entity/heat-exchanger/heatex-E-heated.png",
          priority = "extra-high",
          width = 40,
          height = 40,
          shift = util.by_pixel(-21, -13),
          hr_version = {
            filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-E-heated.png",
            priority = "extra-high",
            width = 80,
            height = 80,
            shift = util.by_pixel(-21, -13),
            scale = 0.5
          }
        },
        south = apply_heat_pipe_glow{
          filename = "__base__/graphics/entity/heat-exchanger/heatex-S-heated.png",
          priority = "extra-high",
          width = 16,
          height = 20,
          shift = util.by_pixel(-1, -30),
          hr_version = {
            filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-S-heated.png",
            priority = "extra-high",
            width = 28,
            height = 40,
            shift = util.by_pixel(-1, -30),
            scale = 0.5
          }
        },
        west = apply_heat_pipe_glow{
          filename = "__base__/graphics/entity/heat-exchanger/heatex-W-heated.png",
          priority = "extra-high",
          width = 32,
          height = 40,
          shift = util.by_pixel(23, -13),
          hr_version = {
            filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-W-heated.png",
            priority = "extra-high",
            width = 64,
            height = 76,
            shift = util.by_pixel(23, -13),
            scale = 0.5
          }
        }
      }
    },
    animation = {
      north = {
        layers = {
          {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-N-idle.png",
            priority = "extra-high",
            width = 131,
            height = 108,
            shift = util.by_pixel(-0.5, 4),
            hr_version = {
              filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-N-idle.png",
              priority = "extra-high",
              width = 269,
              height = 221,
              shift = util.by_pixel(-1.25, 5.25),
              scale = 0.5
            }
          },
          {
            filename = "__base__/graphics/entity/boiler/boiler-N-shadow.png",
            priority = "extra-high",
            width = 137,
            height = 82,
            shift = util.by_pixel(20.5, 9),
            draw_as_shadow = true,
            hr_version = {
              filename = "__base__/graphics/entity/boiler/hr-boiler-N-shadow.png",
              priority = "extra-high",
              width = 274,
              height = 164,
              scale = 0.5,
              shift = util.by_pixel(20.5, 9),
              draw_as_shadow = true
            }
          }
        }
      },
      east = {
        layers = {
          {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-E-idle.png",
            priority = "extra-high",
            width = 102,
            height = 147,
            shift = util.by_pixel(-2, -0.5),
            hr_version = {
              filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-E-idle.png",
              priority = "extra-high",
              width = 211,
              height = 301,
              shift = util.by_pixel(-1.75, 1.25),
              scale = 0.5
            }
          },
          {
            filename = "__base__/graphics/entity/boiler/boiler-E-shadow.png",
            priority = "extra-high",
            width = 92,
            height = 97,
            shift = util.by_pixel(30, 9.5),
            draw_as_shadow = true,
            hr_version = {
              filename = "__base__/graphics/entity/boiler/hr-boiler-E-shadow.png",
              priority = "extra-high",
              width = 184,
              height = 194,
              scale = 0.5,
              shift = util.by_pixel(30, 9.5),
              draw_as_shadow = true
            }
          }
        }
      },
      south = {
        layers = {
          {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-S-idle.png",
            priority = "extra-high",
            width = 128,
            height = 100,
            shift = util.by_pixel(3, 10),
            hr_version = {
              filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-S-idle.png",
              priority = "extra-high",
              width = 260,
              height = 201,
              shift = util.by_pixel(4, 10.75),
              scale = 0.5
            }
          },
          {
            filename = "__base__/graphics/entity/boiler/boiler-S-shadow.png",
            priority = "extra-high",
            width = 156,
            height = 66,
            shift = util.by_pixel(30, 16),
            draw_as_shadow = true,
            hr_version = {
              filename = "__base__/graphics/entity/boiler/hr-boiler-S-shadow.png",
              priority = "extra-high",
              width = 311,
              height = 131,
              scale = 0.5,
              shift = util.by_pixel(29.75, 15.75),
              draw_as_shadow = true
            }
          }
        }
      },
      west = {
        layers = {
          {
            filename = "__base__/graphics/entity/heat-exchanger/heatex-W-idle.png",
            priority = "extra-high",
            width = 96,
            height = 132,
            shift = util.by_pixel(1, 5),
            hr_version = {
              filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-W-idle.png",
              priority = "extra-high",
              width = 196,
              height = 273,
              shift = util.by_pixel(1.5, 7.75),
              scale = 0.5
            }
          },
          {
            filename = "__base__/graphics/entity/boiler/boiler-W-shadow.png",
            priority = "extra-high",
            width = 103,
            height = 109,
            shift = util.by_pixel(19.5, 6.5),
            draw_as_shadow = true,
            hr_version = {
              filename = "__base__/graphics/entity/boiler/hr-boiler-W-shadow.png",
              priority = "extra-high",
              width = 206,
              height = 218,
              scale = 0.5,
              shift = util.by_pixel(19.5, 6.5),
              draw_as_shadow = true
            }
          }
        }
      }
    },
    working_visualisations = nil,  -- todo
    water_reflection = boiler_reflection()
  }
}

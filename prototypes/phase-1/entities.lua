-- ice bore & its placer

local collision_mask_util = require("collision-mask-util")

local burner_ice_bore = table.deepcopy(data.raw["mining-drill"]["burner-mining-drill"])
burner_ice_bore.name = "snowfall-burner-ice-bore"
burner_ice_bore.resource_categories = { "snowfall-internal" }
burner_ice_bore.collision_mask = collision_mask_util.get_default_mask("mining-drill")
burner_ice_bore.collision_mask.layers.not_ice_tile = true
burner_ice_bore.energy_usage = "150kW"  -- same as burner drill
burner_ice_bore.mining_speed = 0.2
burner_ice_bore.minable.result = "snowfall-burner-ice-bore"
burner_ice_bore.placeable_by = { item = "snowfall-burner-ice-bore", count = 1 }
burner_ice_bore.fast_replaceable_group = nil


local burner_ice_bore_placer = data_util.generate_placer(burner_ice_bore, "simple-entity-with-owner", {
  created_effect = data_util.created_effect("snowfall_placed_ice_bore"),
  picture = burner_ice_bore.animations,
  animations = nil,
  localised_description = { "",
    { "entity-description.snowfall-burner-ice-bore" }, "\n",
    { "",
      "[font=default-bold][color=#f8e0bb]", { "description.mining-speed" }, ":[/color][/font] ", tostring(burner_ice_bore.mining_speed), { "per-second-suffix" },
      "\n[font=default-bold][color=#f8e0bb]", { "description.efficiency-penalty-range" }, ":[/color][/font] 16",
      "\n[font=default-bold][color=#f8e0bb]", { "description.pollution" }, ":[/color][/font] " .. tostring(burner_ice_bore.energy_source.emissions_per_minute.pollution), { "per-minute-suffix" }, "\n",
    },
    { "",
      "[img=tooltip-category-consumes] [font=default-bold][color=#f8cd48]", { "tooltip-category.consumes" }, " ", { "fluid-name.steam" }, "[/color]\n[color=#f8e0bb]",
      { "description.max-energy-consumption" }, ":[/color][/font] " .. tostring(util.parse_energy(burner_ice_bore.energy_usage) * 0.06), " ", { "si-prefix-symbol-kilo" }, { "si-unit-symbol-watt" }
    }
  }
})


-- solar mirror internal reactors
local function generate_solar_mirror_reactor(name, connection)
  return {
    type = "reactor",
    name = name,
    selection_box = { { -1, -1 }, { 1, 1 } },
    icon = "__base__/graphics/icons/solar-panel.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = { "placeable-neutral", "placeable-player" },
    hidden = true,
    max_health = 100,

    consumption = "720kW",
    energy_source = { type = "void" },
    neighbour_bonus = 0,

    heat_buffer = {
      default_temperature = 15,
      max_temperature = 500,
      max_transfer = "720kW",
      specific_heat = "10kJ",
      connections = {
        connection
      }
    },
    picture = {
      filename = "__core__/graphics/empty.png",
      size = 1
    },
    working_light_picture = {
      filename = "__core__/graphics/empty.png",
      size = 1
    }
  }  --[[@as data.ReactorPrototype]]
end


data:extend{
  -- burner ice bore
  burner_ice_bore,
  burner_ice_bore_placer,

  -- steam vent cap
  {
    type = "mining-drill",
    name = "snowfall-steam-vent-cap",
    icon = "__base__/graphics/icons/pipe-to-ground.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 0.5, result = "snowfall-steam-vent-cap" },
    resource_categories = { "geothermal-vent" },
    max_health = 150,
    corpse = "pumpjack-remnants",
    dying_explosion = "pumpjack-explosion",
    collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    damaged_trigger_effect = data_util.hit_effects.entity(),
    drawing_box = { { -1.6, -2.5 }, { 1.5, 1.6 } },
    target_temperature = 250,
    energy_source = { type = "void" },
    output_fluid_box = {
      volume = 1000,
      pipe_covers = pipecoverspictures(),
      pipe_connections = {
        {
          direction = defines.direction.north,
          positions = {{1, -1}, {1, -1}, {-1, 1}, {-1, 1}},
          flow_direction = "output"
        }
      }
    },
    energy_usage = "90kW",
    mining_speed = 1,
    resource_searching_radius = 0.49,
    vector_to_place_result = { 0, 0 },
    radius_visualisation_picture = {
      filename = "__base__/graphics/entity/pumpjack/pumpjack-radius-visualization.png",
      width = 12,
      height = 12
    },
    monitor_visualization_tint = { r = 78, g = 173, b = 255 },
    base_render_layer = "lower-object-above-shadow",
    base_picture = {
      sheets = {
        {
          filename = data_util.graphics .. "entity/steam-vent-cap.png",
          priority = "extra-high",
          width = 261,
          height = 273,
          shift = util.by_pixel(-2.25, -4.75),
          scale = 0.5
        },
        {
          filename = data_util.graphics .. "entity/steam-vent-cap-shadow.png",
          width = 220,
          height = 220,
          scale = 0.5,
          draw_as_shadow = true,
          shift = util.by_pixel(6, 0.5)
        }
      }
    },
    vehicle_impact_sound = data_util.sounds.generic_impact,
    open_sound = data_util.sounds.machine_open,
    close_sound = data_util.sounds.machine_close,

    circuit_wire_connection_points = circuit_connector_definitions["pumpjack"].points,
    circuit_connector_sprites = circuit_connector_definitions["pumpjack"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance
  }  --[[@as data.MiningDrillPrototype]],

  -- solar mirror
  {
    type = "simple-entity-with-owner",
    name = "snowfall-solar-mirror",
    collision_box = { { -0.79, -0.79 }, { 0.79, 0.79 } },
    selection_box = { { -1, -1 }, { 1, 1 } },
    icon = "__base__/graphics/icons/solar-panel.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.2, result = "snowfall-solar-mirror" },
    max_health = 100,
    created_effect = data_util.created_effect("snowfall_placed_solar_mirror"),

    picture = {
      sheet = {
        filename = data_util.graphics .. "entity/solar-mirror.png",
        width = 64,
        height = 64
      },
    }
  }  --[[@as data.SimpleEntityWithOwnerPrototype]],

  -- solar mirror internal reactors
  generate_solar_mirror_reactor("snowfall-solar-mirror-reactor-north", { position = { 0, -1 }, direction = defines.direction.north }),
  generate_solar_mirror_reactor("snowfall-solar-mirror-reactor-east", { position = { 1, 0 }, direction = defines.direction.east }),
  generate_solar_mirror_reactor("snowfall-solar-mirror-reactor-south", { position = { 0, 1 }, direction = defines.direction.south }),
  generate_solar_mirror_reactor("snowfall-solar-mirror-reactor-west", { position = { -1, 0 }, direction = defines.direction.west }),

  -- crashed ship RTG heat generator
  --[=[]]{
    type = "reactor",
    name = "snowfall-crash-site-rtg",
    collision_box = {{-2.4, -1.9}, {2.4, 1.9}},
    selection_box = {{-2.5, -2}, {2.5, 2}},
    icons = {{icon = "__base__/graphics/icons/fusion-reactor-equipment.png", icon_size = 64, icon_mipmaps = 4}},
    flags = {"placeable-neutral"},
    max_health = 500,
    consumption = "500GW",
    energy_source = {type = "void"},
    neighbour_bonus = 0,
    heat_buffer = {
      max_temperature = 4000,
      max_transfer = "450kW",
      specific_heat = "8GJ",
      connections = {
        {  -- top left
          direction = defines.direction.north,
          position = {-0.5, -1.5}
        },
        {  -- top right
          direction = defines.direction.north,
          position = {1.5, -1.5}
        },
        {  -- bottom left
          direction = defines.direction.south,
          position = {-0.5, 1.5}
        },
        {  -- bottom right
          direction = defines.direction.south,
          position = {1.5, 1.5}
        },
        {  -- right top
          direction = defines.direction.east,
          position = {2, -1}
        },
        {  -- right bottom
          direction = defines.direction.east,
          position = {2, 1}
        }
      }
    },
    picture = {
      layers = {
        {
          filename = "__factorio-crash-site__/graphics/entity/crash-site-lab/crash-site-lab-broken.png",
          priority = "low",
          width = 236,
          height = 140,
          shift = util.by_pixel(-24, 6),
          hr_version = {
            filename = "__factorio-crash-site__/graphics/entity/crash-site-lab/hr-crash-site-lab-broken.png",
            priority = "low",
            width = 472,
            height = 280,
            shift = util.by_pixel(-24, 6),
            scale = 0.5
          }
        },
        {
          filename = "__factorio-crash-site__/graphics/entity/crash-site-lab/crash-site-lab-broken-shadow.png",
          priority = "low",
          width = 270,
          height = 150,
          shift = util.by_pixel(-16, 10),
          draw_as_shadow = true,
          hr_version = {
            filename = "__factorio-crash-site__/graphics/entity/crash-site-lab/hr-crash-site-lab-broken-shadow.png",
            priority = "low",
            width = 550,
            height = 304,
            shift = util.by_pixel(-14, 9),
            scale = 0.5,
            draw_as_shadow = true
          }
        }
      }
    },
    working_light_picture = {
      filename = "__core__/graphics/empty.png",
      size = 1
    }
  }  --[[@as data.ReactorPrototype]],]=]

  -- pneumatic laboratory
  {
    type = "assembling-machine",
    name = "snowfall-pneumatic-lab",
    icons = { { icon = "__base__/graphics/icons/lab.png", icon_size = 64, icon_mipmaps = 4 } },
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.2, result = "snowfall-pneumatic-lab" },
    max_health = 200,
    collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    crafting_categories = { "snowfall-pneumatic-research" },
    energy_usage = "120kW",
    crafting_speed = 1,
    energy_source = {
      type = "fluid",
      burns_fluid = false,
      scale_fluid_usage = true,
      effectivity = 1,
      emissions_per_minute = { pollution = 12 },
      fluid_box = {
        production_type = "input-output",
        filter = "steam",
        volume = 200,
        pipe_connections = {
          { flow_direction = "input-output", position = { -1, 0 }, direction = defines.direction.west },
          { flow_direction = "input-output", position = { 1, 0 }, direction = defines.direction.east },
        },
        secondary_draw_orders = { north = -1 },
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
      },
      light_flicker = { color = { 0, 0, 0 } },
      smoke = {
        {
          name = "smoke",
          deviation = { 0.1, 0.1 },
          frequency = 3
        }
      }
    },
    animation = table.deepcopy(data.raw["lab"]["lab"].off_animation),
    working_visualisations = {
      {
        animation = table.deepcopy(data.raw["lab"]["lab"].on_animation)
      }  --[[@as data.WorkingVisualisation]]
    },
  }  --[[@as data.AssemblingMachinePrototype]],

  -- kiln
  {
    type = "assembling-machine",
    name = "snowfall-kiln",
    icon = "__base__/graphics/icons/stone-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "placeable-neutral", "placeable-player", "player-creation", "not-rotatable" },
    minable = { mining_time = 0.2, result = "snowfall-kiln" },
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
    collision_box = { { -0.7, -0.7 }, { 0.7, 0.7 } },
    selection_box = { { -0.8, -1 }, { 0.8, 1 } },
    damaged_trigger_effect = data_util.hit_effects.rock(),
    crafting_categories = { "kiln" },
    gui_title_key = "gui-assembling-machine.select-recipe-kiln",
    energy_usage = "90kW",
    crafting_speed = 1,
    energy_source = {
      type = "heat",
      default_temperature = 15,
      minimum_glow_temperature = 250,
      min_working_temperature = 250,
      max_temperature = 350,
      max_transfer = "90kJ",
      specific_heat = "90kJ",
      connections = {
        {
          position = { 0, 0 },
          direction = defines.direction.north
        },
        {
          position = { 0, 0 },
          direction = defines.direction.east
        },
        {
          position = { 0, 0 },
          direction = defines.direction.south
        },
        {
          position = { 0, 0 },
          direction = defines.direction.west
        }
      },
    }  --[[@as data.HeatEnergySource]],
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
  }  --[[@as data.AssemblingMachinePrototype]],

  -- foundry
  --[[{
    type = "assembling-machine",
    name = "snowfall-foundry",
    icon = "__base__/graphics/icons/stone-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.2, result = "snowfall-foundry" },
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
    collision_box = { { -1.29, -0.79 }, { 1.29, 0.79 } },
    selection_box = { { -1.5, -1 }, { 1.5, 1 } },
    damaged_trigger_effect = data_util.hit_effects.rock(),
    crafting_categories = { "smelting" },
    energy_usage = "110kW",
    crafting_speed = 1.2,
    energy_source = {
      type = "heat",
      default_temperature = 15,
      minimum_glow_temperature = 250,
      min_working_temperature = 250,
      max_temperature = 350,
      max_transfer = "110kJ",
      specific_heat = "110kJ",
      connections = {
        {
          position = { 0, -0.5 },
          direction = defines.direction.north
        },
        {
          position = { 0, 0.5 },
          direction = defines.direction.south
        },
      },
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
  }  --[[@as data.AssemblingMachinePrototype]]  --,

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
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.2, result = "snowfall-rolling-machine" },
    max_health = 300,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "assembling-machine-1-explosion",
    resistances = {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = { { -0.75, -0.35 }, { 0.75, 0.35 } },
    selection_box = { { -1, -0.5 }, { 1, 0.5 } },
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
    crafting_categories = { "rolling" },
    crafting_speed = 4,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 4 }
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
  }  --[[@as data.AssemblingMachinePrototype]],

  -- drawing machine
  {
    type = "assembling-machine",
    name = "snowfall-drawing-machine",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.2, result = "snowfall-drawing-machine" },
    max_health = 300,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "assembling-machine-1-explosion",
    resistances = {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = { { -0.8, -0.4 }, { 0.8, 0.4 } },
    selection_box = { { -1, -0.5 }, { 1, 0.5 } },
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
    crafting_categories = { "wire-drawing" },
    crafting_speed = 4,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 4 }
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
  }  --[[@as data.AssemblingMachinePrototype]],

  -- Solid Heat Exchanger
  {
    type = "furnace",
    name = "snowfall-solid-heat-exchanger",
    icon = "__base__/graphics/icons/heat-boiler.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.2, result = "snowfall-solid-heat-exchanger" },
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
    collision_box = { { -1.29, -0.79 }, { 1.29, 0.79 } },
    selection_box = { { -1.5, -1 }, { 1.5, 1 } },
    damaged_trigger_effect = data_util.hit_effects.rock(),
    crafting_categories = { "snowfall-melting" },
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
        volume = 1000,
        pipe_connections = {
          { flow_direction = "output", position = { 0, -0.5 }, direction = defines.direction.north }
        },
        secondary_draw_orders = { north = -1 }
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
          position = { 0, 0.5 },
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
  }  --[[@as data.FurnacePrototype]]
}

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
burner_ice_bore.created_effect = data_util.created_effect("snowfall_placed_ice_bore")


local burner_ice_bore_placer = data_util.generate_placer(burner_ice_bore, "simple-entity-with-owner", {
--  created_effect = data_util.created_effect("snowfall_placed_ice_bore"),
  picture = burner_ice_bore.graphics_set.animation,
  animations = "nil",
  minable = "nil",
  placeable_by = "nil",
  localised_description = { "",
    { "entity-description.snowfall-burner-ice-bore" },
    "\n[font=default-bold][color=#f8e0bb]", { "description.mining-speed" }, ":[/color][/font] " .. tostring(burner_ice_bore.mining_speed), { "per-second-suffix" },
    "\n[font=default-bold][color=#f8e0bb]", { "description.efficiency-penalty-range" }, ":[/color][/font] 16",
    "\n[font=default-bold][color=#f8e0bb]", { "airborne-pollutant-name.pollution" }, ":[/color][/font] " .. tostring(burner_ice_bore.energy_source.emissions_per_minute.pollution), { "per-minute-suffix" },
    { "", -- inner LocalisedString due to 20 parameter limit
      "\n[img=tooltip-category-steam] [font=default-bold][color=#f8cd48]", { "tooltip-category.consumes" }, " ", { "fluid-name.steam" }, "[/color]\n[color=#f8e0bb]",
      { "description.max-energy-consumption" }, ":[/color][/font] " .. tostring(util.parse_energy(burner_ice_bore.energy_usage) * 0.06), " ", { "si-prefix-symbol-kilo" }, { "si-unit-symbol-watt" }
    }
  }
})


local steam_vent_turbine = { -- steam vent turbine (visible, tangeable, generates power)
  type = "generator",
  name = "snowfall-steam-vent-turbine",
  icon = "__base__/graphics/icons/steam-turbine.png",
  flags = { "placeable-neutral", "player-creation", "not-rotatable", "hide-alt-info" },
  minable = { mining_time = 0.3, result = "snowfall-steam-vent-turbine" },
  placeable_by = { item = "snowfall-steam-vent-turbine", count = 1 },
  -- trigger effect here (and on the placer), to allow placing from a ghost
  created_effect = data_util.created_effect("snowfall_placed_steam_vent_turbine"),
  max_health = 300,
  corpse = "pumpjack-remnants",
  dying_explosion = "pumpjack-explosion",
  collision_box = { { -1.25, -1.25 }, { 1.25, 1.25 } },
  selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
  damaged_trigger_effect = data_util.hit_effects.entity(),
  resistances = {
    {
      type = "fire",
      percent = 70
    },
    {
      type = "impact",
      percent = 30
    }
  },
  effectivity = 0.8,            -- 80% efficiency penalty cause these things suck
  fluid_usage_per_tick = 20/60, -- consume 20 fluid/s, slightly more than the lowest yield steam vents
  maximum_temperature = 200,    -- (200-15) * .2kJ * 20fps * 80% = 592kW
  fluid_box = {
    volume = 200,
    hide_connection_info = true,
    pipe_connections = {
      { flow_direction = "input", direction = defines.direction.south, position = {0, -0.5} } -- internal connection to the drill
    },
    production_type = "input",
    filter = "steam",
    minimum_temperature = 200
  },
  energy_source = {
    type = "electric",
    usage_priority = "secondary-output"
  },
  horizontal_animation = {
    filename = data_util.graphics .. "entity/steam-vent-turbine/steam-vent-turbine.png",
    priority = "extra-high",
    width = 192,
    height = 192,
    shift = util.by_pixel(0, 0),
    scale = 0.5
  },
  vertical_animation = {
    filename = data_util.graphics .. "entity/steam-vent-turbine/steam-vent-turbine.png",
    priority = "extra-high",
    width = 192,
    height = 192,
    shift = util.by_pixel(0, 0),
    scale = 0.5
  },
  smoke = {
    {
      name = "light-smoke",
      north_position = {0.9, 0.0},
      east_position = {-2.0, -2.0},
      frequency = 10 / 32,
      starting_vertical_speed = 0.08,
      starting_frame_deviation = 60
    }
  },
  impact_category = "metal-large",
  open_sound = data_util.sounds.machine_open,
  close_sound = data_util.sounds.machine_close,
  working_sound = {
    sound = {
      filename = "__base__/sound/steam-engine-90bpm.ogg",
      volume = 0.55,
      speed_smoothing_window_size = 60,
      modifiers = volume_multiplier("tips-and-tricks", 1.1)
    },
    match_speed_to_activity = true,
    audible_distance_modifier = 0.8,
    max_sounds_per_type = 3,
    fade_in_ticks = 4,
    fade_out_ticks = 20
  },
  perceived_performance = { minimum = 0.25, performance_to_activity_rate = 2.0 },
} --[[@as data.GeneratorPrototype]]

-- we absolutley mustn't have a typo in the tooltip in the (exceedingly unlikely) event someone changes these values
local steam_turbine_power_output = 
  (steam_vent_turbine.maximum_temperature - data.raw.fluid.steam.default_temperature)
  * util.parse_energy(data.raw.fluid.steam.heat_capacity)
  * steam_vent_turbine.fluid_usage_per_tick * 60
  * steam_vent_turbine.effectivity
  / 1000  -- convert to kW

-- turbine placer (visible, temporarily tangeable, placer)
local steam_vent_turbine_placer = data_util.generate_placer(steam_vent_turbine, "mining-drill", {
  base_picture = steam_vent_turbine.horizontal_animation,
  minable = "nil",
  placeable_by = "nil",
  resource_categories = { "geothermal-vent" },
  energy_source = { type = "void" },
  energy_usage = "1W",
  mining_speed = 1,
  resource_searching_radius = 0.49,
  vector_to_place_result = { 0, 0 },
  localised_description = { "",
    { "entity-description.snowfall-steam-vent-turbine" },
    "\n[img=tooltip-category-steam] [font=default-bold][color=#f8cd48]", { "tooltip-category.consumes" }, " ", { "fluid-name.steam" }, "[/color]\n[color=#f8e0bb]",
    { "description.fluid-consumption" }, ":[/color][/font] " .. tostring(steam_vent_turbine.fluid_usage_per_tick * 60), { "per-second-suffix" },
    "\n[img=tooltip-category-electricity] [font=default-bold][color=#f8cd48]", { "tooltip-category.generates" }, " ", { "tooltip-category.electricity" }, "[/color]\n[color=#f8e0bb]",
    { "",
      { "description.maximum-power-output" }, ":[/color][/font] " .. tostring(steam_turbine_power_output) .. " ", { "si-prefix-symbol-kilo" }, { "si-unit-symbol-watt" },
      "\n[font=default-bold][color=#f8e0bb]", { "description.effectivity" }, ":[/color][/font] " .. tostring(steam_vent_turbine.effectivity * 100) .. "%"
    }
  }
})

local spaceship = data.raw.container["crash-site-spaceship"]

data:extend{
  -- burner ice bore
  burner_ice_bore,
  burner_ice_bore_placer,

  -- steam vent cap
  {
    type = "mining-drill",
    name = "snowfall-steam-vent-cap",
    icon = "__base__/graphics/icons/pipe-to-ground.png",
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
    --radius_visualisation_picture = nil
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
    working_sound = data_util.sounds.pipe,

    circuit_wire_connection_points = circuit_connector_definitions["pumpjack"].points,
    circuit_connector_sprites = circuit_connector_definitions["pumpjack"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance
  }  --[[@as data.MiningDrillPrototype]],

  steam_vent_turbine,
  steam_vent_turbine_placer,
  { -- steam vent turbine internal drill (hidden, invisible, mines steam)
    type = "mining-drill",
    name = "snowfall-steam-vent-turbine-internal-drill",
    icons = {
      { icon = "__base__/graphics/icons/steam-turbine.png", tint = { r = 0.7, g = 0.85, b = 1, a = 1 } }
    },
    flags = { "placeable-neutral", "not-rotatable", "hide-alt-info" },
    hidden = true,
    collision_box = { { -1.25, -1.25 }, { 1.25, 1.25 } },
    alert_icon_shift = {0, 1}, -- show the no resources icon underneath the no power icon
    resource_categories = { "geothermal-vent" },
    energy_source = { type = "void" },
    output_fluid_box = {
      volume = 100,
      pipe_connections = {
        { flow_direction = "output", direction = defines.direction.north, position = {0, 0.5} } -- internal connection to the turbine
      }
    },
    energy_usage = "1W",
    mining_speed = 1,
    resource_searching_radius = 0.49,
    vector_to_place_result = { 0, 0 }
  }  --[[@as data.MiningDrillPrototype]],

  -- pneumatic laboratory
  {
    type = "assembling-machine",
    name = "snowfall-pneumatic-lab",
    icon = "__base__/graphics/icons/lab.png",
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
    graphics_set = {
      animation = table.deepcopy(data.raw["lab"]["lab"].off_animation),
      working_visualisations = {
        {
          animation = table.deepcopy(data.raw["lab"]["lab"].on_animation)
        }  --[[@as data.WorkingVisualisation]]
      },
    }
  }  --[[@as data.AssemblingMachinePrototype]],

  { -- pneumatic pulverizer
    type = "furnace",
    name = "snowfall-pneumatic-pulverizer",
    icon = data_util.graphics .. "icons/pneumatic-pulverizer.png",
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.2, result = "snowfall-pneumatic-pulverizer" },
    max_health = 100,
    collision_box = { { -0.8, -0.8 }, { 0.8, 0.8 } },
    selection_box = { { -1, -1 }, { 1, 1 } },
    source_inventory_size = 1,
    result_inventory_size = 3,
    crafting_categories = { "snowfall-pulverizing" },
    crafting_speed = 1,
    cant_insert_at_source_message_key = "inventory-restriction.snowfall-cant-be-pulverized",
    energy_source = {
      type = "fluid",
      burns_fluid = false,
      scale_fluid_usage = true,
      effectivity = 1,
      emissions_per_minute = { pollution = 4 },
      fluid_box = {
        production_type = "input-output",
        filter = "steam",
        volume = 100,
        pipe_connections = {
          { flow_direction = "input-output", position = { -0.5, 0.5 }, direction = defines.direction.west },
          { flow_direction = "input-output", position = { 0.5, 0.5 }, direction = defines.direction.east },
        },
        secondary_draw_orders = { north = -1 },
        pipe_covers = pipecoverspictures(),
      },
      light_flicker = { color = { 0, 0, 0 } },
      smoke = {{
        name = "smoke",
        north_position = { -0.55, 0.3 }, east_position = { -0.55, 0.3 },
        south_position = { -0.55, 0.3 }, west_position = { -0.55, 0.3 },
        deviation = { 0.1, 0.1 },
        frequency = 3
      }}
    } --[[@as data.FluidEnergySource]],
    energy_usage = "140kW",
    working_sound = {
      sound = sound_variations("__base__/sound/burner-mining-drill", 2, 0.6, volume_multiplier("tips-and-tricks", 0.8)),
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    open_sound = data_util.sounds.machine_open,
    close_sound = data_util.sounds.machine_close,

    graphics_set = {
      animation = {
        layers = {
          data_util.load_spritter_sprite(data_util.graphics .. "entity/pulverizer", {}),
          data_util.load_spritter_sprite(data_util.graphics .. "entity/pulverizer-shadow", {draw_as_shadow=true, repeat_count=60})
        }
      }
    }
  } --[[@as data.FurnacePrototype]],

  { -- canister filler
    type = "assembling-machine",
    name = "snowfall-canister-filler",
    icon = data_util.graphics .. "icons/canister-filler.png",
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.2, result = "snowfall-canister-filler" },
    max_health = 50,
    collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    crafting_categories = { "canister" },
    crafting_speed = 1,
    fluid_boxes = {
      {
        production_type = "input",
        filter = "steam",
        volume = 100,
        pipe_connections = {
          { flow_direction = "input", position = { 0, 0 }, direction = defines.direction.north }
        },
        secondary_draw_orders = { north = -1 },
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
      }
    },
    energy_source = {
      type = "void"
    } --[[@as data.VoidEnergySource]],
    energy_usage = "1W",
    working_sound = {
      sound = {
        filename = "__base__/sound/pump.ogg",
        volume = 0.6,
        audible_distance_modifier = 0.4,
        modifiers = {volume_multiplier("tips-and-tricks", 0.8)}
      },
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    open_sound = data_util.sounds.machine_open,
    close_sound = data_util.sounds.machine_close,

    icon_draw_specification = {scale = 0.75},
    graphics_set = {
      animation = {
        layers = {
          {
            filename = data_util.graphics .. "entity/canister-filler/base.png",
            size = {128, 128},
            shift = util.by_pixel(.25 * 64, -0.2 * 64),
            scale = 0.5
          },
          {
            filename = data_util.graphics .. "entity/canister-filler/shadow.png",
            size = {128, 128},
            shift = util.by_pixel(.25 * 64, -0.2 * 64),
            scale = 0.5,
            draw_as_shadow = true
          }
        }
      }
    }
  } --[[@as data.AssemblingMachinePrototype]],
  { -- electrolyzer
    type = "assembling-machine",
    name = "snowfall-electrolyzer",
    icon = data_util.graphics .. "icons/electrolyzer.png",
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.2, result = "snowfall-electrolyzer" },
    max_health = 100,
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    crafting_categories = { "electrolysis" },
    crafting_speed = 1,
    fluid_boxes = {
      {
        production_type = "output",
        filter = "oxygen",
        volume = 100,
        pipe_connections = {
          { flow_direction = "output", position = { -1, 0 }, direction = defines.direction.west }
        },
        secondary_draw_orders = { north = -1 },
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
      },
      {
        production_type = "output",
        filter = "hydrogen",
        volume = 100,
        pipe_connections = {
          { flow_direction = "output", position = { 1, 0 }, direction = defines.direction.east }
        },
        secondary_draw_orders = { north = -1 },
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
      }
    },
    energy_source ={
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 3 }
    },
    energy_usage = "150kW",
    working_sound = {
      sound = {
        filename = "__base__/sound/pump.ogg",
        volume = 0.45,
        audible_distance_modifier = 0.5
      },
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    open_sound = data_util.sounds.machine_open,
    close_sound = data_util.sounds.machine_close,

    graphics_set = {
      animation = {
        layers = {
          data_util.load_spritter_sprite(data_util.graphics .. "entity/electrolyzer/model", {}),
          data_util.load_spritter_sprite(data_util.graphics .. "entity/electrolyzer/shadow", {draw_as_shadow=true, repeat_count=60})
        }
      }
    }
  } --[[@as data.AssemblingMachinePrototype]],

  -- Solid Heat Exchanger
  {
    type = "furnace",
    name = "snowfall-solid-heat-exchanger",
    icon = "__base__/graphics/icons/heat-boiler.png",
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
  }  --[[@as data.FurnacePrototype]],

  -- crashed spaceship parts
  { -- lab
    type = "lab",
    name = "snowfall-spaceship-lab",
    localised_name = {"snowfall.spaceship-title", {"entity-name.snowfall-spaceship-lab"}},
    collision_box = spaceship.collision_box, --{{-1.25, -1.25}, {1.25, 1.25}},
    selection_box = spaceship.selection_box, --{{-1.5, -1.5}, {1.5, 1.5}},
    selection_priority = 60,
    resistances = {{ type = "fire", percent = 100}},
    hidden = true,
    open_sound = data_util.sounds.machine_open,
    close_sound = data_util.sounds.machine_close,
    energy_usage = "1W",
    energy_source = {type = "void"},
    inputs = { "snowfall-material-punchcard", "automation-science-pack" },
    off_animation = table.deepcopy(data.raw["lab"]["lab"].off_animation),
    on_animation = table.deepcopy(data.raw["lab"]["lab"].on_animation)
  } --[[@as data.LabPrototype]],
  { -- arc furnace
    type = "furnace",
    name = "snowfall-spaceship-furnace",
    localised_name = {"snowfall.spaceship-title", {"entity-name.snowfall-spaceship-furnace"}},
    collision_box = spaceship.collision_box, --{{-1.25, -1.25}, {1.25, 1.25}},
    selection_box = spaceship.selection_box, --{{-1.5, -1.5}, {1.5, 1.5}},
    selection_priority = 60,
    resistances = {{ type = "fire", percent = 100}},
    hidden = true,
    flags = {"no-automated-item-removal", "no-automated-item-insertion"},
    show_recipe_icon_on_map = false,
    open_sound = data_util.sounds.machine_open,
    close_sound = data_util.sounds.machine_close,
    icon_draw_specification = {shift={0, -0.5}},
    energy_usage = "1W",
    energy_source = {type = "void"},
    source_inventory_size = 1,
    result_inventory_size = 1,
    crafting_speed = 1.5,
    crafting_categories = { "smelting", "kiln" },
    graphics_set = table.deepcopy(data.raw["furnace"]["electric-furnace"].graphics_set)
  }  --[[@as data.FurnacePrototype]],
  { -- assembling machine for material survey
    type = "assembling-machine",
    name = "snowfall-spaceship-assembling-machine",
    localised_name = {"snowfall.spaceship-title", {"entity-name.snowfall-spaceship-lab"}},
    collision_box = spaceship.collision_box, --{{-1.25, -1.25}, {1.25, 1.25}},
    selection_box = spaceship.selection_box, --{{-1.5, -1.5}, {1.5, 1.5}},
    selection_priority = 60,
    resistances = {{ type = "fire", percent = 100}},
    hidden = true,
    flags = {"no-automated-item-removal", "no-automated-item-insertion", "hide-alt-info"},
    show_recipe_icon_on_map = false,
    open_sound = data_util.sounds.machine_open,
    close_sound = data_util.sounds.machine_close,
    energy_usage = "1W",
    energy_source = {type = "void"},
    crafting_speed = 1,
    crafting_categories = {"snowfall-internal"},
    fixed_recipe = "snowfall-internal-mineral-survey",
    graphics_set = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"].graphics_set)
  }  --[[@as data.AssemblingMachinePrototype]],
}

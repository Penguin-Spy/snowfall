-- changes to vanilla & dependencies' prototypes

local graphics = data_util.graphics

-- offshore pump methane
data.raw["offshore-pump"]["offshore-pump"].fluid = "methane"
data.raw["offshore-pump"]["offshore-pump"].fluid_box.filter = "methane"

-- mining stone produces kaolinite
data.raw["resource"]["stone"].minable.result = nil
data.raw["resource"]["stone"].minable.results = {
  {type = "item", name = "stone",              amount = 1},
  {type = "item", name = "snowfall-kaolinite", amount = 1, probability = 0.5},
}

-- replace coal in rocks with kaolinite
-- should also modify Alien Biomes' rocks
for _, simple_entity in pairs(data.raw["simple-entity"]) do
  if simple_entity.name:gmatch("-?rock%-?") then
    local minable = simple_entity.minable
    -- minable properties
    if minable then
      if minable.results then
        for _, result in pairs(simple_entity.minable.results) do
          if result.name == "coal" then
            result.name = "snowfall-kaolinite"
          end
        end
      elseif minable.result == "coal" then
        minable.result = "snowfall-kaolinite"
      end
    end
    -- loot properties (for killing (driving over) the rock)
    local loot = simple_entity.loot
    if loot then
      for _, entry in pairs(loot) do
        if entry.item == "coal" then
          entry.item = "snowfall-kaolinite"
        end
      end
    end
  end
end

-- burner mining drill powered by methane
data.raw["mining-drill"]["burner-mining-drill"].energy_source = {
  type = "fluid",
  burns_fluid = true,
  scale_fluid_usage = true,
  effectivity = 1,
  emissions_per_minute = 12,
  fluid_box = {
    production_type = "input-output",
    filter = "methane",
    base_area = 1,   -- storage volume of 100 (base_area*height*100)
    height = 1,      -- default
    base_level = 0,  -- default
    pipe_connections = {
      {type = "input-output", position = {-1.5, 0.5}},
      {type = "input-output", position = {1.5, 0.5}},
    },
    secondary_draw_orders = {north = -1},
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
  },
  light_flicker = {color = {0, 0, 0}},
  smoke = {
    {
      name = "smoke",
      deviation = {0.1, 0.1},
      frequency = 3
    }
  }
}

-- same with burner inserter
data.raw["inserter"]["burner-inserter"].energy_source = {
  type = "fluid",
  burns_fluid = true,
  scale_fluid_usage = true,
  effectivity = 1,
  fluid_box = {
    production_type = "input-output",
    filter = "methane",
    base_area = 1,   -- storage volume of 50 (base_area*height*100)
    height = 0.5,    -- default is 1
    base_level = 0,  -- default
    pipe_connections = {
      {type = "input-output", position = {1, 0}},
      {type = "input-output", position = {-1, 0}},
    },
    secondary_draw_orders = {north = -1},
    --pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
  },
  light_flicker = {color = {0, 0, 0}},
}

-- stone furnace powered by methane & converted to an assembler for alloying recipes
local stone_furnace = data.raw["furnace"]["stone-furnace"]
data.raw["furnace"]["stone-furnace"] = nil
stone_furnace.type = "assembling-machine"
stone_furnace.collision_box = {{-1.29, -0.79}, {1.29, 0.79}}
stone_furnace.selection_box = {{-1.5, -1}, {1.5, 1}}
stone_furnace.next_upgrade = nil
stone_furnace.fast_replaceable_group = nil
stone_furnace.energy_source = {
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
}
data:extend{stone_furnace}


-- make wooden chest stone (visually only, leave prototype name alone)
data.raw.item["wooden-chest"].icon = graphics .. "icons/stone-chest.png"
local wooden_chest = data.raw.container["wooden-chest"]
wooden_chest.icon = graphics .. "icons/stone-chest.png"
wooden_chest.vehicle_impact_sound = data_util.sounds.car_stone_impact
wooden_chest.open_sound = data_util.sounds.machine_open
wooden_chest.close_sound = data_util.sounds.machine_close
wooden_chest.picture = {
  layers = {
    {
      filename = graphics .. "entity/stone-chest.png",
      priority = "extra-high",
      width = 32,
      height = 36,
      shift = util.by_pixel(0.5, -2),
      hr_version = {
        filename = graphics .. "entity/hr-stone-chest.png",
        priority = "extra-high",
        width = 62,
        height = 72,
        shift = util.by_pixel(0.5, -2),
        scale = 0.5
      }
    },
    {
      filename = "__base__/graphics/entity/wooden-chest/wooden-chest-shadow.png",
      priority = "extra-high",
      width = 52,
      height = 20,
      shift = util.by_pixel(10, 6.5),
      draw_as_shadow = true,
      hr_version = {
        filename = "__base__/graphics/entity/wooden-chest/hr-wooden-chest-shadow.png",
        priority = "extra-high",
        width = 104,
        height = 40,
        shift = util.by_pixel(10, 6.5),
        draw_as_shadow = true,
        scale = 0.5
      }
    }
  }
}

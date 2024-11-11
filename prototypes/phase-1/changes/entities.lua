-- changes to vanilla & dependencies' prototypes

local graphics = data_util.graphics

-- offshore pump methane
data.raw["offshore-pump"]["offshore-pump"].fluid = "methane"
data.raw["offshore-pump"]["offshore-pump"].fluid_box.filter = "methane"

-- mining stone produces kaolinite
data.raw["resource"]["stone"].minable.result = nil
data.raw["resource"]["stone"].minable.results = {
  { type = "item", name = "stone",              amount = 1 },
  { type = "item", name = "snowfall-kaolinite", amount = 1, probability = 0.5 },
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

-- burner mining drill powered by steam
data.raw["mining-drill"]["burner-mining-drill"].energy_source = {
  type = "fluid",
  burns_fluid = false,
  scale_fluid_usage = true,
  effectivity = 1,
  emissions_per_minute = { pollution = 12 },
  fluid_box = {
    production_type = "input-output",
    filter = "steam",
    volume = 100,
    pipe_connections = {
      { flow_direction = "input-output", position = { -0.5, 0.5 }, direction = defines.direction.west },
      { flow_direction = "input-output", position = { 0.5, 0.5 }, direction = defines.direction.east },
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
}

-- same with burner inserter
data.raw["inserter"]["burner-inserter"].energy_source = {
  type = "fluid",
  burns_fluid = false,
  scale_fluid_usage = true,
  effectivity = 1,
  fluid_box = {
    production_type = "input-output",
    filter = "steam",
    volume = 50,
    pipe_connections = {
      { flow_direction = "input-output", position = { 0, 0 }, direction = defines.direction.west },
      { flow_direction = "input-output", position = { 0, 0 }, direction = defines.direction.east },
    },
    secondary_draw_orders = { north = -1 },
    --pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
  },
  light_flicker = { color = { 0, 0, 0 } },
}

-- stone furnace as an assembler and powered by heat
local stone_furnace = data.raw["furnace"]["stone-furnace"]
--stone_furnace.collision_box = { { -0.79, -0.79 }, { 0.79, 0.79 } }
--stone_furnace.selection_box = { { -1, -1 }, { 1, 1 } }
stone_furnace.next_upgrade = nil
stone_furnace.fast_replaceable_group = nil
table.insert(stone_furnace.flags, "not-rotatable")
stone_furnace.energy_source = {
  type = "heat",
  default_temperature = 15,
  minimum_glow_temperature = 250,
  min_working_temperature = 250,
  max_temperature = 350,
  max_transfer = "720kJ",
  specific_heat = "15kJ",
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
}  --[[@as data.HeatEnergySource]]

-- turn the furnace into an assembling machine
data.raw["furnace"]["stone-furnace"] = nil
stone_furnace.type = "assembling-machine"
---@cast stone_furnace -data.FurnacePrototype,+data.AssemblingMachinePrototype
stone_furnace.gui_title_key = "gui-assembling-machine.select-recipe-smelting"
data:extend{ stone_furnace }

-- make the assembling machine 1 steam powered
local assembler1 = data.raw["assembling-machine"]["assembling-machine-1"]
assembler1.energy_source = {
  type = "fluid",
  burns_fluid = false,
  scale_fluid_usage = true,
  effectivity = 1,
  emissions_per_minute = { pollution = 8 },
  fluid_box = {
    production_type = "input-output",
    filter = "steam",
    volume = 100,
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
      deviation = { 0.2, 0.2 },
      frequency = 2
    }
  }
}  --[[@as data.FluidEnergySource]]


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

-- remove surface biters
data.raw["unit-spawner"]["biter-spawner"].autoplace = nil
data.raw["unit-spawner"]["spitter-spawner"].autoplace = nil
data.raw["turret"]["small-worm-turret"].autoplace = nil
data.raw["turret"]["medium-worm-turret"].autoplace = nil
data.raw["turret"]["big-worm-turret"].autoplace = nil
data.raw["turret"]["behemoth-worm-turret"].autoplace = nil

-- remove iron autoplace (for now)
--TODO: re-add with autoplace that spawns it further away
data_util.remove_autoplace("resource", "iron-ore")

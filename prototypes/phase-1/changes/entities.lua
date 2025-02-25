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

-- burner inserter powered by steam & no filters
data.raw["inserter"]["burner-inserter"].filter_count = 0
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
-- also no filters for the basic electric inserter
data.raw["inserter"]["inserter"].filter_count = 0

-- stone furnace powered by electricity and does kiln recipes
local stone_furnace = data.raw["furnace"]["stone-furnace"]
table.insert(stone_furnace.flags, "not-rotatable")
table.insert(stone_furnace.crafting_categories, "kiln")
-- energy usage is still 90kW
stone_furnace.energy_source = {
  type = "electric",
  usage_priority = "secondary-input",
  emissions_per_minute = { pollution = 2 }  -- same as base
} --[[@as data.ElectricEnergySource]]
stone_furnace.result_inventory_size = 2 -- make space for slag

-- steel furnace powered by electricity, is assembler, does alloying recipes
local steel_furnace = data.raw.furnace["steel-furnace"]
steel_furnace.type = "assembling-machine"
steel_furnace.crafting_categories = { "alloying" }
steel_furnace.energy_source = {
  type = "electric",
  usage_priority = "secondary-input",
  emissions_per_minute = { pollution = 2 }  -- same as base
} --[[@as data.ElectricEnergySource]]

data.raw.furnace["steel-furnace"] = nil
data:extend{steel_furnace}

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

-- make car & mini train powered by steam
data.raw.car["car"].energy_source.burnt_inventory_size = 1
data.raw.car["car"].energy_source.fuel_categories = {"steam"}
data.raw.locomotive["mini-locomotive"].energy_source.burnt_inventory_size = 1
data.raw.locomotive["mini-locomotive"].energy_source.fuel_categories = {"steam"}

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
      width = 62,
      height = 72,
      shift = util.by_pixel(0.5, -2),
      scale = 0.5
    },
    {
      filename = "__base__/graphics/entity/wooden-chest/wooden-chest-shadow.png",
      priority = "extra-high",
      width = 52,
      height = 20,
      shift = util.by_pixel(10, 6.5),
      draw_as_shadow = true,
      scale = 0.5
    }
  }
}

-- remove storage space of the spaceship so that items can't get lost there (we make it probably impossible to open)
data.raw.container["crash-site-spaceship"].inventory_size = 0
data.raw.container["crash-site-spaceship"].flags = {"no-automated-item-removal", "no-automated-item-insertion"}

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

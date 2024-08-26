--[[ data.lua © Penguin_Spy 2023
  Snowfall's prototype definitions and modifications to vanilla/dependencies' prototypes
]]

-- define our data_util as a global for this stage, without accidentally clobbering another mods' table (if it exists, which it shouldn't, but hey)
local orig_data_util = data_util  ---@diagnostic disable-line: undefined-global
data_util = require "prototypes.data_util"  ---@diagnostic disable-line: lowercase-global

-- sorted alphabetically, directories first to match VS Code's file explorer
-- (order of running these files *shouldn't* matter)

require "prototypes.phase-1.changes.entities"
require "prototypes.phase-1.changes.items"
require "prototypes.phase-1.changes.recipes"
require "prototypes.phase-1.changes.removals"

require "prototypes.phase-1.recipe.crafting"
require "prototypes.phase-1.recipe.kiln"
require "prototypes.phase-1.recipe.melting"
require "prototypes.phase-1.recipe.research"
require "prototypes.phase-1.recipe.rolling-drawing"
require "prototypes.phase-1.recipe.smelting"

--require "prototypes.phase-1.casting" -- this system needs reworking
require "prototypes.phase-1.entities"
require "prototypes.phase-1.fluids"
require "prototypes.phase-1.item-groups"
require "prototypes.phase-1.items"
require "prototypes.phase-1.resources"
require "prototypes.phase-1.technology"
require "prototypes.phase-1.tiles"

data_util = orig_data_util  ---@diagnostic disable-line: lowercase-global

log(serpent.block(data.raw["resource"]["iron-ore"]))

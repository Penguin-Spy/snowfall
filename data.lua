--[[ data.lua © Penguin_Spy 2023
  Snowfall's prototype definitions and modifications to vanilla/dependencies' prototypes
]]

-- define our data_util as a global for this stage, without accidentally clobbering another mods' table (if it exists, which it shouldn't, but hey)
local orig_data_util = data_util  ---@diagnostic disable-line: undefined-global
data_util = require "prototypes.data_util"  ---@diagnostic disable-line: lowercase-global

-- order doesn't matter unless stated otherwise

require "prototypes.phase-1.changes.entities"
require "prototypes.phase-1.changes.items"
require "prototypes.phase-1.changes.misc"
require "prototypes.phase-1.changes.recipes"
require "prototypes.phase-1.changes.removals"
require "prototypes.phase-1.changes.technology"

require "prototypes.phase-1.recipe.crafting"
require "prototypes.phase-1.recipe.kiln"
require "prototypes.phase-1.recipe.melting"
require "prototypes.phase-1.recipe.research"
require "prototypes.phase-1.recipe.smelting"

require "prototypes.phase-1.entities" -- must happen after changes.entities (TODO: remove deepcopy of burner drills)
require "prototypes.phase-1.fluids"
require "prototypes.phase-1.item-groups"
require "prototypes.phase-1.items"
require "prototypes.phase-1.noise-programs"
require "prototypes.phase-1.style"
require "prototypes.phase-1.resources"
require "prototypes.phase-1.technology"
require "prototypes.phase-1.tiles"

require "prototypes.phase-1.recipe.pulverizing" -- must happen after items

data_util = orig_data_util  ---@diagnostic disable-line: lowercase-global

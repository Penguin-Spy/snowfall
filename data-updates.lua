--[[ data-updates.lua © Penguin_Spy 2023
  Modifications to vanilla/dependencies' prototypes that must happen after their data-updates.lua
]]

-- define our data_util as a global for this stage, without accidentally clobbering another mods' table (if it exists, which it shouldn't, but hey)
local orig_data_util = data_util  ---@diagnostic disable-line: undefined-global
data_util = require "prototypes.data_util"  ---@diagnostic disable-line: lowercase-global

require "prototypes.phase-2.changes"
require "prototypes.phase-2.item-regroup"

data_util = orig_data_util  ---@diagnostic disable-line: lowercase-global

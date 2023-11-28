local resource_autoplace = require("resource-autoplace")

resource_autoplace.initialize_patch_set("ice", true)

-- Ice resource
local ice_resource = table.deepcopy(data.raw.resource["iron-ore"])
ice_resource.name = "ice"
ice_resource.minable.result = "ice";
ice_resource.autoplace = resource_autoplace.resource_autoplace_settings{
  name = "ice",
  order = "b",
  base_density = 4,
  has_starting_area_placement = true,
  regular_rq_factor_multiplier = 1.0,
  starting_rq_factor_multiplier = 1.1
}
data:extend{ice_resource,
  {
    type = "autoplace-control",
    name = "ice",
    localised_name = {"", "[entity=ice] ", {"entity-name.ice"}},
    richness = true,
    order = "b-c-a",  -- after stone
    category = "resource"
  }
}

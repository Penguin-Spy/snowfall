local collision_mask_util_extended = require("__alien-biomes__/collision-mask-util-extended/data/collision-mask-util-extended")
local collision_mask_ice_tile = collision_mask_util_extended.get_make_named_collision_mask("not-ice-tile")

-- add the "not-ice-tile" collision layer any tile that's not alien biomes' ice tiles (frozen snow 5-9)
for name, tile in pairs(data.raw.tile) do
  if not name:match("^frozen%-snow%-[5-9]$") then
    table.insert(tile.collision_mask, collision_mask_ice_tile)
  end
end

-- create "not_ice_tile" collision layer
data:extend{
  {
    type = "collision-layer",
    name = "not_ice_tile"
  }
}

-- add the "not_ice_tile" collision layer any tile that's not alien biomes' ice tiles (frozen snow 5-9)
for name, tile in pairs(data.raw.tile) do
  if not name:match("^frozen%-snow%-[5-9]$") then
    tile.collision_mask.layers.not_ice_tile = true
  end
end

-- Item group & subgroup definitions

data:extend{
  ----------------------------------- Intermediate products
  -- raw-resource (b)
  {
    type = "item-subgroup",
    name = "processed-stone",
    group = "intermediate-products",
    order = "ba"
  },
  {
    type = "item-subgroup",
    name = "ingots",
    group = "intermediate-products",
    order = "bb"
  },
  -- raw-material             (c)  -- plates
  -- intermediate-product     (d)
  -- engine-components        (e)
  -- cable                    (f-z)
  -- generic-circuits         (f-zb)
  -- specialized-electronics  (f-zc)
  -- science-pack             (y)

  ----------------------------------- Chemistry
  {
    type = "item-group",
    name = "chemistry",
    order = "ca",
    order_in_recipe = "0",
    icon = data_util.graphics .. "icons/chemistry-item-group.png",
    icon_size = 128
  },
  -- fluid-recipes      (a)
  -- advanced-chemicals (ab)
  -- helium             (a-ab)
  {
    type = "item-subgroup",
    name = "chemical-products",
    group = "chemistry",
    order = "c"
  },
  -- uranium-processing (ca)
  -- barrel             (d)
  -- fill-barrel        (e)
  -- empty-barrel       (f)
}

data.raw["item-subgroup"]["intermediate-product"].order = "d"  -- vanilla, default is "g"
--data.raw["item-subgroup"]["engine-components"].order = "e"     -- from IfIHadANickel, default is "fx"

data.raw["item-subgroup"]["fluid"].group = "chemistry" -- default is the "Fluids" group
data.raw["item-subgroup"]["fluid-recipes"].group = "chemistry"
--?data.raw["item-subgroup"]["advanced-chemicals"].group = "chemistry"  -- from ThemTharHills
--?data.raw["item-subgroup"]["helium"].group = "chemistry"
data.raw["item-subgroup"]["uranium-processing"].group = "chemistry" -- vanilla, default is the intermediate products group, order "i"
data.raw["item-subgroup"]["uranium-processing"].order = "ca"
data.raw["item-subgroup"]["barrel"].group = "chemistry"
data.raw["item-subgroup"]["fill-barrel"].group = "chemistry"
data.raw["item-subgroup"]["empty-barrel"].group = "chemistry"


------------------------------------- Environment
data:extend{
  {
    type = "item-subgroup",
    name = "planet",
    group = "environment",
    order = "a-a"
  }
}
data.raw["item-subgroup"]["creatures"].order = "a-b"  -- vanilla, default is "a"
-- trees            (aa)
-- grass            (b)                               -- rocks
data.raw["item-subgroup"]["cliffs"].order = "ba"      -- vanilla, default is "a"
-- mineable-fluids  (ba)
-- remnants         (dz)    -- tree stumps (hidden)
-- wrecks           (e)     -- was some alien biomes rocks

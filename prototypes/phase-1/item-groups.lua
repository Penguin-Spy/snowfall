-- Item group & subgroup definitions

data:extend{
  -- [[ Intermediate products group ]]
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
  -- science-pack             (h)

  -- [[ Chemistry group ]]
  {
    type = "item-group",
    name = "chemistry",
    order = "ca",
    order_in_recipe = "0",
    icon = data_util.graphics "icons/chemistry-item-group.png",
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
  {
    type = "item-subgroup",
    name = "nuclear-products",
    group = "chemistry",
    order = "ca"
  },
  -- barrel       (d)
  -- fill-barrel  (e)
  -- empty-barrel (f)
}

data.raw["item-subgroup"]["intermediate-product"].order = "d"  -- vanilla, default is "g"
--data.raw["item-subgroup"]["engine-components"].order = "e"     -- from IfIHadANickel, default is "fx"

data.raw["item-subgroup"]["fluid-recipes"].group = "chemistry"
data.raw["item-subgroup"]["advanced-chemicals"].group = "chemistry"  -- from ThemTharHills
data.raw["item-subgroup"]["helium"].group = "chemistry"
data.raw["item-subgroup"]["barrel"].group = "chemistry"
data.raw["item-subgroup"]["fill-barrel"].group = "chemistry"
data.raw["item-subgroup"]["empty-barrel"].group = "chemistry"

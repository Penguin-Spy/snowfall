-- Regrouping and reordering items

local function set_subgroup(subgroup, items)
  for _, item in pairs(items) do
    if data.raw.item[item] then
      data.raw.item[item].subgroup = subgroup
    elseif data.raw.recipe[item] and data.raw.recipe[item].subgroup then
      data.raw.recipe[item].subgroup = subgroup
    else
      error("[snowfall.item-regroup] item or recipe not found: " .. tostring(item) .. " (for subgroup: " .. tostring(subgroup) .. ")")
    end
  end
end

set_subgroup("processed-stone", {
  "stone-brick", --?"silica", "silicon"
})

--[[set_subgroup("advanced-chemicals", {  --?
  "gold-powder"
})]]

set_subgroup("chemical-products", {
  --?"phenol",
  --?"bakelite",
  "plastic-bar",
  "sulfur",
  "battery",  -- ThemTharHills moves this again in data-final-fixes. will need to rework batteries later anyways
  "explosives",
  "solid-fuel",
  "rocket-fuel"
})

set_subgroup("nuclear-products", {
  "uranium-235",
  "uranium-238",
  "uranium-fuel-cell",
  "depleted-uranium-fuel-cell",
  "nuclear-fuel",
  "kovarex-enrichment-process",
  "uranium-processing",
  "nuclear-fuel-reprocessing"
})

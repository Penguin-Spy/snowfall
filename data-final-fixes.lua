--[[ data-final-fixes.lua © Penguin_Spy 2023
  Modifications to vanilla/dependencies' prototypes that must happen last (after their data-final-fixes.lua)
]]

--[[
for _, character in pairs(data.raw.character) do
  -- allow player to do these, but slowly
  table.insert(character.crafting_categories, "rolling")
  table.insert(character.crafting_categories, "wire-drawing")
end
]]

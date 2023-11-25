for _, character in pairs(data.raw.character) do
  -- allow player to do these, but slowly
  table.insert(character.crafting_categories, "rolling")
  table.insert(character.crafting_categories, "wire-drawing")
end

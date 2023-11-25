script.on_init(function(event)
  if remote.interfaces["freeplay"] then
    remote.call("freeplay", "set_created_items", {
      ["pistol"] = 1,
      ["firearm-magazine"] = 10
    })
    remote.call("freeplay", "set_ship_items", {
      ["offshore-pump"] = 2,
      ["burner-mining-drill"] = 10,
      ["snowfall-kiln"] = 1,
      ["firearm-magazine"] = 20
    })
    remote.call("freeplay", "set_debris_items", {
      ["lead-plate"] = 10,
      ["brass-plate"] = 6,
      ["iron-gear-wheel"] = 2
    })
  end
end)

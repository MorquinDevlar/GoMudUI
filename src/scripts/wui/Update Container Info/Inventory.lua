function wui.updateInvDisplay()
  if gmcp.Char == nil then return end
  if gmcp.Char.Inventory == nil then return end
  if gmcp.Char.Inventory.Backpack == nil then return end
  if gmcp.Char.Inventory.Backpack.items == nil then return end

  wui.eqDisplay:clear("Inventory")

  wui.eqDisplay:cecho("Inventory","<cyan>R/C to look, drop or wear")
  wui.eqDisplay:cecho("Inventory","\n\n")

  local backpackItems = gmcp.Char.Inventory.Backpack.items

  if #backpackItems > 0 then
    for index, item in ipairs(backpackItems) do
      wui.eqDisplay:cechoPopup("Inventory",
        --"<sandy_brown>  " .. item.name .. " <reset>[" .. item.id .. "]\n",
        "<sandy_brown>  " .. item.name .. "\n",
        {
          [[send("look ]] .. item.id .. [[", false)]],
          [[send("drop ]] .. item.id .. [[", false)]],
          [[send("wear ]] .. item.id .. [[", false)]],
        },
        {
          "Look at " .. item.name,
          "Drop " .. item.name,
          "Wear " .. item.name
        },
        true
      )
    end
  else
    wui.eqDisplay:cecho("Inventory", "\n  <sandy_brown>You are not carrying anything.")
  end
end
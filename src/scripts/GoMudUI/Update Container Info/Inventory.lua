function ui.updateInvDisplay()
  if gmcp.Char == nil then return end
  if gmcp.Char.Inventory == nil then return end
  if gmcp.Char.Inventory.Backpack == nil then return end
  if gmcp.Char.Inventory.Backpack.items == nil then return end

  ui.eqDisplay:clear("Inventory")

  ui.eqDisplay:cecho("Inventory","<cyan>R/C to look, drop or wear")
  ui.eqDisplay:cecho("Inventory","\n\n")

  local backpackItems = gmcp.Char.Inventory.Backpack.items

  if #backpackItems > 0 then
    for _, itemName in ipairs(backpackItems) do
      ui.eqDisplay:cechoPopup("Inventory",
        "<sandy_brown>  " .. ui.titleCase(itemName) .. "\n",
        {
          [[send("look ]] .. itemName .. [[", false)]],
          [[send("drop ]] .. itemName .. [[", false)]],
          [[send("wear ]] .. itemName .. [[", false)]],
        },
        {
          "Look at " .. ui.titleCase(itemName),
          "Drop " .. ui.titleCase(itemName),
          "Wear " .. ui.titleCase(itemName)
        },
        true
      )
    end
  else
    ui.eqDisplay:cecho("Inventory", "\n  <sandy_brown>You are not carrying anything.")
  end
end
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
    for _, item in ipairs(backpackItems) do
      ui.eqDisplay:cechoPopup("Inventory",
        "<sandy_brown>  " .. ui.titleCase(item.name) .. "\n",
        {
          [[send("look ]] .. item.id .. [[", false)]],
          [[send("drop ]] .. item.id .. [[", false)]],
          [[send("wear ]] .. item.id .. [[", false)]],
        },
        {
          "Look at " .. ui.titleCase(item.name),
          "Drop " .. ui.titleCase(item.name),
          "Wear " .. ui.titleCase(item.name)
        },
        true
      )
    end
  else
    ui.eqDisplay:cecho("Inventory", "\n  <sandy_brown>You are not carrying anything.")
  end
end
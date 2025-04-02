function ui.updatePetDisplay()
  -- Ensure GMCP data is valid
  if not gmcp.Char or not gmcp.Char.Inventory or not gmcp.Char.Inventory.Pets then
    ui.eqDisplay:clear("Pets")
    ui.eqDisplay:cecho("Pets", "\nPets are not implemented yet here.")
    return
  end

  ui.eqDisplay:clear("Pets")

  ui.eqDisplay:cecho("Pets", "<green>" .. string.format("%-15s", "Companions"))
  ui.eqDisplay:cecho("Pets", "<cyan>Right-click to look or remove\n")

  -- Display Leading
  ui.eqDisplay:cecho("Pets", "\n<sandy_brown>" .. string.format("%-15s", "Leading"))
  local leading_item = gmcp.Char.Inventory.Pets.leading
  if leading_item == "" then
    ui.eqDisplay:cecho("Pets", "<red>---")
  else
    local itemName = (type(leading_item) == "table" and leading_item.name) or "Unknown Companion"
    local itemId   = (type(leading_item) == "table" and leading_item.id) or "?"
    ui.eqDisplay:cechoPopup("Pets",
      "<reset>" .. itemName .. " <gray>[" .. itemId .. "]",
      {
        [[send("look ]] .. itemId .. [[", false)]],
        [[send("remove ]] .. itemId .. [[", false)]],
      },
      {
        "Look at " .. itemName,
        "Remove " .. itemName,
      },
      true
    )
  end

  -- Display Mount
  ui.eqDisplay:cecho("Pets", "\n<sandy_brown>" .. string.format("%-15s", "Mount"))
  local mount_item = gmcp.Char.Inventory.Pets.mount
  if mount_item == "" then
    ui.eqDisplay:cecho("Pets", "<red>---")
  else
    local itemName = (type(mount_item) == "table" and mount_item.name) or "Unknown Companion"
    local itemId   = (type(mount_item) == "table" and mount_item.id) or "?"
    ui.eqDisplay:cechoPopup("Pets",
      "<reset>" .. itemName .. " <gray>[" .. itemId .. "]",
      {
        [[send("look ]] .. itemId .. [[", false)]],
        [[send("remove ]] .. itemId .. [[", false)]],
      },
      {
        "Look at " .. itemName,
        "Remove " .. itemName,
      },
      true
    )
  end

  -- Display Pets (list of multiple pets)
  ui.eqDisplay:cecho("Pets", "\n<sandy_brown>" .. string.format("%-15s", "Pets"))
  local pets_list = gmcp.Char.Inventory.Pets.pets
  if not pets_list or #pets_list == 0 then
    ui.eqDisplay:cecho("Pets", "<red>---")
  else
    for _, pet_item in ipairs(pets_list) do
      ui.eqDisplay:cecho("Pets", "\n") -- separate lines for each pet
      local itemName = pet_item.name or "Unknown Pet"
      local itemId   = pet_item.id or "?"
      ui.eqDisplay:cechoPopup("Pets",
        "<reset>" .. itemName .. " <gray>[" .. itemId .. "]",
        {
          [[send("look ]] .. itemId .. [[", false)]],
          [[send("remove ]] .. itemId .. [[", false)]],
        },
        {
          "Look at " .. itemName,
          "Remove " .. itemName,
        },
        true
      )
    end
  end
end
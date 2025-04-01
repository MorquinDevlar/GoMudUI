function wui.updateEQDisplay()
  if not gmcp.Char or not gmcp.Char.Inventory then return end

  -- Define the order and names of equipment slots (without leading and mount)
  wui.eqLocations = {
    "main hand",
    "off hand",
    "two hands",
    "head",
    "neck",
    "body",
    "arms",
    "belt",
    "legs",
    "feet",
    "back",
    "hands",
    "right finger",
    "left finger",
    "quiver",
  }

  wui.eqDisplay:clear("Equipment")

  wui.eqDisplay:cecho("Equipment", "<green>" .. string.format("%-11s", "Location"))
  wui.eqDisplay:cecho("Equipment", "<cyan>R/C to look or remove\n")

  for _, slot in ipairs(wui.eqLocations) do
    local displaySlot = slot
    -- Map "right finger" and "left finger" to "rfinger" and "lfinger"
    if slot == "right finger" then
      displaySlot = "rfinger"
    elseif slot == "left finger" then
      displaySlot = "lfinger"
    end

    local item = nil
    -- Check Wielded first
    if gmcp.Char.Inventory.Wielded and gmcp.Char.Inventory.Wielded[slot] and gmcp.Char.Inventory.Wielded[slot] ~= "" then
      item = gmcp.Char.Inventory.Wielded[slot]
    elseif gmcp.Char.Inventory.Worn and gmcp.Char.Inventory.Worn[slot] and gmcp.Char.Inventory.Worn[slot] ~= "" then
      -- Check Worn if not wielded
      item = gmcp.Char.Inventory.Worn[slot]
    end

    -- If this slot is a weapon slot and no item is found, skip displaying it entirely
    if (slot == "main hand" or slot == "off hand" or slot == "two hands") and not item then
      -- Skip printing this slot
    else
      -- Display the slot name
      wui.eqDisplay:cecho("Equipment", "\n<snow>" .. string.format("%-11s", displaySlot))

      if not item then
        wui.eqDisplay:cecho("Equipment", "<red>---")
      else
        local itemName = (type(item) == "table" and item.name) or "Unknown Item"
        local itemId   = (type(item) == "table" and item.id) or "?"
        wui.eqDisplay:cechoPopup("Equipment",
          --"<reset>" .. itemName .. " <gray>[" .. itemId .. "]",
          "<sandy_brown>" .. itemName,
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
end
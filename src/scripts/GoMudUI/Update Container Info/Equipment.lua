function ui.updateEQDisplay()
  if not gmcp.Char or not gmcp.Char.Inventory then return end

  ui.eqDisplay:clear("Equipment")

  ui.eqDisplay:cecho("Equipment", "<green>" .. string.format("%-11s", "Location"))
  ui.eqDisplay:cecho("Equipment", "<cyan>R/C to look or remove\n")

  -- Get all locations from Worn inventory
  local locations = {}
  if gmcp.Char.Inventory.Worn then
    for location, _ in pairs(gmcp.Char.Inventory.Worn) do
      table.insert(locations, location)
    end
  end

  -- Sort locations alphabetically
  table.sort(locations)

  for _, slot in ipairs(locations) do
    local item = nil
    -- Check Wielded first
    if gmcp.Char.Inventory.Wielded and gmcp.Char.Inventory.Wielded[slot] and gmcp.Char.Inventory.Wielded[slot] ~= "" then
      item = gmcp.Char.Inventory.Wielded[slot]
    elseif gmcp.Char.Inventory.Worn and gmcp.Char.Inventory.Worn[slot] and gmcp.Char.Inventory.Worn[slot] ~= "" then
      -- Check Worn if not wielded
      item = gmcp.Char.Inventory.Worn[slot]
    end

    -- Skip empty slots
    if item == "-nothing-" then
      item = nil
    end

    -- Display the slot name
    ui.eqDisplay:cecho("Equipment", "\n<snow>" .. string.format("%-11s", ui.titleCase(slot)))

    if not item then
      ui.eqDisplay:cecho("Equipment", "<red>---")
    else
      local itemName = (type(item) == "table" and item.name) or item
      ui.eqDisplay:cechoPopup("Equipment",
        "<sandy_brown>" .. ui.titleCase(itemName),
        {
          [[send("look ]] .. itemName .. [[", false)]],
          [[send("remove ]] .. itemName .. [[", false)]],
        },
        {
          "Look at " .. ui.titleCase(itemName),
          "Remove " .. ui.titleCase(itemName),
        },
        true
      )
    end
  end
end
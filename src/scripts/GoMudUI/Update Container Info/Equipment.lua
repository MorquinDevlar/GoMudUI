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
    if gmcp.Char.Inventory.Wielded and gmcp.Char.Inventory.Wielded[slot] and gmcp.Char.Inventory.Wielded[slot].name ~= "-nothing-" then
      item = gmcp.Char.Inventory.Wielded[slot]
    elseif gmcp.Char.Inventory.Worn and gmcp.Char.Inventory.Worn[slot] and gmcp.Char.Inventory.Worn[slot].name ~= "-nothing-" then
      -- Check Worn if not wielded
      item = gmcp.Char.Inventory.Worn[slot]
    end

    -- Display the slot name
    ui.eqDisplay:cecho("Equipment", "\n<snow>" .. string.format("%-11s", ui.titleCase(slot)))

    if not item then
      ui.eqDisplay:cecho("Equipment", "<red>---")
    else
      ui.eqDisplay:cechoPopup("Equipment",
        "<sandy_brown>" .. ui.titleCase(item.name),
        {
          [[send("look ]] .. item.id .. [[", false)]],
          [[send("remove ]] .. item.id .. [[", false)]],
        },
        {
          "Look at " .. ui.titleCase(item.name),
          "Remove " .. ui.titleCase(item.name),
        },
        true
      )
    end
  end
end
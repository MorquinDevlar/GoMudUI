function wui.updatePromptDisplay()
  local char = gmcp.Char
  if not char then return end

  -- Cache values with sensible defaults.
  local xp, xptnl = 100, 1000
  local energy, energyMax = 100, 100
  local xpPct, xpPctPretty = 0, 0
  local gold, bank = 0, 0
  local carry, capacity = 0, 0
  local spell, charge = "", ""

  local charVitals = char.Vitals
  if charVitals then
    xp    = charVitals.xp or 0
    xptnl = charVitals.xptnl or 0
    xpPct = (xp / xptnl) * 100
    xpPctPretty = math.floor(xpPct + 0.5)
    energy = charVitals.energy
    energyMax = charVitals.maxenergy
  else
    xpPct = (xp / xptnl) * 100
    xpPctPretty = math.floor(xpPct + 0.5)
  end
  
  local charWorth = char.Worth
  if charWorth then
    gold  = charWorth.gold_carry or 0
    bank  = charWorth.gold_bank or 0
  end

  local charInventory = char.Inventory
  if charInventory and charInventory.Backpack then
    carry    = charInventory.Backpack.count or 0
    capacity = charInventory.Backpack.max or 0
  end

  local charStatuses = char.Statuses
  if charStatuses then
    spell  = charStatuses.cast or ""
    charge = charStatuses.charge or ""
  end

  local promptWidth = wui.mainWindowWidth / wui.consoleFontWidth
  local disp = wui.promptDisplay  -- cache the display reference

  disp:clear()
  disp:cecho(" <grey>-- <violet>Spell prepared<white>: <DarkSeaGreen>[ ")
  disp:cechoLink("<u><violet>" .. spell .. "</u>", [[send("t")]], "Use spell", true)
  disp:cecho("<DarkSeaGreen> ] <grey>")

  if charge ~= "" then
    disp:cecho("<SkyBlue>Charge<white>: <DarkSeaGreen>[ <green>" .. charge)
    disp:cecho("<DarkSeaGreen> ] <grey>")
  end

  local repCount = promptWidth - string.len(spell) - 24
  disp:cecho(string.rep("-", repCount))
  disp:cecho("\n")
  
  disp:cecho(" <DarkSeaGreen>[<white>EN<gold>:<green> " ..
    wui.addNumberSeperator(energy) ..
    "<grey>/<grey>" ..
    wui.addNumberSeperator(energyMax) ..
    "<DarkSeaGreen>] <grey>-")
  
  disp:cecho(" <DarkSeaGreen>[<white>XP<gold>:<green> " ..
    wui.addNumberSeperator(xp) ..
    "<grey>/<grey>" ..
    wui.addNumberSeperator(xptnl) ..
    " <gold>" .. xpPctPretty .. "<white>%<grey> TNL<DarkSeaGreen>] <grey>-")
  
  disp:cecho(" <DarkSeaGreen>[<white>Gold<gold>:<gold> " ..
    wui.addNumberSeperator(gold) ..
    " <white>Bank<gold>:<gold> " ..
    wui.addNumberSeperator(bank) ..
    "<DarkSeaGreen>] <grey>-")
  
  disp:cecho(" <DarkSeaGreen>[<DarkTurquoise>Carry<white>: <grey>" ..
    carry .. "<white>/<grey>" .. capacity ..
    "<DarkSeaGreen>]")
end
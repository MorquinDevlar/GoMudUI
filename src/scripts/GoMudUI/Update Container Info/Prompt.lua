function ui.updatePromptDisplay()
  if gmcp.Char == nil or gmcp.Char.Vitals == nil or gmcp.Char.Worth == nil or gmcp.Char.Inventory == nil then
    return
  end
  
  -- Cache values with sensible defaults.
  local xp, xptnl = 100, 1000
  local energy, energyMax = 100, 100
  local xpPct, xpPctPretty = 0, 0
  local gold, bank = 0, 0
  local carry, capacity = 0, 0
  --local spell, charge = "", ""

  if gmcp.Char.Worth then
    xp    = gmcp.Char.Worth.xp or 0
    xptnl = gmcp.Char.Worth.tnl or 0
    xpPct = (xp / xptnl) * 100
    xpPctPretty = math.floor(xpPct + 0.5)
    gold  = gmcp.Char.Worth.gold_carry or 0
    bank  = gmcp.Char.Worth.gold_bank or 0
    xpPct = (xp / xptnl) * 100
    xpPctPretty = math.floor(xpPct + 0.5)
  end
  
  if gmcp.Char.Inventory and gmcp.Char.Inventory.Backpack then
    carry    = gmcp.Char.Inventory.Backpack.count or 0
    capacity = gmcp.Char.Inventory.Backpack.max or 0
  end

  local promptWidth = ui.mainWindowWidth / ui.consoleFontWidth
  local disp = ui.promptDisplay  -- cache the display reference

  disp:clear()
  --disp:cecho(" <grey>-- <violet>Spell prepared<white>: <DarkSeaGreen>[ ")
  --disp:cechoLink("<u><violet>" .. spell .. "</u>", [[send("t")]], "Use spell", true)
  --disp:cecho("<DarkSeaGreen> ] <grey>")

  --if charge ~= "" then
  --  disp:cecho("<SkyBlue>Charge<white>: <DarkSeaGreen>[ <green>" .. charge)
  --  disp:cecho("<DarkSeaGreen> ] <grey>")
  --end
  

  --local repCount = promptWidth - string.len(spell) - 24
  local repCount = promptWidth
  disp:cecho(string.rep("-", repCount))
  disp:cecho("\n")
  
  disp:cecho(" <DarkSeaGreen>[<white>EN<gold>:<green> " ..
    ui.addNumberSeperator(energy) ..
    "<grey>/<grey>" ..
    ui.addNumberSeperator(energyMax) ..
    "<DarkSeaGreen>] <grey>-")
  
  disp:cecho(" <DarkSeaGreen>[<white>XP<gold>:<green> " ..
    ui.addNumberSeperator(xp) ..
    "<grey>/<grey>" ..
    ui.addNumberSeperator(xptnl) ..
    " <gold>" .. xpPctPretty .. "<white>%<grey> TNL<DarkSeaGreen>] <grey>-")
  
  disp:cecho(" <DarkSeaGreen>[<white>Gold<gold>:<gold> " ..
    ui.addNumberSeperator(gold) ..
    " <white>Bank<gold>:<gold> " ..
    ui.addNumberSeperator(bank) ..
    "<DarkSeaGreen>] <grey>-")
  
  disp:cecho(" <DarkSeaGreen>[<DarkTurquoise>Carry<white>: <grey>" ..
    carry .. "<white>/<grey>" .. capacity ..
    "<DarkSeaGreen>]")
end
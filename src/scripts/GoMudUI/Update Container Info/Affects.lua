function ui.showTempAffects(name, duration, isBuff)
    local name = name
    local duration = duration
    local isBuff = isBuff
    
    local h, m, s = shms(duration)
    if tonumber(h) > 0 then
      h = h.."<DodgerBlue>h<white> "
      s = ""
    else
      h = ""
      s = " "..s.."<gold>s"
    end
    
    if tonumber(m) > 0 then m = m.."<SkyBlue>m<white>" else m = "" end
    local time = h..m..s
    local timeLen = time:gsub("<%w+:?%w*>", "")
    local color = ""
    
    if isBuff then
      color = "<SpringGreen>"
    else
      color = "<red>"
    end
    
    local affect = color..name..string.rep(" ", 28-string.len(name))..string.rep(" ", math.ceil(ui.affectsDisplay:get_width()/ui.consoleFontWidth)-20-string.len(name)-(4-string.len(name))-string.len(timeLen)-6).."<white>"..h..m..s
    
    return affect
end

function ui.updateAffectsDisplay()
  if gmcp.Char == nil or gmcp.Char.Affects == nil then
    ui.affectsDisplay:clear("Affects")
    ui.affectsDisplay:cecho("Affects", "\nAffects are not implemented yet here.")
    return
  end

  ui.affectsTable = {
    buff = {
      permanent = {},
      timed = {}
    },
    debuff = {
      permanent = {},
      timed = {}
    }
  }

  ui.affectsDisplay:clear("Affects")
  
  ui.affectsDisplay:cecho("Affects", "<white>Affected by:"..string.rep(" ", math.floor(ui.affectsDisplay:get_width()/(ui.consoleFontWidth))-22).."Duration: ")
  ui.affectsDisplay:cecho("Affects", "\n")
  
  local haveBuff = false
  
  -- Process all affects
  for _, affect in pairs(gmcp.Char.Affects) do
    local isBuff = affect.type ~= "debuff"
    local isPermanent = affect.duration_cur < 0
    
    if isBuff then
      haveBuff = true
      if isPermanent then
        table.insert(ui.affectsTable.buff.permanent, affect.name)
      else
        table.insert(ui.affectsTable.buff.timed, ui.showTempAffects(affect.name, affect.duration_cur, true))
      end
    else
      if isPermanent then
        table.insert(ui.affectsTable.debuff.permanent, affect.name)
      else
        table.insert(ui.affectsTable.debuff.timed, ui.showTempAffects(affect.name, affect.duration_cur, false))
      end
    end
  end
  
  -- Show permanent positive affects
  for _, affect in pairs(ui.affectsTable.buff.permanent) do
    ui.affectsDisplay:cecho("Affects", "<SkyBlue>"..affect..string.rep(" ", math.floor(ui.affectsDisplay:get_width()/ui.consoleFontWidth)-string.len(affect)-3).."<gold>-- \n")
  end
  
  -- Show temporary positive effects
  for _, affect in pairs(ui.affectsTable.buff.timed) do
    ui.affectsDisplay:cecho("Affects", affect.."\n")
  end
  
  if haveBuff then ui.affectsDisplay:echo("Affects","\n") end
  
  -- Show permanent negative affects
  for _, affect in pairs(ui.affectsTable.debuff.permanent) do
    ui.affectsDisplay:cecho("Affects", "<red>"..affect..string.rep(" ", math.floor(ui.affectsDisplay:get_width()/ui.consoleFontWidth)-string.len(affect)-3).."<gold>-- \n")
  end
  
  -- Show temporary negative effects
  for _, affect in pairs(ui.affectsTable.debuff.timed) do
    ui.affectsDisplay:cecho("Affects", affect.."\n")
  end
end

function ui.testStatus()

gmcp.Char.Statuses.active = { 
  {
      buff = 0,
      desc = "You are encumbered.",
      duration = -0.1,
      id = 55,
      type = "Encumbered"
    },
    {
      buff = 1,
      desc = "You are fast",
      duration = 10000,
      id = 56,
      type = "Hasted"
    },
    {
      buff = 0,
      desc = "You are fast",
      duration = 10000,
      id = 56,
      type = "Stupid"
    },
    {
      buff = 1,
      desc = "You are fast",
      duration = -1,
      id = 56,
      type = "Quick"
    },

  cast = "",
  charge = "",
  stance = "",
}


end

function ui.showTempAffects(name, dur, buff)
    local name = name
    local dur = dur
    local buff = buff
    
    local h, m, s = shms(dur)
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
    
    if buff == 1 then
      color = "<SpringGreen>"
    elseif buff == 0 then
      color = "<red>"
    end
    
    local affect = color..name..string.rep(" ", 28-string.len(name))..string.rep(" ", math.ceil(ui.affectsDisplay:get_width()/ui.consoleFontWidth)-20-string.len(name)-(4-string.len(name))-string.len(timeLen)-6).."<white>"..h..m..s
    
    return affect
end




function ui.updateAffectsDisplay()
  if gmcp.Char == nil or gmcp.Char.Statuses == nil then
    ui.affectsDisplay:clear("Affects")
    ui.affectsDisplay:cecho("Affects", "\nAffects are not implemented yet here.")
    return
  end
  ui.affectsTable = {
    buff = {
      permanent = {
      },
      timed = {
      }
    },
    debuff = {
      permanent = {
      },
      timed = {
      }
    }
  }

  
  ui.affectsDisplay:clear("Affects") -- Clear the window, and prepare to write new values
  
  ui.affectsDisplay:cecho("Affects", "<white>Affected by:"..string.rep(" ", math.floor(ui.affectsDisplay:get_width()/(ui.consoleFontWidth))-22).."Duration: ")
  ui.affectsDisplay:cecho("Affects", "\n")
  
  local haveBuff = 0
  if gmcp.Char.Statuses.active ~= {} then
  ui.affectsDisplay:cecho("Affects", "\n")  
    
    
    for i,v in pairs(gmcp.Char.Statuses.active) do      
      if v.buff == 1 then
        if v.duration < 0 then
          table.insert(ui.affectsTable.buff.permanent, v.type)
        end
        
        if v.duration > 0 then
          table.insert(ui.affectsTable.buff.timed, ui.showTempAffects(v.type, v.duration, v.buff))
        end
        haveBuff = 1  
      end
      
    end
    
    for i,v in pairs(gmcp.Char.Statuses.active) do
      if v.buff == 0 then
        if v.duration < 0 then
          table.insert(ui.affectsTable.debuff.permanent, v.type)
        end
        
        if v.duration > 0 then
          table.insert(ui.affectsTable.debuff.timed, ui.showTempAffects(v.type, v.duration, v.buff))
        end
        
      end
    end      
    
    
     
    
  end
   
  
  -- Show permanemt positive affects
  for k,v in pairs(ui.affectsTable.buff.permanent) do
    ui.affectsDisplay:cecho("Affects", "<SkyBlue>"..v..string.rep(" ", math.floor(ui.affectsDisplay:get_width()/ui.consoleFontWidth)-string.len(v)-3).."<gold>-- \n")
  end
  
  -- Show temporary positive effects
  for k,v in pairs(ui.affectsTable.buff.timed) do
    ui.affectsDisplay:cecho("Affects", v.."\n")
  end
  
  if haveBuff == 1 then ui.affectsDisplay:echo("Affects","\n") end
  
  -- Show permanemt negative affects
  for k,v in pairs(ui.affectsTable.debuff.permanent) do
    ui.affectsDisplay:cecho("Affects", "<red>"..v..string.rep(" ", math.floor(ui.affectsDisplay:get_width()/ui.consoleFontWidth)-string.len(v)-3).."<gold>-- \n")
  end
  
  -- Show temporary negative effects
  for k,v in pairs(ui.affectsTable.debuff.timed) do
    ui.affectsDisplay:cecho("Affects", v.."\n")
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

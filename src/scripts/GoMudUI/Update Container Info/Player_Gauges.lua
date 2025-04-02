function ui.updatePlayerGauges()
  if gmcp.Char == nil or gmcp.Char.Vitals == nil or gmcp.Char.Vitals.hp == nil then
    ui.hpGauge:setValue(100,100)
    ui.spGauge:setValue(100,100)
    return
  end
  
  --If gmcp information is availabe set the values, otherwise use dummy values.
  if gmcp.Char.Vitals then
    hp = gmcp.Char.Vitals.hp or 0
    hp_max = gmcp.Char.Vitals.hp_max or 0
    sp = gmcp.Char.Vitals.sp or 0
    sp_max = gmcp.Char.Vitals.sp_max or 0
  
    -- Update health
    ui.hpGauge:setValue(hp, hp_max, f"<center>{hp}/{hp_max}</center>")
    
    -- Update mana
    ui.spGauge:setValue(sp, sp_max, f"<center>{sp}/{sp_max}</center>")
    
  else
    ui.hpGauge:setValue(100,100)
    ui.spGauge:setValue(100,100)
  end

end
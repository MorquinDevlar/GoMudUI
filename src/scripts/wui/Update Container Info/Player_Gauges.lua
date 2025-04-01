function wui.updatePlayerGauges()
  if gmcp.Char == nil or gmcp.Char.Vitals == nil or gmcp.Char.Vitals.hp == nil then
    wui.hpGauge:setValue(100,100)
    wui.spGauge:setValue(100,100)
    return
  end
  
  --If gmcp information is availabe set the values, otherwise use dummy values.
  if gmcp.Char.Vitals then
    hp = gmcp.Char.Vitals.hp or 0
    hp_max = gmcp.Char.Vitals.maxhp or 0
    sp = gmcp.Char.Vitals.mp or 0
    sp_max = gmcp.Char.Vitals.maxmp or 0
  
    -- Update health
    wui.hpGauge:setValue(gmcp.Char.Vitals.hp, gmcp.Char.Vitals.maxhp, f"<center>{hp}/{hp_max}</center>")
    
    -- Update mana
    wui.spGauge:setValue(gmcp.Char.Vitals.mp, gmcp.Char.Vitals.maxmp, f"<center>{sp}/{sp_max}</center>")
    
  else
    wui.hpGauge:setValue(100,100)
    wui.spGauge:setValue(100,100)
  end

end
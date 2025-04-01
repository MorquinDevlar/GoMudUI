function wui.updateEnemyGauge()
  if gmcp.Char == nil then return end
  --If gmcp information is availabe set the values, otherwise use dummy values.
  if gmcp.Char.Enemies and gmcp.Char.Enemies[1] then
    -- Update enemy health
    
    wui.enemyGauge.front:setStyleSheet(f[[{wui.settings.cssFont} background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(150, 25, 25), stop: 0.1 rgb(180,0,0), stop: 0.85 rgb(155,0,0), stop: 1 rgb(130,0,0));border-radius: 3px;border: 1px solid rgba(160, 160, 160, 50%);]]) 
    
    if 1 > 2 then
      wui.enemyGauge:setValue(gmcp.Char.Enemies[1].hp, gmcp.Char.Enemies[1].maxhp, f"<center>"..gmcp.Char.Enemies[1].name.."</center>")
      else 
      wui.enemyGauge:setValue(gmcp.Char.Enemies[1].hp, gmcp.Char.Enemies[1].maxhp, f"")
    end

    wui.enemyLabel:echo(gmcp.Char.Enemies[1].hp.."/"..gmcp.Char.Enemies[1].maxhp)
  end
  if not gmcp.Char.Enemies[1] then
    wui.enemyGauge.front:setStyleSheet(f[[{wui.settings.cssFont} background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(100, 25, 25), stop: 0.1 rgb(120,0,0), stop: 0.85 rgb(105,0,0), stop: 1 rgb(80,0,0));border-radius: 3px;border: 1px solid rgba(160, 160, 160, 50%);]])
    wui.enemyGauge:setValue(100,100, f"<center>No Enemy</center>")
    wui.enemyLabel:echo("")
  end
end
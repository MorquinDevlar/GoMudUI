function ui.updateCombatDisplay()
  local primaryEnemy = "none"
  local hostileGuid = {}
  
  if not gmcp.Char then
    return
  end
  
  if not gmcp.Char.Enemies then
    ui.roomDisplay:clear("Combat")
    ui.roomDisplay:cecho("Combat", "<grey> Not engaged in combat")
    return
  end
  
  if gmcp.Char.Enemies[1] then
    ui.roomDisplay:switchTab("Combat")
    ui.roomDisplay:clear("Combat")
    
    for k,v in pairs(gmcp.Char.Enemies) do
      if k == 1 then 
      table.insert(hostileGuid, v.guid)
      ui.roomDisplay:cecho("Combat", "<grey>Target<white>:\n")
      ui.roomDisplay:cecho("Combat", "<red>"..v.name..string.rep(" ", 35-string.len(v.name)-string.len(tostring(v.hp))-string.len(tostring(v.maxhp))).."<gold>"..v.hp.."<white>/<gold>"..v.maxhp.."\n")
      end
    end
    
    for k,v in pairs(gmcp.Char.Enemies) do
      if k > 1 then 
      table.insert(hostileGuid, v.guid)
      ui.roomDisplay:cecho("Combat", "\n<grey>Hostiles<white>:\n")
      ui.roomDisplay:cecho("Combat", "<red>"..v.name..string.rep(" ", 35-string.len(v.name)-string.len(tostring(v.hp))-string.len(tostring(v.maxhp))).."<gold>"..v.hp.."<white>/<gold>"..v.maxhp.."\n")
      end
    end
    
    for k,v in pairs(gmcp.Room.Actor) do
      if (v.type == "Peaceful" or v.type == "Innocent") and not table.contains(hostileGuid, v.guid) then
        ui.roomDisplay:cecho("Combat", "\n<grey>Innocent/Peacefuls<white>:\n")
        break
      end
    end
    
    for k,v in pairs(gmcp.Room.Actor) do
      if (v.type == "Peaceful" or v.type == "Innocent") and not table.contains(hostileGuid, v.guid) then
        ui.roomDisplay:cecho("Combat", "<cyan>"..v.name.."\n")
      end
    end
    
  else
    ui.roomDisplay:switchTab("Room")
    primaryEnemy = "none"
    hostileGuid = {}
    ui.roomDisplay:clear("Combat")
    ui.roomDisplay:cecho("Combat", "<grey>Target<white>:\n")
    ui.roomDisplay:cecho("Combat", "<red>"..primaryEnemy.."\n")
  end
  
end
function wui.settingsHandler(key, arg)
  wui.settings.userToggles[key][arg].state = not wui.settings.userToggles[key][arg].state
  if wui.settings.userToggles[key][arg].state then
    wui.displayUIMessage(wui.settings.userToggles[key][arg].desc.."  <green>ON")
    if arg == "numpadWalking" then enableKey("Numpad Walking") end
  else
    wui.displayUIMessage(wui.settings.userToggles[key][arg].desc.."  <red>OFF")
    if arg == "numpadWalking" then disableKey("Numpad Walking") end
  end
  
  table.save(getMudletHomeDir().."/"..wui.packageName.."/wui.settings.lua", wui.settings)
  wui.showSettings(_,_,_,"Settings")
end

function wui.showSettings(event, display, tabOld, tabNew)
  if not wui.mapperDisplay then return end
  if tabNew == "Settings" then
    local setKeys = table.keys(wui.settings.userToggles)    
    --display(setKeys)
    -- Make sure the Settings container is empty before we write to it
    wui.mapperDisplay:clear("Settings")
        
    wui.mapperDisplay:cecho("Settings","\nClick on a setting name to toggle it\n")
    
    for _,key in pairs(setKeys) do
      wui.mapperDisplay:cecho("Settings","\n<gold>"..wui.titleCase(key).."<white>:\n")
      for k,v in pairs(wui.settings.userToggles[key]) do
        wui.mapperDisplay:cecho("Settings","<white>[")
        if wui.settings.userToggles[key][k].state then
          wui.mapperDisplay:cecho("Settings","<green>On ")
        else
          wui.mapperDisplay:cecho("Settings","<red>Off")
        end
        wui.mapperDisplay:cechoLink("Settings","<white>] "..wui.settings.userToggles[key][k].desc.."\n", [[wui.settingsHandler("]]..key..[[","]]..k..[[")]], wui.settings.userToggles[key][k].desc, true)
      end
    end
  end
end
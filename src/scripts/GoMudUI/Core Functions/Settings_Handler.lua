function ui.settingsHandler(key, arg)
  ui.settings.userToggles[key][arg].state = not ui.settings.userToggles[key][arg].state
  if ui.settings.userToggles[key][arg].state then
    ui.displayUIMessage(ui.settings.userToggles[key][arg].desc.."  <green>ON")
    if arg == "numpadWalking" then enableKey("Numpad Walking") end
  else
    ui.displayUIMessage(ui.settings.userToggles[key][arg].desc.."  <red>OFF")
    if arg == "numpadWalking" then disableKey("Numpad Walking") end
  end
  
  table.save(getMudletHomeDir().."/"..ui.packageName.."/ui.settings.lua", ui.settings)
  ui.showSettings(_,_,_,"Settings")
end

function ui.showSettings(event, display, tabOld, tabNew)
  if not ui.mapperDisplay then return end
  if tabNew == "Settings" then
    local setKeys = table.keys(ui.settings.userToggles)    
    --display(setKeys)
    -- Make sure the Settings container is empty before we write to it
    ui.mapperDisplay:clear("Settings")
        
    ui.mapperDisplay:cecho("Settings","\nClick on a setting name to toggle it\n")
    
    for _,key in pairs(setKeys) do
      ui.mapperDisplay:cecho("Settings","\n<gold>"..ui.titleCase(key).."<white>:\n")
      for k,v in pairs(ui.settings.userToggles[key]) do
        ui.mapperDisplay:cecho("Settings","<white>[")
        if ui.settings.userToggles[key][k].state then
          ui.mapperDisplay:cecho("Settings","<green>On ")
        else
          ui.mapperDisplay:cecho("Settings","<red>Off")
        end
        ui.mapperDisplay:cechoLink("Settings","<white>] "..ui.settings.userToggles[key][k].desc.."\n", [[ui.settingsHandler("]]..key..[[","]]..k..[[")]], ui.settings.userToggles[key][k].desc, true)
      end
    end
  end
end
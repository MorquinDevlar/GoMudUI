function wui.updateCharDisplay()
  if gmcp.Char == nil then return end
  if gmcp.Char.Info == nil then return end
  if gmcp.Char.Worth == nil then return end
  
  local name = gmcp.Char.Info.name or "None"
  local race = gmcp.Char.Info.race or "None"
  local class = gmcp.Char.Info.class or "None"
  
  local level = gmcp.Char.Info.level or 1
  
  wui.charDisplay:clear("Character")
  wui.charDisplay:cecho("Character", fText.fText("<white>[ <gold>Name: <dodger_blue>"..name.." <white>Lvl<gold>: <dodger_blue>"..level.."<white> ]<reset>", {alignment = "center", formatType = "c", width = math.floor(wui.charDisplay:get_width()/wui.consoleFontWidth), cap = "", spacer = "-", inside = true, mirror = true}))
  wui.charDisplay:cecho("Character", "\n")
  wui.charDisplay:cecho("Character", "<white>Race<gold>: <grey>"..race.."  <cyan>Class<gold>: <grey>"..class)
  wui.charDisplay:cecho("Character", "\n")
  wui.charDisplay:cecho("Character", "\n")
  if gmcp.Char.Stats then
    --wui.charDisplay:cecho("Character", "<DodgerBlue>Arm<white>: <cyan>"..gmcp.Char.Stats.arm.." <green>Eva<white>: <cyan>"..gmcp.Char.Stats.eva)
    --wui.charDisplay:cecho("Character", " <DodgerBlue>M-Arm<white>: <cyan>"..gmcp.Char.Stats.marm.." <green>M-Eva<white>: <cyan>"..gmcp.Char.Stats.meva)
    --wui.charDisplay:cecho("Character", "\n")
    --wui.charDisplay:cecho("Character", "\n")
    wui.charDisplay:cecho("Character", "<SeaGreen>Skill Points<white>: <white>"..gmcp.Char.Worth.skillpoints)
    wui.charDisplay:cecho("Character", "\n")
    wui.charDisplay:cecho("Character", "<SkyBlue>Mind<white>: <gold>"..gmcp.Char.Stats.mind)
    wui.charDisplay:cecho("Character", " <SkyBlue>Body<white>: <gold>"..gmcp.Char.Stats.body)
    wui.charDisplay:cecho("Character", " <SkyBlue>Spirit<white>: <gold>"..gmcp.Char.Stats.spirit)
    --wui.charDisplay:cecho("Character", " <SkyBlue>Speed<white>: <magenta>"..gmcp.Char.Stats.spd)
  end
end
function ui.updateCharDisplay()
  if gmcp.Char == nil then return end
  if gmcp.Char.Info == nil then return end
  if gmcp.Char.Worth == nil then return end
  
  local name = gmcp.Char.Info.name or "None"
  local race = gmcp.Char.Info.race or "None"
  local class = gmcp.Char.Info.class or "None"
  
  local level = gmcp.Char.Info.level or 1
  
  ui.charDisplay:clear("Character")
  ui.charDisplay:cecho("Character", fText.fText("<white>[ <gold>Name: <dodger_blue>"..name.." <white>Lvl<gold>: <dodger_blue>"..level.."<white> ]<reset>", {alignment = "center", formatType = "c", width = math.floor(ui.charDisplay:get_width()/ui.consoleFontWidth), cap = "", spacer = "-", inside = true, mirror = true}))
  ui.charDisplay:cecho("Character", "\n")
  ui.charDisplay:cecho("Character", "<white>Race<gold>: <grey>"..race.."  <cyan>Class<gold>: <grey>"..class)
  ui.charDisplay:cecho("Character", "\n")
  ui.charDisplay:cecho("Character", "\n")
  if gmcp.Char.Stats then
    ui.charDisplay:cecho("Character", "<SeaGreen>Skill Points<white>: <white>"..(gmcp.Char.Worth.skillpoints or "0"))
    ui.charDisplay:cecho("Character", "\n")
    ui.charDisplay:cecho("Character", "<SkyBlue>Mysticism<white>: <gold>"..(gmcp.Char.Stats.mysticism or "0"))
    ui.charDisplay:cecho("Character", " <SkyBlue>Perception<white>: <gold>"..(gmcp.Char.Stats.perception or "0"))
    ui.charDisplay:cecho("Character", "\n")
    ui.charDisplay:cecho("Character", "<SkyBlue>Smarts<white>: <gold>"..(gmcp.Char.Stats.smarts or "0"))
    ui.charDisplay:cecho("Character", " <SkyBlue>Speed<white>: <gold>"..(gmcp.Char.Stats.speed or "0"))
    ui.charDisplay:cecho("Character", "\n")
    ui.charDisplay:cecho("Character", "<SkyBlue>Strength<white>: <gold>"..(gmcp.Char.Stats.strength or "0"))
    ui.charDisplay:cecho("Character", " <SkyBlue>Vitality<white>: <gold>"..(gmcp.Char.Stats.vitality or "0"))
  end
end
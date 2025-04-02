function ui.updateCharDisplay()
  -- Early returns if required GMCP data is missing
  if gmcp.Char == nil then return end
  if gmcp.Char.Info == nil then return end
  if gmcp.Char.Worth == nil then return end
  
  -- Extract character info with defaults
  local name = gmcp.Char.Info.name or "None"
  local race = ui.titleCase(gmcp.Char.Info.race) or "None"
  local class = ui.titleCase(gmcp.Char.Info.class) or "None"
  local alignment = ui.titleCase(gmcp.Char.Info.alignment) or "None"
  local level = gmcp.Char.Info.level or 1
  
  -- Clear and update display
  ui.charDisplay:clear("Character")
  
  -- Header with centered formatting
  ui.charDisplay:cecho(
    "Character", 
    fText.fText(
      "<white>[ <gold>Name: <dodger_blue>"..name.."<white> Lvl<gold>: <dodger_blue>"..level.."<white> ]<reset>", 
      {
        alignment = "center",
        formatType = "c",
        width = math.floor(ui.charDisplay:get_width()/ui.consoleFontWidth),
        cap = "",
        spacer = "-",
        inside = true,
        mirror = true
      }
    )
  )
  
  ui.charDisplay:cecho("Character", "\n")
  ui.charDisplay:cecho("Character", "<white>Race<gold>: <grey>"..race.."  <cyan>Class<gold>: <grey>"..class)
  ui.charDisplay:cecho("Character", "\n")
  ui.charDisplay:cecho("Character", "<white>Alignment<gold>: <grey>"..alignment)
  ui.charDisplay:cecho("Character", "\n\n")
  
  -- Stats section (if available)
  if gmcp.Char.Stats then
    -- Worth points
    ui.charDisplay:cecho(
      "Character",
      "<SeaGreen>Skill Points<white>: <white>"..(gmcp.Char.Worth.skillpoints or "0")..
      "  <DodgerBlue>Training Points<white>: <white>"..(gmcp.Char.Worth.trainingpoints or "0")
    )
    ui.charDisplay:cecho("Character", "\n\n")
    
    -- Stats display (paired for better layout)
    ui.charDisplay:cecho("Character", "<SkyBlue>Mysticism<white>: <gold>"..string.format("%2d", gmcp.Char.Stats.mysticism or 0))
    ui.charDisplay:cecho("Character", "    <SkyBlue>Perception<white>:    <gold>"..string.format("%2d", gmcp.Char.Stats.perception or 0))
    ui.charDisplay:cecho("Character", "\n")
    
    ui.charDisplay:cecho("Character", "<SkyBlue>Smarts<white>:    <gold>"..string.format("%2d", gmcp.Char.Stats.smarts or 0))
    ui.charDisplay:cecho("Character", "    <SkyBlue>Speed<white>:         <gold>"..string.format("%2d", gmcp.Char.Stats.speed or 0))
    ui.charDisplay:cecho("Character", "\n")
    
    ui.charDisplay:cecho("Character", "<SkyBlue>Strength<white>:  <gold>"..string.format("%2d", gmcp.Char.Stats.strength or 0))
    ui.charDisplay:cecho("Character", "    <SkyBlue>Vitality<white>:      <gold>"..string.format("%2d", gmcp.Char.Stats.vitality or 0))
  end
end
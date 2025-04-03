function ui.updateTopBar()
  -- Write UI version number in the top bar:
  ui.topDisplay:clear()
  ui.topDisplay:cecho("<DarkSeaGreen>GoMud UI version<white>: ")
  ui.topDisplay:cechoLink("<SkyBlue><u>"..ui.version.."</u>", [[ui.gomudUIShowFullChangelog()]], "Show the GoMud UI changelog", true)
  if mmp and mmp.version then
    ui.topDisplay:echo("  ")
    ui.topDisplay:cecho("<DarkSeaGreen>Mapper Version<white>: <SkyBlue>"..mmp.version)
  end
  if ui.crowdmapVersion then
    ui.topDisplay:echo("  ")
    ui.topDisplay:cecho("<DarkSeaGreen>Crowdmap Version<white>: ")
    ui.topDisplay:cechoLink("<SkyBlue><u>"..ui.crowdmapVersion.."</u>", [[mmp.showcrowdchangelog()]],"Show the crowdmap changelog",true)
  end
  
  
  if gmcp.Game and gmcp.Game.Info then
    -- Get the time difference
    local timeElapsed = ui.getTimeElapsed(gmcp.Game.Info.logintime)

    -- Display the result
    ui.topDisplay:echo("  ")
    ui.topDisplay:cecho("<DarkSeaGreen>Connection Time<white>: <SkyBlue>"..timeElapsed)
  end


end
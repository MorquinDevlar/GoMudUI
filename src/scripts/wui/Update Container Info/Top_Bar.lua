function wui.updateTopBar()
  -- Write UI version number in the top bar:
  wui.topDisplay:clear()
  wui.topDisplay:cecho("<DarkSeaGreen>Willowdale UI version<white>: ")
  wui.topDisplay:cechoLink("<SkyBlue><u>"..wui.version.."</u>", [[wui.willowdaleUIShowFullChangelog()]], "Show the Willowdale UI changelog", true)
  if mmp and mmp.version then
    wui.topDisplay:echo("  ")
    wui.topDisplay:cecho("<DarkSeaGreen>Mapper Version<white>: <SkyBlue>"..mmp.version)
  end
  if wui.crowdmapVersion then
    wui.topDisplay:echo("  ")
    wui.topDisplay:cecho("<DarkSeaGreen>Crowdmap Version<white>: ")
    wui.topDisplay:cechoLink("<SkyBlue><u>"..wui.crowdmapVersion.."</u>", [[mmp.showcrowdchangelog()]],"Show the crowdmap changelog",true)
  end
end
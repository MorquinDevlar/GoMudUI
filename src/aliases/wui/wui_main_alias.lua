local command = string.trim(matches[2])

if command == "" then
  cecho(
  [[<sky_blue>
                        ****    Welcome to the Willowdale Mudlet UI    ****
  
  <grey>This is a work in progress, developed by Morquin inspired by Durd of Asteria.
  
  <yellow>Expect things to break! :)
  <grey>
  In the Settings tab, initially found (unless you have moved it) in the lower
  right corner, next to the Map tab you will find a number of UI settings.
  
  <cyan>Commands available now are:
  
  <green> wui                        <grey>Show this screen again
  
  <green> wui note <note>            <grey>Save a note for a room
  <green> wui note clear             <grey>Remove a note from a room
  <green> wui exploration            <grey>Show map exploration
  
  <YellowGreen> wui color                  <grey>Change the color of the tabs in the UI
  
  <OliveDrab> wui check                  <grey>Manually check for a UI update  
  <OliveDrab> wui update layout          <grey>Update layout with font or size changes
  <OliveDrab> wui update ui              <grey>Manually update to newest UI
  <OliveDrab> wui reset settings         <grey>Clear any custom settings, reverting to default
  <OliveDrab> wui reset layout           <grey>Reset the UI back to initial layout
  <OliveDrab> wui containers             <grey>Show and manage all the UI containers
  <OliveDrab> wui debug                  <grey>Show some UI debug info
  ]]
  )

elseif command == "debug" then
  wui.showDebug()

elseif command == "reset" then
  if matches[3] == "settings" then
    wui.createSettings()
    wui.displayUIMessage("Default settings loaded")
  elseif matches[3] == "layout" then
    wui.createContainers("reset")
    wui.displayUIMessage("Default layout loaded")
  end

elseif command == "exploration" then
  wui.showMapExpLevel()

elseif command == "note" then
  wui.saveRoomNotes(matches[3])

elseif command == "update" then
  if matches[3] == "layout" then
    wui.createContainers("layout_update")
  end
  if matches[3] == "ui" then
    wui.installWillowdaleUI()
  end
  
elseif command == "check" then
  wui.manualUpdate = true
  wui.checkForUpdate()


elseif command =="color" then
  cecho("\n <YellowGreen>Choose which item you want to change color on, \n then click on a color name to change to\n\n")
  echo("\n")
  cechoLink(" <wheat>Change the: <SteelBlue><u>Active tab color</u>", [[displayColors({justText = true, wuiSetting = "activeTabBGColor"})]],"Change the Active Tab color", true)
  echo("\n")
  cechoLink(" <wheat>Change the: <SteelBlue><u>Inactive tab color</u>", [[displayColors({justText = true, wuiSetting = "inactiveTabBGColor"})]],"Change the Inctive Tab color", true)
  echo("\n")

elseif command == "containers" then
  wui.showContainerState()

else
  wui.displayUIMessage("Unknown command option <white>"..command.."<reset>")
end
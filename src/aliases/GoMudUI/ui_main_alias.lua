local command = string.trim(matches[2])

if command == "" then
  cecho(
  [[<sky_blue>
                        ****    Welcome to the GoMud Mudlet UI    ****
  
  <grey>This is a work in progress, developed by Morquin inspired by Durd of Asteria.
  
  <yellow>Expect things to break! :)
  <grey>
  In the Settings tab, initially found (unless you have moved it) in the lower
  right corner, next to the Map tab you will find a number of UI settings.
  
  <cyan>Commands available now are:
  
  <green> ui                        <grey>Show this screen again
  
  <green> ui note <note>            <grey>Save a note for a room
  <green> ui note clear             <grey>Remove a note from a room
  <green> ui exploration            <grey>Show map exploration
  
  <YellowGreen> ui color                  <grey>Change the color of the tabs in the UI
  
  <OliveDrab> ui check                  <grey>Manually check for a UI update  
  <OliveDrab> ui update layout          <grey>Update layout with font or size changes
  <OliveDrab> ui update ui              <grey>Manually update to newest UI
  <OliveDrab> ui reset settings         <grey>Clear any custom settings, reverting to default
  <OliveDrab> ui reset layout           <grey>Reset the UI back to initial layout
  <OliveDrab> ui containers             <grey>Show and manage all the UI containers
  <OliveDrab> ui debug                  <grey>Show some UI debug info
  ]]
  )

elseif command == "debug" then
  ui.showDebug()

elseif command == "reset" then
  if matches[3] == "settings" then
    ui.createSettings()
    ui.displayUIMessage("Default settings loaded")
  elseif matches[3] == "layout" then
    ui.createContainers("reset")
    ui.displayUIMessage("Default layout loaded")
  end

elseif command == "exploration" then
  ui.showMapExpLevel()

elseif command == "note" then
  ui.saveRoomNotes(matches[3])

elseif command == "update" then
  if matches[3] == "layout" then
    ui.createContainers("layout_update")
  end
  if matches[3] == "ui" then
    ui.installGoMudUI()
  end
  
elseif command == "check" then
  ui.manualUpdate = true
  ui.checkForUpdate()


elseif command =="color" then
  cecho("\n <YellowGreen>Choose which item you want to change color on, \n then click on a color name to change to\n\n")
  echo("\n")
  cechoLink(" <wheat>Change the: <SteelBlue><u>Active tab color</u>", [[displayColors({justText = true, uiSetting = "activeTabBGColor"})]],"Change the Active Tab color", true)
  echo("\n")
  cechoLink(" <wheat>Change the: <SteelBlue><u>Inactive tab color</u>", [[displayColors({justText = true, uiSetting = "inactiveTabBGColor"})]],"Change the Inctive Tab color", true)
  echo("\n")

elseif command == "containers" then
  ui.showContainerState()

else
  ui.displayUIMessage("Unknown command option <white>"..command.."<reset>")
end
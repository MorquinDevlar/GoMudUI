ui = ui or {} 

function ui.connected()
    ui = ui or {} 
  end
  
  
  function ui.justLoggedIn()
    tempTimer(10, [[ ui.checkForUpdate() ]])
  end
  
  function ui.profileLoaded()
    
    -------------[ Load any saved tables into the name space ]-------------
    
    -- Load saved settings if any
    if io.exists(getMudletHomeDir().."/"..ui.packageName.."/ui.settings.lua") then
      table.load(getMudletHomeDir().."/"..ui.packageName.."/ui.settings.lua", ui.settings) -- using / is OK on Windows too.
      ui.displayUIMessage("Settings Table Loaded")
      else
      -- If we don't find any saved settings load the standard settings
      ui.createSettings()
    end  
  
    -- Load the known rooms table
    if io.exists(getMudletHomeDir().."/"..ui.packageName.."/ui.knownRooms.lua") then
      table.load(getMudletHomeDir().."/"..ui.packageName.."/ui.knownRooms.lua", ui.knownRooms) -- using / is OK on Windows too.
      ui.displayUIMessage("Known rooms loaded")
    end
      
    -- Load the rooms notes
    if io.exists(getMudletHomeDir().."/"..ui.packageName.."/ui.roomNotes.lua") then
      table.load(getMudletHomeDir().."/"..ui.packageName.."/ui.roomNotes.lua", ui.roomNotes) -- using / is OK on Windows too.
      ui.displayUIMessage("Room notes loaded")
    end
    -- Check if we have a crowd map version downloaded
    
    -- Crowmap has been disabled currently.
    
    --if io.exists(getMudletHomeDir().."/map downloads/current") then
    --  ui.crowdmapVersionFile = io.open(getMudletHomeDir().."/map downloads/current",r) -- using / is OK on Windows too.
    --  ui.crowdmapVersion = ui.crowdmapVersionFile:read("*number")
    --end
  
    ui.displayUIMessage("Initializing UI")
    ui.createContainers("startup")
    
    if ui.postInstallDone then
      expandAlias("ui", false)
      ui.postInstallDone = false
    end
  
  end
  
  
  function ui.saveOnExit()
    ui.displayUIMessage("Saving UI tables")
    table.save(getMudletHomeDir().."/"..ui.packageName.."/ui.settings.lua", ui.settings)
    table.save(getMudletHomeDir().."/"..ui.packageName.."/ui.knownRooms.lua", ui.knownRooms)
    table.save(getMudletHomeDir().."/"..ui.packageName.."/ui.roomNotes.lua", ui.roomNotes)
  end
  
  function ui.postInstallHandling(_, package)
  
    if package == "mudlet-mapper_custom" then
      mmp = mmp or {}
      raiseEvent("mmp logged in", "gomud")
      mmp.game = "gomud"
      mmp.echo("We're connected to GoMud.")
    end
    
    if package == "GoMudUI" then
     
      --Check if the generic_mapper package is installed and if so uninstall it
      if table.contains(getPackages(),"generic_mapper") then
        ui.displayUIMessage("Now removing standard mapping script")
        if map.registeredEvents then -- Prevent the generic mapper script from showing confusing information
          for _,id in ipairs(map.registeredEvents) do
                killAnonymousEventHandler(id)
          end
        end
        tempTimer(1, function() uninstallPackage("generic_mapper") end)
      end
    
      -- Options for pre-relase versions:
      if string.find(ui.version, "pre") then
        ui.displayUIMessage("This is a pre-release version. Version is: "..ui.version)
        ui.profileLoaded()
        ui.connected()
      end
      --ui.createContainers("startup")
          
      -- Check if there is a map loaded already
      if table.is_empty(getRooms()) then
        -- there is no map loaded, but if you want a secondary doublecheck
        if table.size(getAreaTable()) == 1 then
        -- only has the defaultarea, and no rooms, so there's definitely no map loaded
        ui.displayUIMessage("No map loaded")
        --ui.displayUIMessage("Use 'mconfig crowdmap on' to use the crowd map")
        end
      end
      
      -- Install IRE mapping script  
      if not table.contains(getPackages(),"mudlet-mapper_custom") then
        ui.displayUIMessage("Now installing custom mapper script")
        tempTimer(1, function() installPackage("https://play.gomudmud.com/static/website/ui/mudlet-mapper_custom.mpackage") end)
      end
      
      ui.postInstallDone = true
      
      if not ui.isUpdating then
        ui.profileLoaded()
      end
      ui.updateTopBar()
    end
    
  end
  
  function ui.unInstall(_, package)
    
    if package == "GoMudUI" and not ui.isUpdating then
      ui.displayUIMessage("Cleaning up - removing the UI mapper")
      uninstallPackage("mudlet-mapper_custom")
      
      ui.displayUIMessage("Re-installing the generic mapper")
      if not table.contains(getPackages(),"generic_mapper") then
        tempTimer(1, function() installPackage("https://raw.githubusercontent.com/Mudlet/Mudlet/development/src/mudlet-lua/lua/generic-mapper/generic_mapper.xml") end)
      end
      
      ui.displayUIMessage("Removing windows and resetting borders")
      ui.left:hide()
      ui.right:hide()
      ui.bottom:hide()
      ui.top:hide()
      
      setBorderBottom(0)
      setBorderTop(0)
      setBorderLeft(0)
      setBorderRight(0)
      setFont("main", "Bitstream Vera Sans Mono")
      
      tempTimer(3, function() resetProfile() end)
    end
  end
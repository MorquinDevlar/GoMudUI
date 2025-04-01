function wui.createContainers(arg)
  -- Do some caltulations on font sizes to make sure everything fits into the console we create
  -- By calculating the pixel width of the font, we are able to make sure we size the consoles and windows correctly
  wui.consoleFontWidth, wui.consoleFontHeight = calcFontSize(wui.settings.consoleFontSize, wui.settings.consoleFont)
  
  -- If someone sets a different font/fontsize in the main window, lets make sure we have that defined as well
  wui.mainFontWidth, wui.mainFontHeight = calcFontSize(getFontSize("main"), getFont(main))
  
  -- Lets calculate the gauge font sizes as well
  wui.gaugeFontWidth, wui.gaugeFontHeight = calcFontSize(wui.settings.gaugeFontSize, wui.settings.consoleFont)
  
  -- Lets calculate the prompt font sizes as well
  wui.promptFontWidth, wui.promptFontHeight = calcFontSize(wui.settings.promptFontSize, wui.settings.consoleFont)
  
  -------------[ If a full reset is required ]-------------
  local arg = arg
  local containerAutoload = true
  
  if arg == "reset" then
    for k,v in pairs(wui.settings.containers) do
      if wui[k] then
        wui[k]:deleteSaveFile()
        wui[k] = nil
      end
      wui.top = nil
      wui.left = nil
      wui.right = nil
      wui.bottom = nil
      containerAutoload = false
    end
    for k,v in pairs(wui.settings.displays) do
      wui[k] = nil
      containerAutoload = false
    end
  end
  
  -------------[ Start by building the borders ]-------------

  wui.top = wui.top or Adjustable.Container:new({
    name = "wui.top",
    y= 0 , height = "4c",
    padding = 4,
    attachedMargin = 0,
    adjLabelstyle = wui.settings.topCSS,
    autoLoad = containerAutoload
  })
  
  wui.bottom = wui.bottom or Adjustable.Container:new({
    name = "wui.bottom",
    height = 105,
    y = -105,
    padding = 4,
    attachedMargin = 0,
    adjLabelstyle = wui.settings.bottomCSS,
    autoLoad = containerAutoload
  })
  
  wui.right = wui.right or Adjustable.Container:new({
    name = "wui.right",
    y = "0%",
    x = "-30%",
    height = "100%",
    width = "30%",
    padding = 4,
    attachedMargin = 0,
    adjLabelstyle = wui.settings.rightCSS,
    autoLoad = containerAutoload
  })

  wui.left = wui.left or Adjustable.Container:new({
    name = "wui.left",
    x = "0%",
    y = "0%",
    height = "100%",
    width = wui.consoleFontWidth * 46,
    padding = 4,
    attachedMargin = 10,
    adjLabelstyle = wui.settings.leftCSS,
    autoLoad = containerAutoload
  })
  
  
  wui.top:attachToBorder("top")
  wui.bottom:attachToBorder("bottom")
  wui.left:attachToBorder("left")
  wui.right:attachToBorder("right")
  
  wui.top:connectToBorder("left")
  wui.top:connectToBorder("right")
  wui.bottom:connectToBorder("left")
  wui.bottom:connectToBorder("right")

  
  wui.top:lockContainer("border")
  wui.left:lockContainer("border")
  wui.right:lockContainer("border")
  wui.bottom:lockContainer("border")

  -- Knowing the window size, lets us calculate how mush space we can use for everything else and still display the mud output
  wui.mainWindowWidth = select(1,getMainWindowSize())-wui.left:get_width()-wui.right:get_width()
    
  -------------[ Build the adjustable containers ]-------------
  for k,v in pairs(wui.settings.containers) do
    local consoleHeight = ""
    local consoleY = ""
    local w,h
    if v.fs then
      w,h = calcFontSize(v.fs, wui.settings.consoleFont)
    else
      h = wui.consoleFontHeight
    end
    
    if assert(type(v.height)) == "number" then
      consoleHeight = h * v.height
    else
      consoleHeight = v.height
    end
    if assert(type(v.y)) == "number" then
      consoleY = h * v.y
    else
      consoleY = v.y
    end
    
    local containerName = "wui."..k
    
    wui[k] = wui[k] or Adjustable.Container:new({
    name = containerName,
    titleText = k,
    x = v.x or 0,
    y = consoleY,
    padding = 5,    attachedMargin = 0,
    width = v.width or "100%",
    autoWrap = v.wrap or false,
    height = consoleHeight,
    fontSize = v.fs or wui.settings.consoleFontSize,
    adjLabelstyle = v.customCSS or wui.settings.moveableConsoleCSS,
    autoLoad = containerAutoload
    }, wui[v.dest])
    
    wui[k]:newCustomItem("Move to left side",
    function(self)
      wui.putContainer("left", k)
    end
    )
    
    wui[k]:newCustomItem("Move to right side",
    function(self)
      wui.putContainer("right", k)
    end
    )
    
    wui[k]:newCustomItem("Move to bottom",
    function(self)
      wui.putContainer("bottom", k)
    end
    )
    
    wui[k]:newCustomItem("Move to top",
    function(self)
      wui.putContainer("top", k)
    end
    )
    
    wui[k]:newCustomItem("Pop out",
    function(self)
      wui.popOutContainer(k)
    end
    )
    
    wui[k]:lockContainer("border")
  end
  
  -------------[ Build the EMCO and Miniconsole objects ]-------------
  
  for k,v in pairs(wui.settings.displays) do
    local containerName = "wui."..k
    local console = v.tabs
          
    if v.emco and not v.mapper then
      wui[k] = EMCO:new({
        name = containerName,
        x = 0,
        y = 2,
        width = "100%",
        height = "100%",
        tabFontSize = wui.settings.tabFontSize,
        tabHeight = wui.settings.tabHeight,
        gap = wui.settings.tabGap,
        fontSize = wui.settings.consoleFontSize,
        font = wui.settings.consoleFont,
        tabFont = wui.settings.consoleFont,
        autoWrap = v.wrap or false,
        tabBoxColor = wui.settings.tabBarColor,
        consoleColor = wui.settings.consoleBackgroundColor,
        activeTabFGColor = wui.settings.activeTabFGColor,
        activeTabCSS = wui.settings.activeTab,
        inactiveTabFGColor = wui.settings.inactiveTabFGColor,
        inactiveTabCSS = wui.settings.inactiveTab,
        consoles = console
      }, wui[v.dest])
      wui[k]:disableAllLogging()
    elseif v.mapper then
      wui[k] = EMCO:new({
        name = containerName,
        x = 0,
        y = 2,
        width = "100%",
        height = "100%",
        tabFontSize = wui.settings.tabFontSize,
        tabHeight = wui.settings.tabHeight,
        gap = wui.settings.tabGap,
        fontSize = wui.settings.consoleFontSize,
        font = wui.settings.consoleFont,
        tabFont = wui.settings.consoleFont,
        allTab = false,
        autoWrap = false,
        mapTab = true,
        mapTabName = v.mapTab,
        tabBoxColor = wui.settings.consoleBackgroundColor,
        consoleContainerColor = wui.settings.consoleBackgroundColor,
        consoleColor = wui.settings.consoleBackgroundColor,
        activeTabFGColor = wui.settings.activeTabFGColor,
        activeTabCSS = wui.settings.activeTab,
        inactiveTabFGColor = wui.settings.inactiveTabFGColor,
        inactiveTabCSS = wui.settings.inactiveTab,
        consoles = console
      }, wui[v.dest])
      wui[k]:disableAllLogging()
      
      -- Set a map zoom level that is comfortable for most people
      setMapZoom(10)

      -- Set the mapper background color the same as everything else
      setMapBackgroundColor(15,15,15)
      
    else
      wui[k] = Geyser.MiniConsole:new({
        name = containerName,
        x = v.x or 0,
        y = 0,
        width = v.width or "100%",
        padding = 4,
        height = "100%",
        fontSize = wui.settings.promptFontSize,
        font = wui.settings.consoleFont,
        adjLabelstyle = wui.settings.noborderConsoleCSS,
        autoWrap = false,
        color = wui.settings.consoleBackgroundColor,
        autoLoad = containerAutoload,
      }, wui[v.dest])
    end
  end
  
  wui.createPlayerGuages()
  if arg == "layout_update" then
    wui.updateDisplays({type = "update"})
  else
    wui.updateDisplays()
  end
  
  if arg == "reset" then
    wui.displayUIMessage("UI layout set to default")
  end
  if arg == "startup" then
    wui.displayUIMessage("UI containers created\n")
    raiseEvent("UICreated")
  end
end
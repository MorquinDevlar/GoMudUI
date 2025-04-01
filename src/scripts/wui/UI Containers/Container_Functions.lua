function wui.getContainerPositions()
  wui.containerPositions = {}
  Adjustable.Container:doAll(
  function(self)
    local name = self.name
    
    if string.match(self.name, "container") then
      display(self.windowList[windowName])
      wui.containerPositions[name] = {}
      wui.containerPositions[name].x = self:get_x()
      wui.containerPositions[name].y = self:get_y()
      wui.containerPositions[name].height = self:get_height()
      wui.containerPositions[name].width = self:get_width()
    end
  end
  )
end


function wui.putContainer(parentContainer, childContainer)
  local parentContainer = parentContainer
  local childContainer = childContainer
  
  wui[parentContainer]:add(wui[childContainer])
  wui[childContainer]:move(0,_)
  wui[childContainer]:connectToBorder(parentContainer)
  wui[childContainer]:resize("100%",_)
end


function wui.popOutContainer(container)
  local container = container
  local width = wui[container]:get_width()
  local height = wui[container]:get_height()
  local mainW,mainH = getMainWindowSize()
  
  wui[container]:changeContainer(Geyser)
  wui[container]:resize(width,height)
  wui[container]:move("25%","25%")
end

function wui.resetEMCOContainer()
  for k,v in pairs(wui.settings.displays) do
    if not (k == "promptDisplay" or k == "gaugeDisplay" or k == "promptRightDisplay") then
      wui[k]:reset()
    end
  end
end

function wui.showContainerState()
  echo("\n")
  cecho("Container Name:     State:     [     Actions       ]")
  echo("\n")
  cecho(string.rep("-",80))
  echo("\n")
  for k,v in spairs(wui.settings.containers) do
    local state
    if wui[k].hidden then state = "<firebrick>Hidden<reset>" else state = "<ForestGreen>Shown<reset>" end
    cecho("  "..k..":"..string.rep(" ", 18-string.len(k))..state)
    cecho(string.rep(" ", 10-string.len(cecho2string(state))))
    cechoLink("<u>Show</u>",function() wui[k]:show() wui.showContainerState()end,"Show container", true)
    cechoLink("    <u>Hide</u>",function() wui[k]:hide() wui.showContainerState()end,"Hide container", true)
    cechoLink("    <u>Flash</u>",function() wui[k]:flash() end,"Identify the container", true)
    echo("\n")echo("\n")
  end
  echo("\n")
end
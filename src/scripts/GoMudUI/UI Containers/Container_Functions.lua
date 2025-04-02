function ui.getContainerPositions()
  ui.containerPositions = {}
  Adjustable.Container:doAll(
  function(self)
    local name = self.name
    
    if string.match(self.name, "container") then
      display(self.windowList[windowName])
      ui.containerPositions[name] = {}
      ui.containerPositions[name].x = self:get_x()
      ui.containerPositions[name].y = self:get_y()
      ui.containerPositions[name].height = self:get_height()
      ui.containerPositions[name].width = self:get_width()
    end
  end
  )
end


function ui.putContainer(parentContainer, childContainer)
  local parentContainer = parentContainer
  local childContainer = childContainer
  
  ui[parentContainer]:add(ui[childContainer])
  ui[childContainer]:move(0,_)
  ui[childContainer]:connectToBorder(parentContainer)
  ui[childContainer]:resize("100%",_)
end


function ui.popOutContainer(container)
  local container = container
  local width = ui[container]:get_width()
  local height = ui[container]:get_height()
  local mainW,mainH = getMainWindowSize()
  
  ui[container]:changeContainer(Geyser)
  ui[container]:resize(width,height)
  ui[container]:move("25%","25%")
end

function ui.resetEMCOContainer()
  for k,v in pairs(ui.settings.displays) do
    if not (k == "promptDisplay" or k == "gaugeDisplay" or k == "promptRightDisplay") then
      ui[k]:reset()
    end
  end
end

function ui.showContainerState()
  echo("\n")
  cecho("Container Name:     State:     [     Actions       ]")
  echo("\n")
  cecho(string.rep("-",80))
  echo("\n")
  for k,v in spairs(ui.settings.containers) do
    local state
    if ui[k].hidden then state = "<firebrick>Hidden<reset>" else state = "<ForestGreen>Shown<reset>" end
    cecho("  "..k..":"..string.rep(" ", 18-string.len(k))..state)
    cecho(string.rep(" ", 10-string.len(cecho2string(state))))
    cechoLink("<u>Show</u>",function() ui[k]:show() ui.showContainerState()end,"Show container", true)
    cechoLink("    <u>Hide</u>",function() ui[k]:hide() ui.showContainerState()end,"Hide container", true)
    cechoLink("    <u>Flash</u>",function() ui[k]:flash() end,"Identify the container", true)
    echo("\n")echo("\n")
  end
  echo("\n")
end
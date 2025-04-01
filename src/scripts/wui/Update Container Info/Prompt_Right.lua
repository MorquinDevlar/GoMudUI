function wui.updatePromptRightDisplay()
  if gmcp.Char == nil then return end
  local mainWidth = wui.mainWindowWidth
  wui.container9:resize(mainWidth-560,52)
  wui.promptRightDisplay:enableAutoWrap()
  wui.promptRightDisplay:clear()
    
  wui.promptRightDisplay:cecho("This area is not used yet...")
end
function ui.updatePromptRightDisplay()
  if gmcp.Char == nil then return end
  local mainWidth = ui.mainWindowWidth
  ui.container9:resize(mainWidth-560,52)
  ui.promptRightDisplay:enableAutoWrap()
  ui.promptRightDisplay:clear()
    
  ui.promptRightDisplay:cecho("This area is not used yet...")
end
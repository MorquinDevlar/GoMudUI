function ui.clearAreaVisited(area)
  local roomTable = getAreaRooms(area)
  cecho("\n<grey>Area name<white>: <lime_green>"..getRoomAreaName(area).." <grey> now cleared.\n\n")
    
  for k,v in spairs(roomTable) do
    local roomId = v
    
    local areaSelect = getRoomAreaName(getRoomArea(v))
    
    ui.knownRooms[v] = nil
    
  end

ui.showMapExpLevel()  
end
function wui.clearAreaVisited(area)
  local roomTable = getAreaRooms(area)
  cecho("\n<grey>Area name<white>: <lime_green>"..getRoomAreaName(area).." <grey> now cleared.\n\n")
    
  for k,v in spairs(roomTable) do
    local roomId = v
    
    local areaSelect = getRoomAreaName(getRoomArea(v))
    
    wui.knownRooms[v] = nil
    
  end

wui.showMapExpLevel()  
end
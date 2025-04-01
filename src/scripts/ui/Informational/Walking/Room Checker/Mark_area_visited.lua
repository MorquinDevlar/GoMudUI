function ui.markAreaVisited(area)
  local roomTable = getAreaRooms(area)
  cecho("\n<grey>Area name<white>: <lime_green>"..getRoomAreaName(area).." <grey> now marked as visited.\n\n")
    
  for k,v in spairs(roomTable) do
    local roomId = v
    
    local areaSelect = getRoomAreaName(getRoomArea(v))
    
    ui.knownRooms[v] = {
    area = areaSelect,
    quest = false,
    shop = false,
    shopName = false,
    }
    
  end
ui.showMapExpLevel()
end
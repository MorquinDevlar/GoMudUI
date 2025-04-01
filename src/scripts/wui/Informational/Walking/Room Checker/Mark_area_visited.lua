function wui.markAreaVisited(area)
  local roomTable = getAreaRooms(area)
  cecho("\n<grey>Area name<white>: <lime_green>"..getRoomAreaName(area).." <grey> now marked as visited.\n\n")
    
  for k,v in spairs(roomTable) do
    local roomId = v
    
    local areaSelect = getRoomAreaName(getRoomArea(v))
    
    wui.knownRooms[v] = {
    area = areaSelect,
    quest = false,
    shop = false,
    shopName = false,
    }
    
  end
wui.showMapExpLevel()
end
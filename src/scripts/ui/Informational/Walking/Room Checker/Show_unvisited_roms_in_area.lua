function ui.showUnvisitedRooms(area)
  local roomTable = getAreaRooms(area)
  cecho("\nArea name: <lime_green>"..getRoomAreaName(area).."\n\n")
  cecho("<cyan>[   id]                Distance:     Name:\n")
  table.sort(roomTable)
  table.sort(ui.knownRooms)
  for k,v in spairs(roomTable) do
    local roomId = v
    if not ui.knownRooms[roomId] then
      --local x, distance = getPath(getPlayerRoom(),roomId)
      local roomName
      if getRoomName(roomId) == "" then roomName = "Unknown name..." else roomName = getRoomName(roomId) end
      
    
    cecho("<DarkSeaGreen>[<yellow>"..string.format("%5s", roomId).."<DarkSeaGreen>]")
    --cechoLink("  <u>Walk to Room</u>  ", [[mmp.gotoRoom(]]..roomId..[[)]], "Walk to room #"..roomId.." - "..roomName, true)
    --cecho("<white>(<gold>"..string.format("%3s", distance).."<white>)<grey> steps")
    cecho(" - <dark_green>"..roomName.."\n")
    else
    cecho("\n<grey>Nothing to show. All known rooms visited.")
    return
    end
  end
  cecho("\n\n<lime_green>Click here to ")
  cechoLink("<firebrick>hightlight ", [[ui.highlightUnvisitedRooms(]]..area..[[)]], "", true)
  cecho("<lime_green>or ")
  cechoLink("<light_blue>unhighlight ", [[ui.highlightUnvisitedRooms(]]..area..[[,"unhighlight")]], "", true)
  cecho("<lime_green>unvisited rooms.")
  
end
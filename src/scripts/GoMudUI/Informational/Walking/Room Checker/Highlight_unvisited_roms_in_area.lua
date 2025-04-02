function ui.highlightUnvisitedRooms(area, var)
  
  local r,g,b = unpack(color_table.red)
  local br,bg,bb = unpack(color_table.black)
  local area
  
  if not area or area == "" then
    area = getRoomArea(gmcp.Room.Info.num)
  end
  
  local roomTable = getAreaRooms(area)
  
  for k,v in ipairs(roomTable) do
    local roomId = v
    if var == "unhighlight" then
      ui.unHighLightRooms(roomId)
    elseif
    not ui.knownRooms[roomId] then
      ui.highLightRooms(roomId, r, g, b, br, bg, bb)
    end
  end
  
end

function ui.highLightRooms(room, r, g, b, br, bg, bb)
  highlightRoom(room, r,g,b,br,bg,bb, 0.8, 255, 0)
end

function ui.unHighLightRooms(room)
  unHighlightRoom(room)
end
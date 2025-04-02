function ui.showMapExpLevel()

  -- Get the areas in the map
  local mapTable = getAreaTable()
  mapTable["Default Area"] = nil
  mapTable["Underworld"] = nil
  
  cecho("\nRoom Name             Visited  Total     % Visited\n")
  for k,v in spairs(mapTable) do
    local roomCount = 0
    -- Count how many rooms we have visited in each area
    for num,area in pairs(ui.knownRooms) do
      if ui.knownRooms[num].area == k then
      roomCount = roomCount + 1
      end
    end
    local areaName = string.format("%-40s", k)
    local areaRooms = string.format("%4s", table.size(getAreaRooms(v)))
    local visitedRooms = string.format("%4s", roomCount)
    local visitedPercentage = string.sub(tostring((visitedRooms/areaRooms)*100),1,3)
    visitedPercentage = string.format("%3s", string.gsub(visitedPercentage, "%D", ""))
    cechoLink("<dark_green>"..areaName, [[ui.showUnvisitedRooms("]]..v..[[")]], string.trim(areaName).." - show rooms", true)
    cecho("<lime_green>"..visitedRooms.." <light_blue>/ <gold>"..areaRooms.."   <dodger_blue>"..visitedPercentage.." <grey>%")
    cechoPopup("<DimGray>  (Mark all)\n", {[[ui.markAreaVisited("]]..v..[[")]],[[ui.clearAreaVisited("]]..v..[[")]]}, {string.trim(areaName).." - mark area visited",string.trim(areaName).." - mark area not visited"}, true)
    
  end

  if getRoomArea(gmcp.Room.Info.num) then 
    cecho("\n\n<lime_green>Click here to ")
    cechoLink("<firebrick>highlight ", [[ui.highlightUnvisitedRooms(]]..getRoomArea(gmcp.Room.Info.num)..[[)]], "", true)
    cecho("<lime_green>or ")
    cechoLink("<light_blue>unhighlight ", [[ui.highlightUnvisitedRooms(]]..getRoomArea(gmcp.Room.Info.num)..[[,"unhighlight")]], "", true)
    cecho("<lime_green>unvisited rooms in <cyan>current area")
    cecho("\n<lime_green>or click an <cyan>area name<lime_green> to show unvisited rooms.\n\n")
  else
      cecho("\n<lime_green>Click an <cyan>area<lime_green> name to show unvisited rooms.\n\n")
  end

table.save(getMudletHomeDir().."/"..ui.packageName.."/ui.knownRooms.lua", ui.knownRooms)
end

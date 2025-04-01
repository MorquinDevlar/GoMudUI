ui.knownRooms = ui.knownRooms or {}

function ui.checkRooms()
if not gmcp.Room.Info then return end
if not getRoomArea(gmcp.Room.Info.num) then return end

local questNum
local shopName
local shopExists
local area = getRoomAreaName(getRoomArea(gmcp.Room.Info.num))

  
  if gmcp.Room.Info.quest ~= 0 then
    questNum = gmcp.Room.Info.quest
    else
    questNum = false
  end

  if gmcp.Room.Info.shop ~= "" then
    shopName = gmcp.Room.Info.shop
    shopExists = true
    else
    shopName = ""
    shopExists = false
  end
  
  ui.unHighLightRooms(gmcp.Room.Info.num)
  
  ui.knownRooms[gmcp.Room.Info.num] = ui.knownRooms[gmcp.Room.Info.num] or {}
  
  ui.knownRooms[gmcp.Room.Info.num].area = area
  ui.knownRooms[gmcp.Room.Info.num].quest = questNum
  ui.knownRooms[gmcp.Room.Info.num].shop = shopExists
  ui.knownRooms[gmcp.Room.Info.num].shopName = shopName
    
  if table.size(gmcp.Room.Contents) > 0 then
    ui.knownRooms[gmcp.Room.Info.num].contents = ui.knownRooms[gmcp.Room.Info.num].contents or {}
    for index,content in pairs(gmcp.Room.Contents) do
      if not table.contains(ui.knownRooms[gmcp.Room.Info.num], gmcp.Room.Contents[index].name) then
      table.insert(ui.knownRooms[gmcp.Room.Info.num].contents, gmcp.Room.Contents[index].name)
      end
    end
  end
--
end

--registerNamedEventHandler("ui","checkVisitedRooms","gmcp.Room.Info",
--  function()
--    ui.checkRooms("walking")
--  end
--)


function ui.clearVisitedRooms()
  for k,_ in pairs(ui.knownRooms) do
    if getRoomChar(k) == "X" then
      echo("Room: "..k.." Char: "..getRoomChar(k).."\n")
      setRoomChar(k,ui.knownRooms[k].roomCharBackup)
      centerview(mmp.currentroom)
    end
  end


end
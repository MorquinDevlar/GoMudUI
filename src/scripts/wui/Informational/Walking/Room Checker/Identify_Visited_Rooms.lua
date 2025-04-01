wui.knownRooms = wui.knownRooms or {}

function wui.checkRooms()
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
  
  wui.unHighLightRooms(gmcp.Room.Info.num)
  
  wui.knownRooms[gmcp.Room.Info.num] = wui.knownRooms[gmcp.Room.Info.num] or {}
  
  wui.knownRooms[gmcp.Room.Info.num].area = area
  wui.knownRooms[gmcp.Room.Info.num].quest = questNum
  wui.knownRooms[gmcp.Room.Info.num].shop = shopExists
  wui.knownRooms[gmcp.Room.Info.num].shopName = shopName
    
  if table.size(gmcp.Room.Contents) > 0 then
    wui.knownRooms[gmcp.Room.Info.num].contents = wui.knownRooms[gmcp.Room.Info.num].contents or {}
    for index,content in pairs(gmcp.Room.Contents) do
      if not table.contains(wui.knownRooms[gmcp.Room.Info.num], gmcp.Room.Contents[index].name) then
      table.insert(wui.knownRooms[gmcp.Room.Info.num].contents, gmcp.Room.Contents[index].name)
      end
    end
  end
--
end

--registerNamedEventHandler("wui","checkVisitedRooms","gmcp.Room.Info",
--  function()
--    wui.checkRooms("walking")
--  end
--)


function wui.clearVisitedRooms()
  for k,_ in pairs(wui.knownRooms) do
    if getRoomChar(k) == "X" then
      echo("Room: "..k.." Char: "..getRoomChar(k).."\n")
      setRoomChar(k,wui.knownRooms[k].roomCharBackup)
      centerview(mmp.currentroom)
    end
  end


end
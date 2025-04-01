function wui.displayUIMessage(message)
  cecho("\n<green>### <gold>Willowdale UI <white>: <grey>"..message)
end

function wui.resizeEvent( event, x, y)
  if not wui.mainWindowWidth then return end
  local fontWidth,fontHeight = calcFontSize(getFontSize("main"), getFont(main))
  if wui.left then 
    wui.mainWindowWidth = select(1,getMainWindowSize())-wui.left:get_width()-wui.right:get_width()
    local windowWrap = math.floor(wui.mainWindowWidth/fontWidth)
    setWindowWrap("main", windowWrap-5)
  end
  --echo("RESIZE EVENT: event="..event.." x="..x.." y="..y.."\n")
end

function wui.cleanNumbers(v)
  local fix = string.gsub(v, ",","")
  return fix
end

function wui.addNumberSeperator(v)
  local s = string.format("%d", math.floor(v))
  local pos = string.len(s) % 3
  local correctedNumber
  if pos == 0 then pos = 3 end
    if wui.settings.numberSystem == "eu" then
      correctedNumber =  string.sub(s, 1, pos) .. string.gsub(string.sub(s, pos+1), "(...)", ".%1")
    else
      correctedNumber =  string.sub(s, 1, pos) .. string.gsub(string.sub(s, pos+1), "(...)", ",%1")
    end
  return correctedNumber
end


function wui.fixName(s)
  local fix = string.gsub(string.gsub(string.gsub(string.gsub(string.lower(s)," ","_"),"'",""),"\"",""),",","")
  return fix
end

function wui.padAndTruncate(str)
  local str_padded = string.format("%2s", string.sub(str, 1, 2))
  return str_padded
end

function wui.titleCase(str)
    local buf = {}
    for word in string.gfind(str, "%S+") do          
        local first, rest = string.sub(word, 1, 1), string.sub(word, 2)
        table.insert(buf, string.upper(first) .. string.lower(rest))
    end    
    local title =  table.concat(buf, " ")
    return title
end

function wui.easyMapperStart()
  mmp.game = "willowdale"
  local areaName = wui.titleCase(string.gsub(gmcp.Room.Info.area, "_"," " ))
  local roomNum = gmcp.Room.Info.num
  expandAlias("mc on")
  expandAlias("rlc v"..roomNum.." 0 0 0")
  expandAlias("area add "..areaName)
  expandAlias("room area "..areaName)
end

function wui.showDebug()
  echo("\n")
  echo("Mudlet version: "..getMudletVersion("string"))
  echo("\n")
  echo("OS: "..wui.OSType.." Version: "..wui.OSVersion)
  local mainw, mainh = getMainWindowSize()
  echo("\n")
  echo("Window dimensions: "..mainw.."*"..mainh)
  echo("\n")
  local hasFont = getAvailableFonts()["JetBrains Mono NL"]
  if hasFont then
    echo("Font JetBrains Mono NL is available")
  else
    echo("Font JetBrains Mono NL is NOT available - using the "..getFont())
  end
  echo("\n")
  echo("Main font size: "..getFontSize("main"))
  echo("\n")
  local mainFontWidth, mainFontHeight = calcFontSize(getFontSize("main"), getFont(main))
  echo("Main font dimension: "..mainFontWidth.."*"..mainFontHeight)
  echo("\n")
  echo("Main console pixel width: "..wui.mainWindowWidth)
  echo("\n")
  echo("Main console char width: "..wui.mainWindowWidth/mainFontWidth)
  echo("\n")
  echo("Main console wrap: "..getWindowWrap("main"))
  echo("\n")
  echo("Left border: "..getBorderLeft().." - Right border: ".. getBorderRight().." - Top border: "..getBorderTop().." - Bottom Border: "..getBorderBottom())
  echo("\n")
  echo("Packages installed: ")
  echo("\n")
  for _,v in pairs(getPackages()) do echo(v.." ") end
  echo("\n")
  
end

function wui.mapDownloaded()
  if gmcp.Room == nil or gmcp.Room.Info == nil then return end
  if not centerview(gmcp.Room.Info.num) then
    wui.displayUIMessage("Sorry, you are in a room not on the map so we cannot place you there.\n")
  end
end


-- this is to split version numbers into tables
function wui.split_version(version)
    local t = {}
    for num in string.gmatch(version, "%d+") do
        table.insert(t, tonumber(num))
    end
    return t
end

-- Function to compare two version strings
function wui.compare_versions(v1, v2)
    local version1 = wui.split_version(v1)
    local version2 = wui.split_version(v2)
    
    -- Compare each part of the version number
    for i = 1, math.max(#version1, #version2) do
        local part1 = version1[i] or 0
        local part2 = version2[i] or 0
        
        if part1 > part2 then
            --return v1 .. " is newer"
            return true
        elseif part1 < part2 then
            --return v2 .. " is newer"
            return false  
        end
    end
    
    --return "Both versions are the same"
    return false
end


function wui.versions_behind(old_version, new_version)
    local old = wui.split_version(old_version)
    local new = wui.split_version(new_version)
    
    local difference = 0
    
    -- Compare each part of the version number
    for i = 1, math.max(#old, #new) do
        local part_old = old[i] or 0
        local part_new = new[i] or 0
        
        -- Add up the difference in each version part
        if part_old > part_new then
            difference = difference + (part_old - part_new)
        end
    end
    
    return difference
end
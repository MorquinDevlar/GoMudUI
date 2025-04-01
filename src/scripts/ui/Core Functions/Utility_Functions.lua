function ui.displayUIMessage(message)
  cecho("\n<green>### <gold>GoMud UI <white>: <grey>"..message)
end

function ui.resizeEvent( event, x, y)
  if not ui.mainWindowWidth then return end
  local fontWidth,fontHeight = calcFontSize(getFontSize("main"), getFont(main))
  if ui.left then 
    ui.mainWindowWidth = select(1,getMainWindowSize())-ui.left:get_width()-ui.right:get_width()
    local windowWrap = math.floor(ui.mainWindowWidth/fontWidth)
    setWindowWrap("main", windowWrap-5)
  end
  --echo("RESIZE EVENT: event="..event.." x="..x.." y="..y.."\n")
end

function ui.cleanNumbers(v)
  local fix = string.gsub(v, ",","")
  return fix
end

function ui.addNumberSeperator(v)
  local s = string.format("%d", math.floor(v))
  local pos = string.len(s) % 3
  local correctedNumber
  if pos == 0 then pos = 3 end
    if ui.settings.numberSystem == "eu" then
      correctedNumber =  string.sub(s, 1, pos) .. string.gsub(string.sub(s, pos+1), "(...)", ".%1")
    else
      correctedNumber =  string.sub(s, 1, pos) .. string.gsub(string.sub(s, pos+1), "(...)", ",%1")
    end
  return correctedNumber
end


function ui.fixName(s)
  local fix = string.gsub(string.gsub(string.gsub(string.gsub(string.lower(s)," ","_"),"'",""),"\"",""),",","")
  return fix
end

function ui.padAndTruncate(str)
  local str_padded = string.format("%2s", string.sub(str, 1, 2))
  return str_padded
end

function ui.titleCase(str)
    local buf = {}
    for word in string.gfind(str, "%S+") do          
        local first, rest = string.sub(word, 1, 1), string.sub(word, 2)
        table.insert(buf, string.upper(first) .. string.lower(rest))
    end    
    local title =  table.concat(buf, " ")
    return title
end

function ui.easyMapperStart()
  mmp.game = "gomud"
  local areaName = ui.titleCase(string.gsub(gmcp.Room.Info.area, "_"," " ))
  local roomNum = gmcp.Room.Info.num
  expandAlias("mc on")
  expandAlias("rlc v"..roomNum.." 0 0 0")
  expandAlias("area add "..areaName)
  expandAlias("room area "..areaName)
end

function ui.showDebug()
  echo("\n")
  echo("Mudlet version: "..getMudletVersion("string"))
  echo("\n")
  echo("OS: "..ui.OSType.." Version: "..ui.OSVersion)
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
  echo("Main console pixel width: "..ui.mainWindowWidth)
  echo("\n")
  echo("Main console char width: "..ui.mainWindowWidth/mainFontWidth)
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

function ui.mapDownloaded()
  if gmcp.Room == nil or gmcp.Room.Info == nil then return end
  if not centerview(gmcp.Room.Info.num) then
    ui.displayUIMessage("Sorry, you are in a room not on the map so we cannot place you there.\n")
  end
end


-- this is to split version numbers into tables
function ui.split_version(version)
    local t = {}
    for num in string.gmatch(version, "%d+") do
        table.insert(t, tonumber(num))
    end
    return t
end

-- Function to compare two version strings
function ui.compare_versions(v1, v2)
    local version1 = ui.split_version(v1)
    local version2 = ui.split_version(v2)
    
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


function ui.versions_behind(old_version, new_version)
    local old = ui.split_version(old_version)
    local new = ui.split_version(new_version)
    
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
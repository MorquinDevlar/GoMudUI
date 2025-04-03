function ui.displayUIMessage(message)
  if not message then return end
  cecho("\n<green>### <gold>GoMud UI <white>: <grey>"..message)
end

function ui.resizeEvent(event, x, y)
  if not ui.mainWindowWidth then return end
  local fontWidth, fontHeight = calcFontSize(getFontSize("main"), getFont(main))
  if ui.left then 
    ui.mainWindowWidth = select(1,getMainWindowSize())-ui.left:get_width()-ui.right:get_width()
    local windowWrap = math.floor(ui.mainWindowWidth/fontWidth)
    setWindowWrap("main", windowWrap-5)
  end
  --echo("RESIZE EVENT: event="..event.." x="..x.." y="..y.."\n")
end

function ui.cleanNumbers(v)
  if not v then return "0" end
  local separator = ui.settings.numberSystem == "eu" and "." or ","
  return string.gsub(v, separator, "")
end

function ui.addNumberSeparator(v)
  if not v then return "0" end
  local s = string.format("%d", math.floor(v))
  local pos = string.len(s) % 3
  if pos == 0 then pos = 3 end
  local separator = ui.settings.numberSystem == "eu" and "." or ","
  return string.sub(s, 1, pos) .. string.gsub(string.sub(s, pos+1), "(...)", separator.."%1")
end

function ui.fixName(s)
  if not s then return "" end
  return string.lower(string.gsub(s, "[ ,'\"]", "_"))
end

function ui.padAndTruncate(str, width)
  if not str then return string.rep(" ", width or 2) end
  width = width or 2
  return string.format("%"..width.."s", string.sub(str, 1, width))
end

function ui.titleCase(str)
  if not str then return "" end
  local buf = {}
  for word in string.gmatch(str, "%S+") do
    local first, rest = string.sub(word, 1, 1), string.sub(word, 2)
    table.insert(buf, string.upper(first) .. string.lower(rest))
  end
  return table.concat(buf, " ")
end

function ui.easyMapperStart()
  if not gmcp.Room or not gmcp.Room.Info then return end
  mmp.game = "gomud"
  local areaName = ui.titleCase(string.gsub(gmcp.Room.Info.area or "", "_"," " ))
  local roomNum = gmcp.Room.Info.num or "0"
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
  if not gmcp.Room or not gmcp.Room.Info then return end
  if not centerview(gmcp.Room.Info.num) then
    ui.displayUIMessage("Sorry, you are in room "..gmcp.Room.Info.num.." which is not on the map so we cannot place you there.\n")
  end
end

function ui.split_version(version)
  if not version then return {} end
  local t = {}
  for num in string.gmatch(version, "%d+") do
    table.insert(t, tonumber(num))
  end
  return t
end

function ui.compare_versions(v1, v2)
  if not v1 or not v2 then return false end
  local version1 = ui.split_version(v1)
  local version2 = ui.split_version(v2)
  
  for i = 1, math.max(#version1, #version2) do
    local part1 = version1[i] or 0
    local part2 = version2[i] or 0
    
    if part1 > part2 then
      return true
    elseif part1 < part2 then
      return false  
    end
  end
  
  return false
end

function ui.versions_behind(old_version, new_version)
  if not old_version or not new_version then return 0 end
  local old = ui.split_version(old_version)
  local new = ui.split_version(new_version)
  
  local difference = 0
  
  for i = 1, math.max(#old, #new) do
    local part_old = old[i] or 0
    local part_new = new[i] or 0
    
    if part_old > part_new then
      difference = difference + (part_old - part_new)
    end
  end
  
  return difference
end

function ui.parseTimestamp(timestamp)
  if not timestamp then return nil end
  local _, year, month, day, hour, min, sec = timestamp:match("(%w+), (%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
  
  if not year or not month or not day or not hour or not min or not sec then
    return nil
  end
  
  year, month, day = tonumber(year), tonumber(month), tonumber(day)
  hour, min, sec = tonumber(hour), tonumber(min), tonumber(sec)
  
  return {
    year = year,
    month = month,
    day = day,
    hour = hour,
    min = min,
    sec = sec
  }
end

function ui.getTimeElapsed(loginTimestamp)
  if not loginTimestamp then return "00H 00M 00S" end
  local loginTime = ui.parseTimestamp(loginTimestamp)
  if not loginTime then return "00H 00M 00S" end
  local loginUnix = os.time(loginTime)
  local currentUnix = os.time()
  local diffSeconds = currentUnix - loginUnix
  local hours = math.floor(diffSeconds / 3600)
  local minutes = math.floor((diffSeconds % 3600) / 60)
  local seconds = diffSeconds % 60
  return string.format("<gold>%02d<white>h <gold>%02d<white>m <gold>%02d<white>s", hours, minutes, seconds)
end
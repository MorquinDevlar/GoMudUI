-- internal sorting function, sorts first by hue, then luminosity, then value
local sortColorsByHue =
  function(lhs, rhs)
    local lh, ll, lv = unpack(lhs.sort)
    local rh, rl, rv = unpack(rhs.sort)
    if lh < rh then
      return true
    elseif lh > rh then
      return false
    elseif ll < rl then
      return true
    elseif ll > rl then
      return false
    else
      return lv < rv
    end
  end
-- internal sorting function, removes _ from snake_case and compares to camelCase
local sortColorsByName =
  function(a, b)
    local aname = string.gsub(string.lower(a.name), "_", "")
    local bname = string.gsub(string.lower(b.name), "_", "")
    return aname < bname
  end
-- internal function used to turn sorted colors table into columns
local chunkify =
  function(tbl, num_chunks)
    local pop =
      function(t)
        return table.remove(t, 1)
      end
    local tbl = table.deepcopy(tbl)
    local tblsize = #tbl
    local base_chunk_size = tblsize / num_chunks
    local chunky_chunks = tblsize % num_chunks
    local chunks = {}
    for i = 1, num_chunks do
      local chunk_size = base_chunk_size
      if i <= chunky_chunks then
        chunk_size = chunk_size + 1
      end
      local chunk = {}
      for j = 1, chunk_size do
        chunk[j] = pop(tbl)
      end
      chunks[i] = chunk
    end
    return chunks
  end
-- internal function, converts rgb to hsv
-- found at https://github.com/EmmanuelOga/columns/blob/master/utils/color.lua#L89
local rgbToHsv =
  function(r, g, b)
    r, g, b = r / 255, g / 255, b / 255
    local max, min = math.max(r, g, b), math.min(r, g, b)
    local h, s, v
    v = max
    local d = max - min
    if max == 0 then
      s = 0
    else
      s = d / max
    end
    if max == min then
      h = 0
      -- achromatic
    else
      if max == r then
        h = (g - b) / d
        if g < b then
          h = h + 6
        end
      elseif max == g then
        h = (b - r) / d + 2
      elseif max == b then
        h = (r - g) / d + 4
      end
      h = h / 6
    end
    return h, s, v
  end
-- internal stepping function, removes some of the noise for a more pleasing sort
-- cribbed from the python on https://www.alanzucconi.com/2015/09/30/colour-sorting/
local step =
  function(r, g, b)
    local lum = math.sqrt(.241 * r + .691 * g + .068 * b)
    local reps = 8
    local h, s, v = rgbToHsv(r, g, b)
    local h2 = math.floor(h * reps)
    local lum2 = math.floor(lum * reps)
    local v2 = math.floor(v * reps)
    if h2 % 2 == 1 then
      v2 = reps - v2
      lum2 = reps - lum2
    end
    return h2, lum2, v2
  end

local function calc_luminosity(r, g, b)
  r = r < 11 and r / (255 * 12.92) or ((0.055 + r / 255) / 1.055) ^ 2.4
  g = g < 11 and g / (255 * 12.92) or ((0.055 + g / 255) / 1.055) ^ 2.4
  b = b < 11 and b / (255 * 12.92) or ((0.055 + b / 255) / 1.055) ^ 2.4
  return (0.2126 * r) + (0.7152 * g) + (0.0722 * b)
end

local function include(color, options)
  if options.removeDupes then
    if string.find(color, "_") or string.find(color:lower(), 'gray') or string.find(color:lower(), 'ansi') then
      return false
    else
      return true
    end
  else
    if string.find(color, "ansi_%d%d%d") then
      return false
    else
      return true
    end
  end
end

local function echoColor(color, options)
  local rgb = color.rgb
  local fgc = "white"
  if calc_luminosity(unpack(rgb)) > 0.5 then
    fgc = "black"
  end
  local colorString
  if options.justText then
    colorString = string.format('<%s:%s> %-23s<reset> ', color.name, 'black', color.name, spacer)
  else
    colorString = string.format('<%s:%s> %-23s<reset> ', fgc, color.name, color.name)
  end
  if options.window == "main" then
    if options.echoOnly then
      cecho(colorString)
    else
      cechoLink(
        colorString,
        function() ui.settings[options.uiSetting] = color.name ui.addCSSToSettings() ui.createContainers() end,
        table.concat(rgb, ", "),
        true
      )
      
    end
  else
   if options.echoOnly then
      cecho(options.window, colorString)
    else
      cechoLink(
        options.window,
        colorString,
        function() ui.settings[options.uiSetting] = color.name ui.addCSSToSettings() ui.createContainers() end,
        table.concat(rgb, ", "),
        true
      )
      
    end
  end
end

function displayColors(options)
  local options = options or {}
  local optionsType = type(options)
  assert(
    optionsType == "table",
    "displayColors(options) argument error: options as table expects, got " .. optionsType
  )
  options.cols = options.cols or 4
  options.search = options.search or ""
  options.sort = options.sort or false
  if options.removeDupes == nil then
    options.removeDupes = true
  end
  if options.columnSort == nil then
    options.columnSort = true
  end
  if type(options.window) == "table" then
    options.window = options.window.name
  end
  options.window = options.window or "main"
  local color_table = options.color_table or color_table
  local cols, search, sort = options.cols, options.search, options.sort
  local colors = {}
  for k, v in pairs(color_table) do
    local color = {}
    color.rgb = v
    color.name = k
    color.sort = {step(unpack(v))}
    if include(k, options) and k:lower():find(search) then
      table.insert(colors, color)
    end
  end
  if sort then
    table.sort(colors, sortColorsByName)
  else
    table.sort(colors, sortColorsByHue)
  end
  if options.columnSort then
    local columns_table = chunkify(colors, cols)
    local lines = #columns_table[1]
    for i = 1, lines do
      for j = 1, cols do
        local color = columns_table[j][i]
        if color then
          echoColor(color, options)
        end
      end
      echo(options.window, "\n")
    end
  else
    local i = 1
    for _, k in ipairs(colors) do
      echoColor(k,options)
      if i == cols then
        echo(options.window, "\n")
        i = 1
      else
        i = i + 1
      end
    end
    if i ~= 1 then
      echo(options.window, "\n")
    end
  end
end
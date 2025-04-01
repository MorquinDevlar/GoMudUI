-- Define constants and helper functions outside the update function
ui.questStatusColor = ui.questStatusColor or {
  Undiscovered = "<red>",
  Discovered   = "<orange>",
  Finished     = "<green>",
  Unfinished   = "<cyan>",
  Started      = "<dodger_blue>",
}

local function getNames(tbl)
  local names = {}
  for _, entry in ipairs(tbl or {}) do
    names[#names + 1] = entry.name
  end
  return table.concat(names, ", ")
end

function ui.updateRoomDisplay()
  -- Cache frequently accessed tables
  local room = gmcp.Room
  if not (room and room.Info and room.Content) then return end
  
  local info    = room.Info
  local content = room.Content

  -- Cache and compute values once
  local room_features = (info.details and #info.details > 0) and table.concat(info.details, ", ") or "None"
  info.quest = info.quest or 0
  local width = math.floor(ui.roomDisplay:get_width() / ui.consoleFontWidth)
  
  ui.roomDisplay:clear("Room")
  
  -- Build and display header
  local header = fText.fText(
    "<white>[ <gold>Room<white>: " .. info.num .. " - " .. info.environment .. " <white>]<reset>",
    { alignment = "center", formatType = "c", width = width, cap = "", spacer = "-", inside = true, mirror = true }
  )
  ui.roomDisplay:cecho("Room", header .. "\n")
  
  -- Display area and features
  local area = ui.titleCase(string.gsub(info.area, "_", " "))
  ui.roomDisplay:cecho("Room", "<dodger_blue>Area<white>     : <reset>" .. area .. "\n")
  ui.roomDisplay:cecho("Room", "<dodger_blue>Features<white> : <reset>" .. room_features .. "\n")
  
  -- Display quest information
  if info.quest == 0 then
    ui.roomDisplay:cecho("Room", "<dodger_blue>Quest<white>    : <reset>None")
  else
    ui.roomDisplay:cecho("Room", "<dodger_blue>Quest<white>    : <gold>" .. info.quest .. " <white>(" .. ui.questStatusColor[info.queststatus] .. info.queststatus .. "<white>)\n")
    ui.roomDisplay:cecho("Room", "<dodger_blue>QName<white>    : <reset>")
    ui.roomDisplay:cechoLink("Room",
      "<reset>" .. [["<u>]] .. info.questname .. [[</u>"]],
      [[send("journal read ]] .. info.quest .. [[")]],
      "Read journal entry",
      true
    )
  end
  ui.roomDisplay:cecho("Room", "\n\n")
  
  -- Build lists from sub-tables
  local adventureList = getNames(content.Adventures)
  local npcList       = getNames(content.NPC)
  local itemList      = getNames(content.Items)
  
  -- Display lists
  ui.roomDisplay:cecho("Room", 
      "<ForestGreen>Adventurers<white>:<reset> " .. adventureList ..
      "\n<cyan>NPC's <white>:<reset> "     .. npcList ..
      "\n<green>Items <white>: <reset>"      .. itemList .. "\n\n"
  )
  
  -- Display personal notes
  ui.roomDisplay:cecho("Room", "<DodgerBlue>Personal notes<grey>: ui note <note>")
  local roomNote = ui.roomNotes[info.num]
  if roomNote then
    ui.roomDisplay:cecho("Room", "\n" .. "<gold>" .. roomNote.notes)
  end
end
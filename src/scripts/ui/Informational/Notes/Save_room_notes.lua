function ui.saveRoomNotes(note)
  ui.roomNotes = ui.roomNotes or {}
  
  if note == "clear" then
    ui.roomNotes[gmcp.Room.Info.num] = nil
    cecho("\n<DodgerBlue>Thank you!\n")
    cecho("\n<DodgerBlue>Room notes saved for room id <green>"..gmcp.Room.Info.num.." <DodgerBlue>have been cleared.\n\n")
  else
    ui.roomNotes[gmcp.Room.Info.num] = {notes = note}
    cecho("\n<DodgerBlue>Thank you!\n")
    cecho("\n<DodgerBlue>Room notes saved for room id <green>"..gmcp.Room.Info.num.."<white>: <gold>"..ui.roomNotes[gmcp.Room.Info.num].notes.."\n\n")
 
  end
 
  -- Save the notes table so we can use it later
  table.save(getMudletHomeDir().."/"..ui.packageName.."/ui.roomNotes.lua", ui.roomNotes)
  
  -- Once the note is saved, reload the room info
  ui.updateRoomDisplay()

end
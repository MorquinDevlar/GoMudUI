function wui.saveRoomNotes(note)
  wui.roomNotes = wui.roomNotes or {}
  
  if note == "clear" then
    wui.roomNotes[gmcp.Room.Info.num] = nil
    cecho("\n<DodgerBlue>Thank you!\n")
    cecho("\n<DodgerBlue>Room notes saved for room id <green>"..gmcp.Room.Info.num.." <DodgerBlue>have been cleared.\n\n")
  else
    wui.roomNotes[gmcp.Room.Info.num] = {notes = note}
    cecho("\n<DodgerBlue>Thank you!\n")
    cecho("\n<DodgerBlue>Room notes saved for room id <green>"..gmcp.Room.Info.num.."<white>: <gold>"..wui.roomNotes[gmcp.Room.Info.num].notes.."\n\n")
 
  end
 
  -- Save the notes table so we can use it later
  table.save(getMudletHomeDir().."/"..wui.packageName.."/wui.roomNotes.lua", wui.roomNotes)
  
  -- Once the note is saved, reload the room info
  wui.updateRoomDisplay()

end
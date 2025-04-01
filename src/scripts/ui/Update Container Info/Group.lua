function ui.updateGroupDisplay()
  ui.affectsDisplay:clear("Group")
  ui.affectsDisplay:cecho("Group", fText.fText("<white>[ <gold>Group Name<white>: <DodgerBlue>None <white>]<reset>", {alignment = "center", formatType = "c", width = math.floor(ui.roomDisplay:get_width()/ui.consoleFontWidth), cap = "", spacer = "-", inside = true, mirror = true}))
  ui.affectsDisplay:cecho("Group", "\n")
  ui.affectsDisplay:cecho("Group", "\n")
  ui.affectsDisplay:cecho("Group", "<reset>Once we have group information for the UI it will go here. Once we have group information for the UI it will go here. Once we have group information for the UI it will go here.")
end
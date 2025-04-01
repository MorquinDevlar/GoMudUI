function wui.updateGroupDisplay()
  wui.affectsDisplay:clear("Group")
  wui.affectsDisplay:cecho("Group", fText.fText("<white>[ <gold>Group Name<white>: <DodgerBlue>None <white>]<reset>", {alignment = "center", formatType = "c", width = math.floor(wui.roomDisplay:get_width()/wui.consoleFontWidth), cap = "", spacer = "-", inside = true, mirror = true}))
  wui.affectsDisplay:cecho("Group", "\n")
  wui.affectsDisplay:cecho("Group", "\n")
  wui.affectsDisplay:cecho("Group", "<reset>Once we have group information for the UI it will go here. Once we have group information for the UI it will go here. Once we have group information for the UI it will go here.")
end
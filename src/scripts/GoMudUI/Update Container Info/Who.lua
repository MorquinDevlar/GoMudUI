function ui.updateWhoDisplay()
--display(gmcp.Game)
if gmcp.Game == nil or gmcp.Game.Who == nil or gmcp.Game.Who.Players == nil then return end

  ui.charDisplay:clear("Wholist")
  ui.charDisplay:cecho("Wholist", fText.fText("<white>[ <gold>Online players<gold>: <white>"..#gmcp.Game.Who.Players.."<white> ]<reset>", {alignment = "center", formatType = "c", width = math.floor(ui.charDisplay:get_width()/ui.consoleFontWidth), cap = "", spacer = "-", inside = true, mirror = true}))
  ui.charDisplay:cecho("Wholist","\n")
  for k,v in ipairs(gmcp.Game.Who.Players) do
    if k == #gmcp.Game.Who.Players then
      ui.charDisplay:cecho("Wholist","<forest_green>"..gmcp.Game.Who.Players[k].name)
    else
      ui.charDisplay:cecho("Wholist","<forest_green>"..gmcp.Game.Who.Players[k].name..", ")
    end
  end
end
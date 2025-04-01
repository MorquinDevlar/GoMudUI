function wui.updateWhoDisplay()
--display(gmcp.Game)
if gmcp.Game == nil or gmcp.Game.Who == nil or gmcp.Game.Who.Players == nil then return end

  wui.charDisplay:clear("Wholist")
  wui.charDisplay:cecho("Wholist", fText.fText("<white>[ <gold>Online players<gold>: <white>"..#gmcp.Game.Who.Players.."<white> ]<reset>", {alignment = "center", formatType = "c", width = math.floor(wui.charDisplay:get_width()/wui.consoleFontWidth), cap = "", spacer = "-", inside = true, mirror = true}))
  wui.charDisplay:cecho("Wholist","\n")
  for k,v in ipairs(gmcp.Game.Who.Players) do
    if k == #gmcp.Game.Who.Players then
      wui.charDisplay:cecho("Wholist","<forest_green>"..gmcp.Game.Who.Players[k].name)
    else
      wui.charDisplay:cecho("Wholist","<forest_green>"..gmcp.Game.Who.Players[k].name..", ")
    end
  end
end
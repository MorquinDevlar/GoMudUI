function ui.updateChannelDisplay(eventName, ...)
  eventName = eventName or ""
  if eventName == "gmcp.Comm.Channel" then
    if gmcp.Comm == nil then return end
    if gmcp.Comm.Channel == nil then return end
    
    local senderColor
    
    if gmcp.Char.Info and gmcp.Comm.Channel.sender == gmcp.Char.Info.name then
      senderColor = "<gold>"
      else
      senderColor = "<sea_green>"
    end
    
     ui.channelColor = {
      chat = {
        channelName = "Chat",
        channelColor = "<dodger_blue>"
      },
      tell = {
        channelName = "Tell",
        channelColor = "<dark_violet>"},
      ["local"] = {
        channelName = "Local",
        channelColor = "<dark_green>"
      },
      group = {
        channelName = "Local",
        channelColor = "<dark_violet>"
      },
      guild = {
        channelName = "Guild",
        channelColor = "<red>"
      },
      shout = {
        channelName = "Shout",
        channelColor = "<gold>"
      },
      achievements = {
        channelName = "Misc",
        channelColor = "<magenta>"
      },
      events = {
        channelName = "Misc",
        channelColor = "<SeaGreen>"},
      logins = {
        channelName = "Misc",
        channelColor = "<magenta>"
      },
      deaths = {
        channelName = "Misc",
        channelColor = "<magenta>"
      },
     
    }
    
   -- Send chats to the right tab and with the right name and coloring
    
    local channel = gmcp.Comm.Channel.channel
    local cc = ui.channelColor[gmcp.Comm.Channel.channel].channelColor or "<reset>"
    local sender = gmcp.Comm.Channel.sender or "unknown"
    local tabName = {ui.channelColor[gmcp.Comm.Channel.channel].channelName,"All"}
    
    --local time = "\n"..getTime(true, "hh:mm ")
    
    local time = "\n".."<gold>"..getTime(true, "hh:mm ")
    local msg = gmcp.Comm.Channel.text
    
    for _,tab in ipairs(tabName) do
      if tab == "All" then
        ui.channelDisplay:cecho(tab, time.."<reset>("..cc..channel:title().."<reset>) "..senderColor..sender.."<reset>: "..gmcp.Comm.Channel.text)
      else
        ui.channelDisplay:cecho(tab, time..senderColor..sender..cc.."<reset>: "..gmcp.Comm.Channel.text)
      end
    end
  end
end
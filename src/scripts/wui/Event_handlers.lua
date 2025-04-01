wui = wui or {}
wui.events = wui.events or {}

-------------[ Set all the events for updating the player information ]-------------

function wui.defineEventHandlers()
  for k,v in pairs(wui.events.gmcpevents) do
    local functionRef
    for i,functionRef in pairs(v) do
      registerNamedEventHandler("wui", k.."-"..functionRef, k, functionRef)
    end
  end
end

function wui.killEventHandlers()
  for k,v in pairs(wui.events.gmcpevents) do
    local functionRef
    for i,functionRef in pairs(v) do
      deleteNamedEventHandler("wui", k.."-"..functionRef)
    end
  end
end
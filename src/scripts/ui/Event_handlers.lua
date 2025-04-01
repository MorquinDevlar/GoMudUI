ui = ui or {}
ui.events = ui.events or {}

-------------[ Set all the events for updating the player information ]-------------

function ui.defineEventHandlers()
  for k,v in pairs(ui.events.gmcpevents) do
    local functionRef
    for i,functionRef in pairs(v) do
      registerNamedEventHandler("ui", k.."-"..functionRef, k, functionRef)
    end
  end
end

function ui.killEventHandlers()
  for k,v in pairs(ui.events.gmcpevents) do
    local functionRef
    for i,functionRef in pairs(v) do
      deleteNamedEventHandler("ui", k.."-"..functionRef)
    end
  end
end
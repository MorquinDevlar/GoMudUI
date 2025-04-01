function wui.updateBalanceGauge()
  if gmcp.Char == nil or gmcp.Char.Balance == nil or gmcp.Char.Balance.unbalance == nil then
    wui.balGauge:setValue(100, 100, f"<center>Balanced</center>")
    return
  end
  --If gmcp information is availabe set the values, otherwise use dummy values.
  local bal = gmcp.Char.Balance.unbalance or 0
  local maxbal = gmcp.Char.Balance.max_unbalance or 0
  
  if tonumber(bal) ~= 0 then
    -- Update Balance
    local balance = maxbal-bal
      --if string.len(tostring(bal)) < 2 then
        --wui.balGauge:setValue(balance, maxbal, f"<center>"..math.floor(bal)..".0</center>")
      --else
        wui.balGauge:setValue(balance, maxbal, f"<center>"..bal.."</center>")
      --end    
  else
    wui.balGauge:setValue(100, 100, f"<center>Balanced</center>")
    -- Raise an event we can hook into if something needs to happen on regaining balance
    raiseEvent("wui.charBalanced")
  end
end
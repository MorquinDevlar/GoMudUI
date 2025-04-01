function wui.createPlayerGuages()
  
  -- Set all the styles needed for the gauges

  local gaugeBorder = "border-radius: 3px;border: 1px solid rgba(160, 160, 160, 50%);"

  wui.styles = {
    
    gaugeText = f[[{wui.cssFont} qproperty-alignment: 'AlignRight|AlignVCenter';]],
    
    HPGaugeFront = f[[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(150, 25, 25), stop: 0.1 rgb(180,0,0), stop: 0.85 rgb(155,0,0), stop: 1 rgb(130,0,0)); {gaugeBorder}]],
    HPGaugeBack = f[[background-color: rgb(60, 0, 0); {gaugeBorder}]],
    
    SPGaugeFront = f[[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(127, 0, 87), stop: 0.1 rgb(147, 0, 107), stop: 0.85 rgb(117, 0, 77), stop: 1 rgb(117, 0, 67)); {gaugeBorder}]],
    SPGaugeBack = f[[background-color: rgb(60, 0, 60); {gaugeBorder}]],
     
    balanceGaugeFront = f[[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(25, 25, 150), stop: 0.1 rgb(0,0,180), stop: 0.85 rgb(0,0,155), stop: 1 rgb(0,0,130)); {gaugeBorder}]],
    balanceGaugeBack = f[[background-color: rgb(0, 0, 60); {gaugeBorder}]],
    
    vitalsLabel = f[[font-weight: 400; padding-left: 2px; background-color: rgba(0,0,0,0%); {wui.settings.cssFont}]],
    balanceLabel = f[[font-weight: 200; qproperty-alignment: 'AlignRight|AlignVCenter'; background-color: rgba(0,0,0,0%); {wui.cssFont}]],
    
    enemyGaugeFront = f[[{wui.settings.cssFont} background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(150, 25, 25), stop: 0.1 rgb(180,0,0), stop: 0.85 rgb(155,0,0), stop: 1 rgb(130,0,0)); {gaugeBorder}]],
    enemyGaugeBack = f[[background-color: rgb(60, 0, 0); {gaugeBorder}]],
    
  }

  -- Create the HP guage
  wui.hpGauge = Geyser.Gauge:new({
  name="hpGauge",
  x = 10,
  y = 0,
  width= 250,
  height= 20,
  font = wui.settings.consoleFont,
  
  }, wui.gaugeDisplay)
  
  -- set the front and back styling for the guage
  wui.hpGauge.front:setStyleSheet(wui.styles.HPGaugeFront)
  wui.hpGauge.back:setStyleSheet(wui.styles.HPGaugeBack)
  
  -- Set the gauge text styling
  wui.hpGauge.text:setStyleSheet(wui.styles.gaugeText)
  wui.hpGauge.text:setFontSize(wui.settings.gaugeFontSize)
  
  -- Center the text on the gauge
  wui.hpGauge.text:echo(nil, "nocolor", "c")
  
  -- Set the label for the guage
  wui.hpLabel = Geyser.Label:new({
    name = "hpLabel",
    x = 5,
    y = 0,
    width = 250,
    height = 20,
    message = "HP",
  }, wui.hpGauge)
  
  wui.hpLabel:setStyleSheet(wui.styles.vitalsLabel)
  wui.hpLabel:setFontSize(wui.settings.gaugeFontSize)  
  
  
  -- Create the Mana guage
  wui.spGauge = Geyser.Gauge:new({
  name="spGauge",
  x = 10,
  y = 30,
  width = 250,
  height = 20,
  }, wui.gaugeDisplay)
  
  -- set the front and back styling for the guage
  wui.spGauge.front:setStyleSheet(wui.styles.SPGaugeFront)
  wui.spGauge.back:setStyleSheet(wui.styles.SPGaugeBack)
  
  -- Set the gauge text styling
  wui.spGauge.text:setStyleSheet(wui.styles.gaugeText)
  wui.spGauge.text:setFontSize(wui.settings.gaugeFontSize)
  
  -- Center the text on the gauge
  wui.spGauge.text:echo(nil, "nocolor", "c")
  
  -- Set the label for the guage
  wui.spLabel = Geyser.Label:new({
    name = "spLabel",
    x = 5,
    y = 0,
    width = 250,
    height = 20,
    message = "SP",
  }, wui.spGauge)
 
  wui.spLabel:setStyleSheet(wui.styles.vitalsLabel)
  wui.spLabel:setFontSize(wui.settings.gaugeFontSize)  
  
  -- Create the Balance guage
  wui.balGauge = Geyser.Gauge:new({
  name = "balGauge",
  x = 270,
  y = 30,
  width = 250,
  height = 20,
  }, wui.gaugeDisplay)
  
  -- set the front and back styling for the guage
  wui.balGauge.front:setStyleSheet(wui.styles.balanceGaugeFront)
  wui.balGauge.back:setStyleSheet(wui.styles.balanceGaugeBack)
  
  -- Set the gauge text styling
  wui.balGauge.text:setStyleSheet(wui.styles.gaugeText)
  wui.balGauge.text:setFontSize(wui.settings.gaugeFontSize)
  
  -- Center the text on the gauge
  wui.balGauge.text:echo(nil, "nocolor", "c")
  
  -- Create the Enemy HP guage
  wui.enemyGauge = Geyser.Gauge:new({
  name="enemyGauge",
  x = 270,
  y = 0,
  width = 250,
  height = 20,
  }, wui.gaugeDisplay)
  -- set the front styling for the Enemy HP guage
  wui.enemyGauge.front:setStyleSheet(wui.styles.enemyGaugeFront)
  -- set the back styling for the Enemy HP guage
  wui.enemyGauge.back:setStyleSheet(wui.styles.enemyGaugeBack)
  -- Set the gauge text styling
  wui.enemyGauge.text:setStyleSheet(wui.styles.gaugeText)
  wui.enemyGauge.text:setFontSize(wui.settings.gaugeFontSize)
  wui.enemyGauge.text:echo(nil, "nocolor", "c")

  
  -- Set the default label for the Enemy HP guage
  wui.enemyLabel = Geyser.Label:new({
    name = "enemyLabel",
    x = 5,
    y = 0,
    width = "100%",
    height = "100%",
  }, wui.enemyGauge)
  -- set the label background to be transparent
  wui.enemyLabel:setStyleSheet(wui.styles.vitalsLabel)
  wui.enemyLabel:setFontSize(wui.settings.gaugeFontSize)   
end
function ui.createPlayerGuages()
  
  -- Set all the styles needed for the gauges

  local gaugeBorder = "border-radius: 3px;border: 1px solid rgba(160, 160, 160, 50%);"

  ui.styles = {
    
    gaugeText = f[[{ui.cssFont} qproperty-alignment: 'AlignRight|AlignVCenter';]],
    
    HPGaugeFront = f[[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(150, 25, 25), stop: 0.1 rgb(180,0,0), stop: 0.85 rgb(155,0,0), stop: 1 rgb(130,0,0)); {gaugeBorder}]],
    HPGaugeBack = f[[background-color: rgb(60, 0, 0); {gaugeBorder}]],
    
    SPGaugeFront = f[[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(127, 0, 87), stop: 0.1 rgb(147, 0, 107), stop: 0.85 rgb(117, 0, 77), stop: 1 rgb(117, 0, 67)); {gaugeBorder}]],
    SPGaugeBack = f[[background-color: rgb(60, 0, 60); {gaugeBorder}]],
     
    balanceGaugeFront = f[[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(25, 25, 150), stop: 0.1 rgb(0,0,180), stop: 0.85 rgb(0,0,155), stop: 1 rgb(0,0,130)); {gaugeBorder}]],
    balanceGaugeBack = f[[background-color: rgb(0, 0, 60); {gaugeBorder}]],
    
    vitalsLabel = f[[font-weight: 400; padding-left: 2px; background-color: rgba(0,0,0,0%); {ui.settings.cssFont}]],
    balanceLabel = f[[font-weight: 200; qproperty-alignment: 'AlignRight|AlignVCenter'; background-color: rgba(0,0,0,0%); {ui.cssFont}]],
    
    enemyGaugeFront = f[[{ui.settings.cssFont} background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(150, 25, 25), stop: 0.1 rgb(180,0,0), stop: 0.85 rgb(155,0,0), stop: 1 rgb(130,0,0)); {gaugeBorder}]],
    enemyGaugeBack = f[[background-color: rgb(60, 0, 0); {gaugeBorder}]],
    
  }

  -- Create the HP guage
  ui.hpGauge = Geyser.Gauge:new({
  name="hpGauge",
  x = 10,
  y = 0,
  width= 250,
  height= 20,
  font = ui.settings.consoleFont,
  
  }, ui.gaugeDisplay)
  
  -- set the front and back styling for the guage
  ui.hpGauge.front:setStyleSheet(ui.styles.HPGaugeFront)
  ui.hpGauge.back:setStyleSheet(ui.styles.HPGaugeBack)
  
  -- Set the gauge text styling
  ui.hpGauge.text:setStyleSheet(ui.styles.gaugeText)
  ui.hpGauge.text:setFontSize(ui.settings.gaugeFontSize)
  
  -- Center the text on the gauge
  ui.hpGauge.text:echo(nil, "nocolor", "c")
  
  -- Set the label for the guage
  ui.hpLabel = Geyser.Label:new({
    name = "hpLabel",
    x = 5,
    y = 0,
    width = 250,
    height = 20,
    message = "HP",
  }, ui.hpGauge)
  
  ui.hpLabel:setStyleSheet(ui.styles.vitalsLabel)
  ui.hpLabel:setFontSize(ui.settings.gaugeFontSize)  
  
  
  -- Create the Mana guage
  ui.spGauge = Geyser.Gauge:new({
  name="spGauge",
  x = 10,
  y = 30,
  width = 250,
  height = 20,
  }, ui.gaugeDisplay)
  
  -- set the front and back styling for the guage
  ui.spGauge.front:setStyleSheet(ui.styles.SPGaugeFront)
  ui.spGauge.back:setStyleSheet(ui.styles.SPGaugeBack)
  
  -- Set the gauge text styling
  ui.spGauge.text:setStyleSheet(ui.styles.gaugeText)
  ui.spGauge.text:setFontSize(ui.settings.gaugeFontSize)
  
  -- Center the text on the gauge
  ui.spGauge.text:echo(nil, "nocolor", "c")
  
  -- Set the label for the guage
  ui.spLabel = Geyser.Label:new({
    name = "spLabel",
    x = 5,
    y = 0,
    width = 250,
    height = 20,
    message = "SP",
  }, ui.spGauge)
 
  ui.spLabel:setStyleSheet(ui.styles.vitalsLabel)
  ui.spLabel:setFontSize(ui.settings.gaugeFontSize)  
  
  -- Create the Balance guage
  ui.balGauge = Geyser.Gauge:new({
  name = "balGauge",
  x = 270,
  y = 30,
  width = 250,
  height = 20,
  }, ui.gaugeDisplay)
  
  -- set the front and back styling for the guage
  ui.balGauge.front:setStyleSheet(ui.styles.balanceGaugeFront)
  ui.balGauge.back:setStyleSheet(ui.styles.balanceGaugeBack)
  
  -- Set the gauge text styling
  ui.balGauge.text:setStyleSheet(ui.styles.gaugeText)
  ui.balGauge.text:setFontSize(ui.settings.gaugeFontSize)
  
  -- Center the text on the gauge
  ui.balGauge.text:echo(nil, "nocolor", "c")
  
  -- Create the Enemy HP guage
  ui.enemyGauge = Geyser.Gauge:new({
  name="enemyGauge",
  x = 270,
  y = 0,
  width = 250,
  height = 20,
  }, ui.gaugeDisplay)
  -- set the front styling for the Enemy HP guage
  ui.enemyGauge.front:setStyleSheet(ui.styles.enemyGaugeFront)
  -- set the back styling for the Enemy HP guage
  ui.enemyGauge.back:setStyleSheet(ui.styles.enemyGaugeBack)
  -- Set the gauge text styling
  ui.enemyGauge.text:setStyleSheet(ui.styles.gaugeText)
  ui.enemyGauge.text:setFontSize(ui.settings.gaugeFontSize)
  ui.enemyGauge.text:echo(nil, "nocolor", "c")

  
  -- Set the default label for the Enemy HP guage
  ui.enemyLabel = Geyser.Label:new({
    name = "enemyLabel",
    x = 5,
    y = 0,
    width = "100%",
    height = "100%",
  }, ui.enemyGauge)
  -- set the label background to be transparent
  ui.enemyLabel:setStyleSheet(ui.styles.vitalsLabel)
  ui.enemyLabel:setFontSize(ui.settings.gaugeFontSize)   
end
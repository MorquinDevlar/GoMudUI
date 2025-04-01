ui = ui or {}
ui.events = ui.events or {}

ui.roomNotes = ui.roomNotes or {}
ui.knownRooms = ui.knownRooms or {}

ui.settings = ui.settings or {}

ui.version = "1.4.5"
ui.packageName = "GoMudUI"

ui.OSType, ui.OSVersion = getOS()

-------------[ Check if the generic_mapper package is installed and if so uninstall it ]-------------
if table.contains(getPackages(),"generic_mapper") then
  tempTimer(1, function() uninstallPackage("generic_mapper") end)
end

-------------[ Add requred external packages ]-------------
EMCO = require("GoMudUI.emco")
fText = require("GoMudUI.ftext")
TableMaker = require("GoMudUI.ftext").TableMaker
DemonTools = require("GoMudUI.demontools")


-------------[ Define the event handlers we need for the UI ]-------------
ui.events.gmcpevents = {
sysInstallPackage = {"ui.postInstallHandling"},
sysUninstall = {"ui.unInstall"},
sysConnectionEvent = {"ui.connected"},
sysLoadEvent = {"ui.profileLoaded"},
UICreated = {"ui.updateDisplays"},
sysDownloadDone = {"ui.fileDownloadedSuccess"},
sysDownloadError = {"ui.fileDownloadedError"},
AdjustableContainerRepositionFinish = {"ui.updateDisplays"},
sysWindowResizeEvent = {"ui.resizeEvent"},
sysMapDownloadEvent = {"ui.mapDownloaded"},
["EMCO tab change"] = {"ui.showSettings"},
["gmcp.Char.Vitals"] = {"ui.updatePlayerGauges", "ui.updatePromptDisplay"},
["gmcp.Char.Balance"] = {"ui.updateBalanceGauge"},
["gmcp.Char.Enemies"] = {"ui.updateEnemyGauge"},
["gmcp.Char.Statuses"] = {"ui.updateAffectsDisplay","ui.updatePromptDisplay","ui.updatePromptRightDisplay"},
["gmcp.Char.Worth"] = {"ui.updatePromptDisplay", "ui.updateCharDisplay"},
["gmcp.Char"] = {"ui.updateCharDisplay"},
["gmcp.Char.Inventory"] = {"ui.updateEQDisplay", "ui.updatePromptDisplay", "ui.updateInvDisplay"},
["gmcp.Room"] = {"ui.updateRoomDisplay"},
["gmcp.Char.Stats"] = {"ui.updateCharDisplay"},
["gmcp.Comm.Channel"] = {"ui.updateChannelDisplay"},
["gmcp.Char.Enemies"] = {"ui.updateCombatDisplay", "ui.updateEnemyGauge"},
["gmcp.Room.Info"] = {"ui.checkRooms"},
["mmapper updated map"] = {"ui.updateTopBar"},
["gmcp.Game.Who"] = {"ui.updateWhoDisplay"},
["gmcp.Game.Info"] = {"ui.justLoggedIn"},


}
-- Run this to define the event handlers above
ui.defineEventHandlers()
 
function ui.createSettings()
  -- This needs to be set outside of settings, as it is being used inside it
  local noborderConsoleCSS = "background-color:rgba(15,15,15,100%);border-bottom: 0px solid rgba(15,15,15,100%);padding-top: 10px;"
  
  -------------[ Default variable settings for the UI package ]-------------
  ui.settings = {
    
    -- General UI variables
    consoleFont = "JetBrains Mono NL",
    mainFont = "JetBrains Mono NL",
    altFont = "Bitstream Vera Sans Mono",
    
    -- UI tab variables
    tabBarColor = "<15,15,15>",
    containerTitleTextColor = "black",
    activeTabBGColor = "DarkOliveGreen",
    activeTabFGColor = "white",
    inactiveTabFGColor = "white",
    inactiveTabBGColor = "DimGrey",
    tabHeight = 20,
    tabGap = 2,
  
    -- UI Font and window sizes
    tabFontSize = 12,
    consoleFontSize = 11,
    gaugeFontSize = 12,
    promptFontSize = 12,
    mainFontSize = 13,
    
    -- UI general color variables
    consoleBackgroundColor = "<15,15,15>",
    --consoleCSS = "background-color:rgba(50,50,50,100%);border-top: 2px solid rgba(15,15,15,100%);",
    leftCSS = "background-color:rgba(15,15,15,100%);border-right: 2px solid rgba(40,40,40,100%);",
    topCSS = "background-color:rgba(15,15,15,100%);border-bottom: 2px solid rgba(40,40,40,100%);",
    rightCSS = "background-color:rgba(15,15,15,100%);",
    bottomCSS = "background-color:rgba(15,15,15,100%);border-top: 2px solid rgba(40,40,40,100%);",
    moveableConsoleCSS = "background-color:rgba(15,15,15,100%);border-bottom: 2px solid rgba(40,40,40,100%);padding-top: 10px;",
    
    -- Define the containers we want to start with
    containers = {
      container1 = {  -- Char
        dest = "left",
        height = 12,
        y = 0
      }, 
      container2 = {  -- EQ
        dest = "left",
        height = 18,
        y = 12
      },
      container3 = {  -- Room
        dest = "left",
        height = 15,
        y = 40,
        customCSS = "background-color:rgba(15,15,15,100%);border-bottom: 0px solid rgba(15,15,15,100%);padding-top: 10px;"
      },
      container4 = {  -- Channel
        dest = "right",
        height = "50%",
        y = 0
      },
      container5 = {  -- Guages
        dest = "bottom",
        height = "50px",
        y = "-52px",
        customCSS = "background-color:rgba(15,15,15,100%);border-bottom: 0px solid rgba(15,15,15,100%);padding-top: 10px;",
        width = "530px"
      },
      container6 = {  -- Promt
        dest = "bottom",
        height = 3,
        y = 0,
        customCSS = "background-color:rgba(15,15,15,100%);border-bottom: 0px solid rgba(15,15,15,100%);padding-top: 10px;",
        fs = ""
      },
      container7 = {  -- Mapper
        dest = "right",
        height = "50%",
        y = "-50%"
      },
      container8 = {  -- Affects
        dest = "left",
        height = 10,
        y = 30
      },
      container9 = {  -- Prompt right side
        dest = "bottom",
        height = "50px",
        width = "150px",
        y = "-52px",
        customCSS = "background-color:rgba(15,15,15,100%);border-bottom: 0px solid rgba(200,15,15,100%);padding-top: 10px;",
        x = "540px"
      },
      container10 = { -- Top infobar
        dest = "top",
        height = 2,
        y = 0,
        customCSS = "background-color:rgba(15,15,15,100%);border-bottom: 0px solid rgba(15,15,15,100%);padding-top: 10px;"
      },
    },
    
    -- Define the displays we need
    
    displays = {
      charDisplay = {dest = "container1", emco = true, tabs = {"Character", "Wholist"}},
      eqDisplay = {dest = "container2", emco = true, tabs = {"Equipment","Inventory", "Pets"}},
      roomDisplay = {dest = "container3", emco = true, wrap = true, tabs = {"Room", "Combat"}},
      channelDisplay = {dest = "container4", emco = true, allTab = true, wrap = true, tabs = {"All", "Chat","Tell","Local","Misc","Group"}},
      gaugeDisplay = {dest = "container5"},
      promptDisplay = {dest = "container6"},
      mapperDisplay = {dest = "container7", emco = true, mapTab = "Mapper", tabs = {"Mapper", "Settings"}, mapper = true},
      affectsDisplay = {dest = "container8", emco = true, wrap = true, tabs = {"Affects", "Group"}},
      promptRightDisplay = {dest = "container9", wrap = true},
      topDisplay = {dest = "container10"},
    },
    
    -- Define user settings
    numberSystem = "eu",
    userToggles = {
      convinience = {
        numpadWalking = {
          desc = "Numberpad walking",
          state = true
        }
      },
      gagging = {
        balance = {
          desc = "Gag Balance Messages",
          state = false
        },
        blank = {
          desc = "Gag Blank Messages",
          state = false
        },
        prompt = {
          desc = "Gag prompt",
          state = false
        }
      }
    }
    
  }
  ui.addCSSToSettings()
  ui.osChanges()
  enableKey("Numpad Walking")
  ui.setFonts()
  table.save(getMudletHomeDir().."/"..ui.packageName.."/ui.settings.lua", ui.settings)
end

function ui.addCSSToSettings()
  -- Define CSS for containers. Has to happen after defining ui.settings as we need values from settings including any custom ones
  ui.settings.activeTab = f([[color: white; background-color: ]]..ui.settings.activeTabBGColor..[[;border-width: 0px; margin-right: 2px; margin-bottom: 2px;border-style: solid; border-color: black;border-top-left-radius: 10px;border-top-right-radius: 10px;]])
  ui.settings.inactiveTab = f([[color: white; background-color: ]]..ui.settings.inactiveTabBGColor..[[;border-width: 0px; margin-right: 2px; margin-bottom: 2px;border-style: solid; border-color: black;border-top-left-radius: 10px;border-top-right-radius: 10px;]])
  ui.settings.cssFont = "font-family: '"..f(ui.settings.consoleFont).."', sans serif;color: white;"
  ui.settings.containers.container6.fs = ui.settings.promptFontSize
end

function ui.osChanges()
  if ui.OSType == "windows" then
    ui.settings.tabFontSize = 12
    ui.settings.consoleFontSize = 10
    ui.settings.gaugeFontSize = 10
    ui.settings.promptFontSize = 10
    ui.settings.tabHeight = 25
  end
  
end

function ui.setFonts()
  setFont("main", ui.settings.mainFont)
  setFontSize("main", ui.settings.mainFontSize)
end

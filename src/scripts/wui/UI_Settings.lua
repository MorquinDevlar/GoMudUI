wui = wui or {}
wui.events = wui.events or {}

wui.roomNotes = wui.roomNotes or {}
wui.knownRooms = wui.knownRooms or {}

wui.settings = wui.settings or {}

wui.version = "1.4.5"
wui.packageName = "WillowdaleUI"

wui.OSType, wui.OSVersion = getOS()

-------------[ Check if the generic_mapper package is installed and if so uninstall it ]-------------
if table.contains(getPackages(),"generic_mapper") then
  tempTimer(1, function() uninstallPackage("generic_mapper") end)
end

-------------[ Add requred external packages ]-------------
EMCO = require("WillowdaleUI.emco")
fText = require("WillowdaleUI.ftext")
TableMaker = require("WillowdaleUI.ftext").TableMaker
DemonTools = require("WillowdaleUI.demontools")


-------------[ Define the event handlers we need for the UI ]-------------
wui.events.gmcpevents = {
sysInstallPackage = {"wui.postInstallHandling"},
sysUninstall = {"wui.unInstall"},
sysConnectionEvent = {"wui.connected"},
sysLoadEvent = {"wui.profileLoaded"},
UICreated = {"wui.updateDisplays"},
sysDownloadDone = {"wui.fileDownloadedSuccess"},
sysDownloadError = {"wui.fileDownloadedError"},
AdjustableContainerRepositionFinish = {"wui.updateDisplays"},
sysWindowResizeEvent = {"wui.resizeEvent"},
sysMapDownloadEvent = {"wui.mapDownloaded"},
["EMCO tab change"] = {"wui.showSettings"},
["gmcp.Char.Vitals"] = {"wui.updatePlayerGauges", "wui.updatePromptDisplay"},
["gmcp.Char.Balance"] = {"wui.updateBalanceGauge"},
["gmcp.Char.Enemies"] = {"wui.updateEnemyGauge"},
["gmcp.Char.Statuses"] = {"wui.updateAffectsDisplay","wui.updatePromptDisplay","wui.updatePromptRightDisplay"},
["gmcp.Char.Worth"] = {"wui.updatePromptDisplay", "wui.updateCharDisplay"},
["gmcp.Char"] = {"wui.updateCharDisplay"},
["gmcp.Char.Inventory"] = {"wui.updateEQDisplay", "wui.updatePromptDisplay", "wui.updateInvDisplay"},
["gmcp.Room"] = {"wui.updateRoomDisplay"},
["gmcp.Char.Stats"] = {"wui.updateCharDisplay"},
["gmcp.Comm.Channel"] = {"wui.updateChannelDisplay"},
["gmcp.Char.Enemies"] = {"wui.updateCombatDisplay", "wui.updateEnemyGauge"},
["gmcp.Room.Info"] = {"wui.checkRooms"},
["mmapper updated map"] = {"wui.updateTopBar"},
["gmcp.Game.Who"] = {"wui.updateWhoDisplay"},
["gmcp.Game.Info"] = {"wui.justLoggedIn"},


}
-- Run this to define the event handlers above
wui.defineEventHandlers()
 
function wui.createSettings()
  -- This needs to be set outside of settings, as it is being used inside it
  local noborderConsoleCSS = "background-color:rgba(15,15,15,100%);border-bottom: 0px solid rgba(15,15,15,100%);padding-top: 10px;"
  
  -------------[ Default variable settings for the UI package ]-------------
  wui.settings = {
    
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
  wui.addCSSToSettings()
  wui.osChanges()
  enableKey("Numpad Walking")
  wui.setFonts()
  table.save(getMudletHomeDir().."/"..wui.packageName.."/wui.settings.lua", wui.settings)
end

function wui.addCSSToSettings()
  -- Define CSS for containers. Has to happen after defining wui.settings as we need values from settings including any custom ones
  wui.settings.activeTab = f([[color: white; background-color: ]]..wui.settings.activeTabBGColor..[[;border-width: 0px; margin-right: 2px; margin-bottom: 2px;border-style: solid; border-color: black;border-top-left-radius: 10px;border-top-right-radius: 10px;]])
  wui.settings.inactiveTab = f([[color: white; background-color: ]]..wui.settings.inactiveTabBGColor..[[;border-width: 0px; margin-right: 2px; margin-bottom: 2px;border-style: solid; border-color: black;border-top-left-radius: 10px;border-top-right-radius: 10px;]])
  wui.settings.cssFont = "font-family: '"..f(wui.settings.consoleFont).."', sans serif;color: white;"
  wui.settings.containers.container6.fs = wui.settings.promptFontSize
end

function wui.osChanges()
  if wui.OSType == "windows" then
    wui.settings.tabFontSize = 12
    wui.settings.consoleFontSize = 10
    wui.settings.gaugeFontSize = 10
    wui.settings.promptFontSize = 10
    wui.settings.tabHeight = 25
  end
  
end

function wui.setFonts()
  setFont("main", wui.settings.mainFont)
  setFontSize("main", wui.settings.mainFontSize)
end

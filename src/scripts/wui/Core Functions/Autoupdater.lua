wui.downloadFolder = getMudletHomeDir().."/"..wui.packageName.."/wui_updater/"


-- Install the new UI
function wui.installWillowdaleUI()
  wui.displayUIMessage("Now installing version <sky_blue>"..wui.versionNew.."<reset> of Willowdale UI")
  
    wui.isUpdating = true
    uninstallPackage("WillowdaleUI")
    wui.postInstallDone = false
    wui.firstRun = true
    installPackage("https://play.willowdalemud.com/static/website/ui/WillowdaleUI.mpackage")
end


-- This function is running on a timer and also every time the client starts.
function wui.checkForUpdate()
  if not lfs.attributes(wui.downloadFolder) then
      if lfs and lfs.mkdir then
        local t, s = lfs.mkdir(wui.downloadFolder)
        if not t and s ~= "File exists" then
          echo("Could not make the '" .. wui.downloadFolder .. "' folder; " .. s)
          return
        end
      else
        echo(
          "Sorry, but you need LuaFileSystem (lfs) installed, or have the '" ..
          wui.downloadFolder ..
          "' folder exist."
        )
        return
      end
  end
  wui.willowdaleUIVersionFile = wui.downloadFolder .. "version"
  downloadFile(wui.willowdaleUIVersionFile, "https://play.willowdalemud.com/static/website/ui/version.txt")
end

-- Fetch the changelog is the UI package was updated
function wui.fetchChangeLog()
  wui.willowdaleUIChangelogFile = wui.downloadFolder .. "changelog"
  downloadFile(wui.willowdaleUIChangelogFile, "https://play.willowdalemud.com/static/website/ui/changelog.txt")
end

function wui.fileDownloadedSuccess(_, filename)
       
  if not io.exists(filename) then return end
  
  
  -- Show the version and let the user know if they are behind
  if filename == tostring(wui.willowdaleUIVersionFile) then
    --wui.displayUIMessage("File downloaded: "..filename)
    local file, content = io.open(filename)
    if file then content = file:read("*l"):trim(); io.close(file) end
    
    if wui.compare_versions(content, wui.version) then
      wui.versionNew = content
      wui.versionBehind = wui.versions_behind(wui.versionNew, wui.version)
      
      wui.displayUIMessage("<magenta>Update found: <sky_blue>"..wui.version.."<reset> -> <spring_green>"..wui.versionNew)
      wui.displayUIMessage("You are <orange>"..wui.versionBehind.."<reset> version(s) behind")
      wui.fetchChangeLog()
      wui.displayUIMessage("Use the in game command <ui install> to update")
    elseif wui.manualUpdate then
      wui.displayUIMessage("\n<magenta>No update found. You are on version: <sky_blue>"..wui.version.."\n")
      wui.manualUpdate = false
    end
    
  end
  
  -- If the changelog was downloaded, show what was changed
  if filename == tostring(wui.willowdaleUIChangelogFile) then
    --wui.displayUIMessage("File downloaded: "..filename)
    local file, content = io.open(filename)
    if file then content = file:read("*a"); io.close(file) end
      
    -- Shamelessly stolen from the IRE mapper package
    
    -- make environment
    local env = {} -- add functions you know are safe here
    -- run code under environment [Lua 5.1]
    local function run(untrusted_code)
      if untrusted_code:byte(1) == 27 then return nil, "binary bytecode prohibited" end
      local untrusted_function, message = loadstring(untrusted_code)
      if not untrusted_function then return nil, message end
      setfenv(untrusted_function, env)
      return pcall(untrusted_function)
    end
    run(content)
    -- Stealing from IRE over :)
    
    wui.willowdaleUIChangelog = env.changelog
    wui.displayUIMessage("<grey>Lastes Willowdale UI update:<DarkSeaGreen>")
    cechoLink(" <dodger_blue><u>Show the full changelog</u>", [[wui.willowdaleUIShowFullChangelog()]], "Click to see the full changelog", true)
    cecho("<DarkSeaGreen> \n\n"..wui.willowdaleUIChangelog[#wui.willowdaleUIChangelog])
    cechoLink("\n\n<green>### <gold>Willowdale UI <white>: <dodger_blue><u>Click here to update to the latest version!</u>\n", [[wui.installWillowdaleUI()]], "Install new version of Willowdale UI", true)
    wui.displayUIMessage("Or use the command <green>wui update ui<grey> to update.")
  end
  
end

function wui.willowdaleUIShowFullChangelog()
  for k, v in ipairs(wui.willowdaleUIChangelog) do
    cecho(string.format("  %s) %s\n", k, v:gsub("\t", "     ")))
  end
end

function wui.fileDownloadedError(...)
  debugc{...}
end
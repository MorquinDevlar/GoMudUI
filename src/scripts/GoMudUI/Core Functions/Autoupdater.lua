-- Install the new UI
function ui.installGoMudUI()
  
  ui.displayUIMessage("Now installing version <sky_blue>"..ui.versionNew.."<reset> of GoMud UI")
  
    ui.isUpdating = true
    uninstallPackage("GoMudUI")
    ui.postInstallDone = false
    ui.firstRun = true
    installPackage("http://localhost/static/website/ui/GoMudUI.mpackage")
end


-- This function is running on a timer and also every time the client starts.
function ui.checkForUpdate()
  if not lfs.attributes(ui.downloadFolder) then
      if lfs and lfs.mkdir then
        local t, s = lfs.mkdir(ui.downloadFolder)
        if not t and s ~= "File exists" then
          echo("Could not make the '" .. ui.downloadFolder .. "' folder; " .. s)
          return
        end
      else
        echo(
          "Sorry, but you need LuaFileSystem (lfs) installed, or have the '" ..
          ui.downloadFolder ..
          "' folder exist."
        )
        return
      end
  end
  ui.gomudUIVersionFile = ui.downloadFolder .. "version"
  downloadFile(ui.gomudUIVersionFile, "http://localhost/static/ui/version.txt")
end

-- Fetch the changelog is the UI package was updated
function ui.fetchChangeLog()
  ui.gomudUIChangelogFile = ui.downloadFolder .. "changelog"
  downloadFile(ui.gomudUIChangelogFile, "http://localhost/static/ui/changelog.txt")
end

function ui.fileDownloadedSuccess(_, filename)
       
  if not io.exists(filename) then return end
  
  
  -- Show the version and let the user know if they are behind
  if filename == tostring(ui.gomudUIVersionFile) then
    --ui.displayUIMessage("File downloaded: "..filename)
    local file, content = io.open(filename)
    if file then content = file:read("*l"):trim(); io.close(file) end
    
    if ui.compare_versions(content, ui.version) then
      ui.versionNew = content
      ui.versionBehind = ui.versions_behind(ui.versionNew, ui.version)
      
      ui.displayUIMessage("<magenta>Update found: <sky_blue>"..ui.version.."<reset> -> <spring_green>"..ui.versionNew)
      ui.displayUIMessage("You are <orange>"..ui.versionBehind.."<reset> version(s) behind")
      ui.fetchChangeLog()
      ui.displayUIMessage("Use the in game command <ui install> to update")
    elseif ui.manualUpdate then
      ui.displayUIMessage("\n<magenta>No update found. You are on version: <sky_blue>"..ui.version.."\n")
      ui.manualUpdate = false
    end
    
  end
  
  -- If the changelog was downloaded, show what was changed
  if filename == tostring(ui.gomudUIChangelogFile) then
    --ui.displayUIMessage("File downloaded: "..filename)
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
    
    ui.gomudUIChangelog = env.changelog
    ui.displayUIMessage("<grey>Lastes GoMud UI update:<DarkSeaGreen>")
    cechoLink(" <dodger_blue><u>Show the full changelog</u>", [[ui.gomudUIShowFullChangelog()]], "Click to see the full changelog", true)
    cecho("<DarkSeaGreen> \n\n"..ui.gomudUIChangelog[#ui.gomudUIChangelog])
    cechoLink("\n\n<green>### <gold>GoMud UI <white>: <dodger_blue><u>Click here to update to the latest version!</u>\n", [[ui.installGoMudUI()]], "Install new version of GoMud UI", true)
    ui.displayUIMessage("Or use the command <green>ui update ui<grey> to update.")
  end

end

function ui.gomudUIShowFullChangelog()
  for k, v in ipairs(ui.gomudUIChangelog) do
    cecho(string.format("  %s) %s\n", k, v:gsub("\t", "     ")))
  end
end

function ui.fileDownloadedError(...)
  debugc{...}
end
-- Switch to the next empty space
function switchToEmptySpace()
  local currentSpaceID = hs.execute("defaults read com.apple.spaces currentSpace")
  if currentSpaceID == "false" then
    currentSpaceID = 1
  else
    currentSpaceID = tonumber(currentSpaceID) or 1
  end

  local nextSpaceID = currentSpaceID + 1
  local visibleWindows = hs.execute("wmctl -l -x")

  while nextSpaceID <= 100 do -- assuming no more than 100 spaces
    local spaceIsEmpty = true
    for line in visibleWindows:gmatch("[^\r\n]+") do
      local fields = {}
      for field in line:gmatch("%S+") do
        table.insert(fields, field)
      end
      if tonumber(fields[2]) == nextSpaceID then
        spaceIsEmpty = false
        break
      end
    end
    if spaceIsEmpty then
      hs.osascript.applescript([[
                tell application "System Events"
                    key code 18 using {control down} -- Switch to Mission Control
                    delay 0.5 -- Delay to ensure Mission Control is activated
                    key code 124 -- Right arrow key to switch to the next space
                end tell
            ]])
      return
    end
    nextSpaceID = nextSpaceID + 1
  end
end

-- Bind a hotkey to switch to the next empty space
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "n", switchToEmptySpace)

-- hs.hotkey.bind({ "shift", "ctrl" }, "x", function()
--  hs.application.launchOrFocus("Wezterm")
-- end)
-- hs.hotkey.bind({}, "F2", function()
-- hs.hotkey.bind({ "shift", "ctrl" }, "x", function()
--   wez = hs.application.find("Wezterm")
--   if wez then
--     if wez:isFrontmost() then
--       wez:hide()
--     else
--       wez:activate()
--     end
--   end
-- end)

-- hs.hotkey.bind({ "shift", "ctrl" }, "x", function()
--   wez = hs.application.find("Wezterm")
--   if wez then
--     if wez:isFrontmost() then
--       wez:hide()
--     else
--       local nowspace = hs.spaces.focusedSpace()
--       local screen = hs.screen.mainScreen()
--       wez_window = wez:mainWindow()
--       hs.spaces.moveWindowToSpace(wez_window, nowspace)
--       local max = screen:fullFrame()
--       local f = wez_window:frame()
--       f.x = max.x
--       f.y = max.y
--       f.w = max.w
--       f.h = max.h * 0.75
--       hs.timer.doAfter(0.2, function()
--         wez_window:setFrame(f)
--       end)
--       wez_window:focus()
--     end
--   end
-- end)


-- quake mode for everything
function BindHotkey(appName, key, sizepct)
  -- hs.hotkey.bind({ "Alt" }, key, function()
  hs.hotkey.bind({ "shift", "ctrl" }, key, function()
    local app = hs.application.find(appName)
    if app then
      if app:isFrontmost() then
        app:hide()
      else
        local nowspace = hs.spaces.focusedSpace()
        local screen = hs.screen.mainScreen()
        local app_window = app:mainWindow()
        hs.spaces.moveWindowToSpace(app_window, nowspace)
        local max = screen:fullFrame()
        local f = app_window:frame()
        f.x = max.x
        f.y = max.y
        f.w = max.w
        -- f.h = max.h
        f.h = max.h * sizepct
        hs.timer.doAfter(0.2, function()
          app_window:setFrame(f)
        end)
        app_window:focus()
      end
    end
  end)
end

BindHotkey("Wezterm", "x", 0.75)
BindHotkey("Alacritty", "a", 0.75)
BindHotkey("Chrome", "c", 1)
BindHotkey("Arc", "s", 1)

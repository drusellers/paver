-- drusellers's Hammerspoon Configuration

hyper = {"cmd","alt","ctrl","shift"}

hs.hotkey.bind(hyper, "\\", function()
  hs.reload()
end)

hs.window.animationDuration = 0

-- Application direct hotkeys

local apps = {
  -- q = 'Rider.app',
  -- w = 'Microsoft Teams',
  -- e = 'Sublime Text',
  -- r = 'Messages',
  -- s = 'Telegram',
  h = 'iTerm',
  t = 'Things',
  -- z = 'Sublime Merge',
  -- x = 'Notes',
  -- c = 'Discord',
  -- v = 'Brave Browser.app',
  b = 'Google Chrome'
}

for key, app in pairs(apps) do
  hs.hotkey.bind(hyper, key, function()
    hs.application.launchOrFocus(app)
  end)
end

hs.hints.hintChars = { 'a', 's', 'd', 'f', 'g', 'q', 'w', 'e', 'r', 't', 'x', 'c', 'v', 'b', 'n' }

hs.hotkey.bind(hyper, "g", function()
  hs.hints.windowHints()
end)

-- Application direct hotkeys with menu selection for specific window

-- hs.hotkey.bind(hyper, "N", function()
--   hs.application.get("Microsoft Outlook"):selectMenuItem({"View", "Go To", "Calendar"})
--   hs.application.launchOrFocus("Microsoft Outlook")
-- end)

-- hs.hotkey.bind(hyper, "M", function()
--   hs.application.get("Microsoft Outlook"):selectMenuItem({"View", "Go To", "Mail"})
--   hs.application.launchOrFocus("Microsoft Outlook")
-- end)

-- WebEx is weird, two windows same title, annoying, so special handling required

function findApplication(appPath)
  local apps = hs.application.runningApplications()
  for i = 1, #apps do
    local app = apps[i]
    if app:path() and string.find(app:path(), appPath) then
      return app
    end
  end

  return nil
end

-- hs.hotkey.bind(hyper, "y", function()
--   local app = findApplication('Meeting Center.app')
--     if app then
--       hs.application.launchOrFocus('Meeting Center.app')
--     end
-- end)

-- screen zones are based upon the full screen window rectangle

local zones = {
  full        = function(fs) return hs.geometry(fs) end,
  middle      = function(fs) return hs.geometry(fs.x + 280,        fs.y, fs.w - 660,       fs.h) end,
  LeftMost    = function(fs) return hs.geometry(fs.x,              fs.y, fs.w - 380,       fs.h) end,
  rightMost   = function(fs) return hs.geometry(fs.x + 660,        fs.y, fs.w - 660,       fs.h) end,
  leftLess    = function(fs) return hs.geometry(fs.x,              fs.y, (fs.w - 380) / 2, fs.h) end,
  rightLess   = function(fs) return hs.geometry(fs.x +(fs.w-380)/2,fs.y, (fs.w - 380) / 2, fs.h) end,
  topCorner   = function(fs) return hs.geometry(fs.x +(fs.w/2)-380,fs.y, fs.w / 2,         fs.h / 2) end,
  leftHalf    = function(fs) return hs.geometry(fs.x,              fs.y, fs.w / 2,         fs.h) end,
  rightHalf   = function(fs) return hs.geometry(fs.x + fs.w / 2,   fs.y, fs.w / 2,         fs.h) end,
  column1     = function(fs) return hs.geometry(fs.x,              fs.y, 660,              fs.h) end,
  column2     = function(fs) return hs.geometry(fs.x + 280,        fs.y, (fs.w - 560) / 2, fs.h) end,
  column3     = function(fs) return hs.geometry(fs.x + 660,        fs.y, fs.w - 380 - 660, fs.h) end,
  column4     = function(fs) return hs.geometry(fs.x + fs.w / 2,   fs.y, (fs.w - 560) / 2, fs.h) end,
  column5     = function(fs) return hs.geometry(fs.x + fs.w - 380, fs.y, 380,              fs.h) end,
  hd          = function(fs) return hs.geometry(fs.x+(fs.w-1920)/2,fs.y, 1920,             1080) end,
  leftHd      = function(fs) return hs.geometry(fs.x+(fs.w-1920)/2,fs.y, 960,              1080) end,
  rightHd     = function(fs) return hs.geometry(fs.x+fs.w/2,       fs.y, 960,              1080) end,
  obs         = function(fs) return hs.geometry(fs.x,              fs.y, 1920,             1080) end
}

function moveWindow(win,zone)
  local frame = win:screen():frame()
  win:setFrame(zones[zone](frame))
end

-- standard layout based upon the current screen rectangle

function applyLayout(s)
  local fs = s:frame()
  local title = s:name()

  print("Applying Layout: ", fs.w)

  local layout
  if fs.w <= 1920 then
    layout = {
      {"Google Chrome",   nil, title, nil, function() return zones["middle"](fs) end, nil},
      {"Discord",         nil, title, nil, function() return zones["leftHalf"](fs) end, nil},
      {"Microsoft Teams", nil, title, nil, function() return zones["leftHalf"](fs) end, nil},
      {"Sublime Merge",   nil, title, nil, function() return zones["middle"](fs) end, nil},
      {"Sublime Text",    nil, title, nil, function() return zones["middle"](fs) end, nil},
      {"Messages",        nil, title, nil, function() return zones["column1"](fs) end, nil},
      {"Notes",           nil, title, nil, function() return zones["rightLess"](fs) end, nil},
      {"iTerm2",          nil, title, nil, function() return zones["middle"](fs) end, nil},
      {"Telegram",        nil, title, nil, function() return zones["column5"](fs) end, nil},
    }
  else
    layout = {
      {"Google Chrome",   nil, title, nil, function() return zones["middle"](fs) end, nil},
      {"Discord",         nil, title, nil, function() return zones["leftLess"](fs) end, nil},
      {"Microsoft Teams", nil, title, nil, function() return zones["leftLess"](fs) end, nil},
      {"Sublime Merge",   nil, title, nil, function() return zones["middle"](fs) end, nil},
      {"Sublime Text",    nil, title, nil, function() return zones["column3"](fs) end, nil},
      {"Messages",        nil, title, nil, function() return zones["column1"](fs) end, nil},
      {"Notes",           nil, title, nil, function() return zones["rightLess"](fs) end, nil},
      {"iTerm2",          nil, title, nil, function() return zones["rightLess"](fs) end, nil},
      {"Telegram",        nil, title, nil, function() return zones["column5"](fs) end, nil},
    }
  end

  hs.layout.apply(layout)
end

local screen = hs.screen.mainScreen()

-- applyLayout(screen)

-- watch for screen changes and reapply the layout

local screenwatcher = hs.screen.watcher.new(function()
  local screen = hs.screen.mainScreen()
  applyLayout(screen)
end)
-- screenwatcher:start()

-- position applications on launch to the proper position

local launchApps = {
  ["/Applications/iTerm.app"] = "rightLess",
  ["/Applications/Discord"] = "leftLess",
  ["/Applications/Microsoft Teams"] = "leftLess",
  ["/Applications/Google Chrome"] = "middle",
  ["/Applications/Sublime Text"] = "column3",
  ["/Applications/Sublime Merge"] = "middle",
  ["/Applications/Telegram"] = "column5",
  ["/System/Library/CoreServices/Finder.app"] = "middle",
}

-- local windowCreateFilter = hs.window.filter.new():setDefaultFilter()
-- windowCreateFilter:subscribe(hs.window.filter.windowCreated, function (win, ttl, last)
--     for path, position in pairs(launchApps) do
--       if win:application():path() == path then
--         moveWindow(win, position)
--           return true
--       end
--     end
-- end)

-- keyboard window position hotkeys

local positions = {
  c     = "full",
  k     = "middle",
  j     = "LeftMost",
  u     = "leftLess",
  o     = "rightLess",
  p     = "topCorner",
  ['/'] = "leftHalf",
  ['='] = "rightHalf",
  ['1'] = "column1",
  ['2'] = "column2",
  ['3'] = "column3",
  ['4'] = "column4",
  ['5'] = "column5",
  ['6'] = "rightMost",
  ['7'] = "obs"
}

for key, position in pairs(positions) do
  hs.hotkey.bind(hyper, key, function()
    local win = hs.window.focusedWindow()
    if not win then return end
  moveWindow(win, position)
  end)
end

-- go full screen

hs.hotkey.bind(hyper, "return", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  win:toggleFullScreen()
end)

-- move windows between screens (multiple display support)

-- hs.hotkey.bind(hyper, "LEFT", function()
--   local win = hs.window.focusedWindow()
--   if not win then return end
--   win:moveOneScreenWest(false, true)
-- end)

-- hs.hotkey.bind(hyper, "RIGHT", function()
--   local win = hs.window.focusedWindow()
--   if not win then return end
--   win:moveOneScreenEast(false, true)
-- end)

-- hs.hotkey.bind(hyper, "UP", function()
--   local win = hs.window.focusedWindow()
--   if not win then return end
--   win:moveOneScreenNorth(false, true)
-- end)

-- hs.hotkey.bind(hyper, "DOWN", function()
--   local win = hs.window.focusedWindow()
--   if not win then return end
--   win:moveOneScreenSouth(false, true)
-- end)

-- locks the screen, when possible anyway

hs.hotkey.bind(hyper, "'", function()
  hs.caffeinate.lockScreen()
end)

-- load up the console to see the things

hs.hotkey.bind(hyper, "`", function()
  hs.application.get("Hammerspoon"):selectMenuItem("Console...")
  hs.application.launchOrFocus("Hammerspoon")
end)


-- Say all is well

hs.notify.new({title="drusellers", informativeText="I bet it looks crispy in the dark."}):send()

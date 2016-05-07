-------------
-- CONFIGS --
-------------
require('hs.ipc')

-- animations
hs.window.animationDuration = 0.1

-- modifier keys
local mod = {'cmd', 'alt', 'ctrl'}

-- grid setup
hs.grid.setGrid('2x2', '1680x1050')
hs.grid.setGrid('2x2', '1440x900')
hs.grid.setGrid('4x2', '3840x1080')
hs.grid.MARGINX = 5
hs.grid.MARGINY = 5

hs.grid.ui.showExtraKeys = false
hs.grid.ui.textSize = 100
hs.grid.ui.cellStrokeWidth = 1
hs.grid.ui.highlightStrokeWidth = 5

hs.grid.ui.cellColor = {0,0,0,0}
hs.grid.ui.cellStrokeColor = {1,1,1,0.5}
hs.grid.ui.selectedColor = {1,1,1,0.1}
hs.grid.ui.highlightColor = {1,1,1,0.1}
hs.grid.ui.highlightStrokeColor = {1,1,1,0.5}

-- application hints
hs.hints.showTitleThresh = 0

-- window management
local positions = {
  topLeft     = {x=0, y=0, w=1, h=1},
  topRight    = {x=1, y=0, w=1, h=1},
  bottomLeft  = {x=0, y=1, w=1, h=1},
  bottomRight = {x=1, y=1, w=1, h=1},

  bottom      = {x=0, y=1, w=2, h=1},
  left        = {x=0, y=0, w=1, h=2},
  right       = {x=1, y=0, w=1, h=2},
  top         = {x=0, y=0, w=2, h=1},

  center      = {x=0.025, y=0.05, w=1.95, h=1.9},
  full        = {x=0, y=0, w=2, h=2},
}

-- window layout
local laptopScreen = "Color LCD"
local matroxScreen = "Display"

-- set up an application watcher and start it
local applicationWatcher = hs.application.watcher.new(function(name, event, app)

  -- Application launched
  if event == hs.application.watcher.launched then

    -- Emacs has been launched
    if string.find(name, "Emacs") then
      print("Name", name)
      print("Event", event)
      print("App", app)
      hs.grid.set(app:mainWindow(), '0,0 2x2', matroxScreen)
    end

  end

end)
applicationWatcher:start()


---------------------
-- Hotkey Bindings --
---------------------

-- window management
hs.hotkey.bind(mod, 'PAD7', function() moveWindowTo('topLeft') end)
hs.hotkey.bind(mod, 'PAD9', function() moveWindowTo('topRight') end)
hs.hotkey.bind(mod, 'PAD1', function() moveWindowTo('bottomLeft') end)
hs.hotkey.bind(mod, 'PAD3', function() moveWindowTo('bottomRight') end)
hs.hotkey.bind(mod, 'PAD2', function() moveWindowTo('bottom') end)
hs.hotkey.bind(mod, 'PAD4', function() moveWindowTo('left') end)
hs.hotkey.bind(mod, 'PAD6', function() moveWindowTo('right') end)
hs.hotkey.bind(mod, 'PAD8', function() moveWindowTo('top') end)

hs.hotkey.bind(mod, 'DOWN', function() moveWindowTo('bottom') end)
hs.hotkey.bind(mod, 'LEFT', function() moveWindowTo('left') end)
hs.hotkey.bind(mod, 'RIGHT', function() moveWindowTo('right') end)
hs.hotkey.bind(mod, 'UP', function() moveWindowTo('top') end)
hs.hotkey.bind(mod, '^', function() moveWindowTo('topLeft') end)
hs.hotkey.bind(mod, 'ç', function() moveWindowTo('topRight') end)
hs.hotkey.bind(mod, ';', function() moveWindowTo('bottomLeft') end)
hs.hotkey.bind(mod, 'è', function() moveWindowTo('bottomRight') end)

hs.hotkey.bind(mod, 'RETURN', function() moveWindowTo('full') end)
hs.hotkey.bind(mod, 'PADENTER', function() moveWindowTo('full') end)

hs.hotkey.bind(mod, 'PAD5',     function() moveWindowTo('center') end)

hs.hotkey.bind(mod, 'PAD-', function() moveWindowToPreviousScreen() end)
hs.hotkey.bind(mod, 'PAD+', function() moveWindowToNextScreen() end)

hs.hotkey.bind(mod, 'PAD=', function() hs.grid.toggleShow() end)
hs.hotkey.bind(mod, 'G', function() hs.grid.toggleShow() end)

hs.hotkey.bind(mod, 'PAD.', function() hs.hints.windowHints() end)
hs.hotkey.bind(mod, 'H', function() hs.hints.windowHints() end)

hs.hotkey.bind(mod, 'F19', function() hs.timer.doAfter(0.5, hs.caffeinate.startScreensaver):start() end)

-----------------------
-- Utility functions --
-----------------------

-- move window to a specific position
--    i use a matrox dualhead-to-go and my second screen is actually two
--    monitors that OSX sees as a single one. this is why i check for
--    the window position and if it's >= 3600 this means the window is
--    on the second physical monitor and have to offset it on the grid
function moveWindowTo(pos)
  local win = hs.window.focusedWindow()
  if not win then return end
  local screen = win:screen()
  local position = hs.fnutils.copy(positions[pos])
  if not position then return end

  -- If we're on the second physical screen
  if (win:frame().x >= 3600) then
    position.x = position.x + 2
  end

  hs.grid.set(win, position, screen)
end

-- move window to the next screen
function moveWindowToNextScreen()
  local win = hs.window.focusedWindow()
  if not win then return end

  local winframe = win:frame()
  local newframe = winframe

  -- check current window location
  --    check if we're on the laptop display or on one of the two
  --    physical display connected to the matrox box which makes OSX
  --    see a single ultrawide display
  if (winframe.x < 1680) then
    newframe.x = newframe.x + 1680
  elseif (winframe.x >= 1680 and winframe.x < 3600) then
    newframe.x = newframe.x + 1920
  elseif (winframe.x >= 3600) then
    newframe.x = newframe.x - 3600
  end

  win:setFrame(newframe)
end

-- move window to the next screen
function moveWindowToPreviousScreen()
  local win = hs.window.focusedWindow()
  if not win then return end

  local winframe = win:frame()
  local newframe = winframe

  -- check current window location
  --    check if we're on the laptop display or on one of the two
  --    physical display connected to the matrox box which makes OSX
  --    see a single ultrawide display
  if (winframe.x < 1680) then
    newframe.x = newframe.x + 3600
  elseif (winframe.x >= 1680 and winframe.x < 3600) then
    newframe.x = newframe.x - 1680
  elseif (winframe.x >= 3600) then
    newframe.x = newframe.x - 1920
  end

  win:setFrame(newframe)
end

-- Reload automatically on config changes
function reloadConfig(paths)
  doReload = false
  for _, file in pairs(paths) do
    if file:sub(-4) == ".lua" then
      print("A lua file changed, doing reload")
      doReload = true
    end
  end
  if not doReload then
    print("No lua file changed, skipping reload")
    return
  end

  hs.reload()
end
configFileWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig)
configFileWatcher:start()

hs.notify.new({
  title='Hammerspoon',
  informativeText='Config loaded'}):send()

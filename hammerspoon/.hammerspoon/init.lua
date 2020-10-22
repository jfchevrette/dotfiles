-------------
-- CONFIGS --
-------------
require('hs.ipc')

-- animations
hs.window.animationDuration = 0.1

-- modifier keys
local mod = {'control', 'option', 'cmd'}

-- grid setup
hs.grid.setGrid('2x2', '1440x900')
hs.grid.setGrid('2x2', '1920x1080')
hs.grid.setGrid('2x2', '2560x1080')
hs.grid.setGrid('2x2', '3440x1440')
hs.grid.setMargins({x=0, y=0})

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

---------------------
-- Hotkey Bindings --
---------------------

-- move window to a specific position
--    i use a matrox dualhead-to-go and my second screen is actually two
--    monitors that OSX sees as a single one. this is why i check for
--    the window position and if it's >= 3600 this means the window is
--    on the second physical monitor and have to offset it on the grid
local function moveWindowTo(pos)
  local win = hs.window.focusedWindow()
  if not win then return end
  local screen = win:screen()
  local position = hs.fnutils.copy(positions[pos])
  if not position then return end

  -- If we're on the second physical screen
  --if (win:frame().x >= 3600) then
  --  position.x = position.x + 2
  --end

  hs.grid.set(win, position, screen)
end

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

hs.hotkey.bind(mod, 'PAD-', function() hs.window.focusedWindow():moveOneScreenWest(true, false) end)
hs.hotkey.bind(mod, 'PAD+', function() hs.window.focusedWindow():moveOneScreenEast(true, false) end)

hs.hotkey.bind(mod, 'PAD=', function() hs.grid.toggleShow() end)
hs.hotkey.bind(mod, 'G', function() hs.grid.toggleShow() end)

-----------------------
-- Utility functions --
-----------------------

-- Reload automatically on config changes
local function reloadConfig(paths)
  local doReload = false
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
local configFileWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig)
configFileWatcher:start()

hs.notify.new({
  title='Hammerspoon',
  informativeText='Config loaded'}):send()

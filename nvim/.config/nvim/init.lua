-- TODO
-- - vim-better-whitespace
-- - telescope

pcall(require, "impatient")

local profile = require "jfc.profile"
-- profile.start()

if require "jfc.bootstrap".run() then
  print("Bootstrap completed. Please restart neovim.")
  return
end

vim.g.mapleader = ","

require "jfc.globals"
require "jfc.disable_builtins"

-- misc
vim.opt.updatetime = 1000 -- make neovim update faster
vim.opt.cursorline = true
vim.opt.equalalways = false -- don't resize all windows when splitting
vim.opt.splitright = true -- split windows right
vim.opt.splitbelow = true -- split windows below
vim.opt.showmatch = true -- show matching opening paren when closing
vim.opt.matchtime = 2 -- .. time to show
vim.opt.scrolloff = 10 -- ensure so many lines above/below the cursor
vim.opt.belloff = "all"
vim.opt.clipboard = "unnamedplus"
vim.opt.inccommand = "split"
vim.opt.swapfile = false -- no swap yo
vim.opt.shada = { "!", "'1000", "<50", "s10", "h" }
vim.opt.formatoptions = vim.opt.formatoptions
  - "a" -- auto formatting is BAD
  - "t" -- don't auto format my code, I got linters and formatters for that
  + "c" -- OK to format comments with respect to textwidth
  + "q" -- Allow formatting comments /w gq
  - "o" -- O and o, don't continue comments
  + "r" -- but continue after enter
  + "n" -- indent past the formatlistpat, not underneath it
  + "j" -- auto-remove comments if possible
  - "2" -- come on
vim.opt.joinspaces = false -- don't join spaces, I'm not in school anymore!
vim.opt.fillchars = {
  eob = "~"
}

-- buffers
vim.opt.hidden = true -- hide buffers, don't unload them

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- search
vim.opt.incsearch = true -- incremental searching
vim.opt.ignorecase = true -- ignore cache when searching
vim.opt.smartcase = true -- .. unless there is a capital letter
vim.opt.hlsearch = true

-- Cool floating popup menu for completion
vim.opt.pumblend = 20
vim.opt.wildmode = "longest:full"
vim.opt.wildoptions = "pum"

-- mode line
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.showmode = false

-- indent & tabs
vim.opt.autoindent = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.showbreak = string.rep(" ", 3)
vim.opt.linebreak = true

-- folding
vim.opt.foldmethod = "marker"
vim.opt.foldlevel = 0
vim.opt.modelines = 1

-- ignore compiles files and others we don't care about
vim.opt.wildignore = {
  "__pycache__",
  "*.o",
  "*~",
  "*.pyc",
}

require "jfc.plugins"
require "jfc.keymaps"
require "jfc.lsp"

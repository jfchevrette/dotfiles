local options = {
  updatetime = 1000,            -- make neovim update faster
  cursorline = true,            -- highlight whole line where cursor is
  equalalways = false,          -- don't resize all windows when splitting
  splitright = true,            -- split windows right
  splitbelow = true,            -- split windows below
  showmatch = true,             -- show matching opening paren when closing
  matchtime = 2,                -- .. time to show
  scrolloff = 10,               -- ensure so many lines above/below the cursor
  belloff = "all",              -- no bell, please!
  clipboard = "unnamedplus",    -- use clipboard that works with macOS
  inccommand = "split",         -- show the results of incremental search or replace in a split
  swapfile = false,             -- no swap file yo
  undofile = true,              -- persistent undo
  writebackup = false,          -- don't write a backup file
  laststatus = 3,
  winbar = "%F",

  -- line numbers
  number = true,                -- enable line numbers
  relativenumber = true,        -- enable relative line numbers
  signcolumn = "yes",           -- always show the sign column

  -- search
  incsearch = true,             -- incremental searching
  ignorecase = true,            -- ignore cache when searching
  smartcase = true,             -- .. unless there is a capital letter
  hlsearch = true,

  -- completion
  completeopt = { "menuone", "noselect" },
  pumheight = 10,
  wildmode = "longest:full",
  wildoptions = "pum",

  -- indent & tabs
  autoindent = true,
  shiftwidth = 2,
  softtabstop = 2,
  tabstop = 2,
  expandtab = true,

  -- wrapping and line breaks
  wrap = true,
  breakindent = true,
  showbreak = string.rep(" ", 3),
  linebreak = true,

  -- ignore compiles files and others we don't care about
  wildignore = {
    "__pycache__",
    "*.o",
    "*~",
    "*.pyc",
  },

  -- shared data file options
  shada = {
    "!",                        -- .. global variables starting with uppercase,
    "'1000",                    -- .. remembers marks for last X files
    "<50",                      -- .. remember content of registers for X lines
    "s10",                      -- .. content over X KiB are skipped
    "h"                         -- .. disable effect of hlsearch when loading shada
  },

  -- short message options
  shortmess = vim.opt.shortmess
    + "c",                      -- don't give |ins-completion-menu| messages

  -- define what's considered a keyword
  iskeyword = vim.opt.iskeyword
    + "-",

  -- how auto formatting is done
  formatoptions = vim.opt.formatoptions
    - "a"                       -- auto formatting is BAD
    - "t"                       -- don't auto format my code, I got formatters for that
    + "c"                       -- OK to format comments with respect to textwidth
    + "q"                       -- Allow formatting comments /w gq
    - "o"                       -- O and o, don't continue comments
    + "r"                       -- but continue after enter
    + "n"                       -- indent past the formatlistpat, not underneath it
    + "j"                       -- auto-remove comments if possible
    - "2"                       -- come on
}

--  Apply the options from above
for k, v in pairs(options) do
  vim.opt[k] = v
end


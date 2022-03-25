if not pcall(require, "colorbuddy") then
  return
end

vim.opt.termguicolors = true

require("colorbuddy").colorscheme "gruvbuddy"
require("colorizer").setup()

local c = require("colorbuddy.color").colors
local g = require("colorbuddy.group").Group
local gs = require("colorbuddy.group").groups
local s = require("colorbuddy.style").styles

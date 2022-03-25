-- TODO
-- - vim-better-whitespace
-- - telescope

-- local profile = require "user.profile"
-- profile.start()

vim.g.mapleader = ","

require "user.globals"
require "user.options"

if not require "user.plugins" then
  print("Bootstrap completed. Please restart neovim.")
  return
end
require "user.keymaps"
require "user.lsp"
require "user.colors"

require "user.globals"
require "user.options"

if not require "user.plugins" then
  print("Bootstrap completed. Please restart neovim.")
  return
end

require "user.keymaps"

require "user.plugins.autopairs"
require "user.plugins.comment"
require "user.plugins.lualine"
require "user.plugins.toggleterm"
require "user.plugins.indent-blankline"
require "user.plugins.cmp"
require "user.plugins.lsp"
require "user.plugins.gitsigns"
require "user.plugins.telescope"
require "user.plugins.treesitter"
require "user.plugins.project"

require "user.autocmds"

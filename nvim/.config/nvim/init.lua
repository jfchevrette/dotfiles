local g = vim.g

g.mapleader = ","

require('options')
require('plugins')
require('mappings')
require('lsp/lua')
require('lsp/rust')

require('compe-config')

-- colorscheme
vim.g.tokyonight_style = "night"
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
vim.cmd[[colorscheme tokyonight]]

require('gitsigns').setup {}
require('trouble').setup {}

require('bufferline').setup {
  options = {
    always_show_bufferline = true,
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or " "
      return ' '..icon..count
    end
  }
}
require('lualine').setup {
  options = {
    theme = 'tokyonight',
  },
}
require('nvim-autopairs').setup {}
require'telescope'.load_extension('zoxide')

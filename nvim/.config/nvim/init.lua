local g = vim.g

g.mapleader = ","

require('options')
require('plugins')
require('mappings')
require('lsp/lua')

-- colorscheme
vim.g.material_style = 'deep ocean'
require('material').set()

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
    theme = 'material-nvim',
  },
}
require('nvim-autopairs').setup {}
require'telescope'.load_extension('zoxide')

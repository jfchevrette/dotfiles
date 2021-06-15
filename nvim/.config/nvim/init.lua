local g = vim.g

g.mapleader = ","

require('plugins')
require('mappings')
require('lsp/lua')

-- colorscheme
vim.g.material_style = 'deep ocean'
require('material').set()

require('gitsigns').setup {}
require('bufferline').setup {}
require('trouble').setup {}
require('lualine').setup {
  options = {
    theme = 'material-nvim',
  },
  sections = {
    lualine_c = {'diagnostics', 'filename'},
  },
}
require('nvim-autopairs').setup()

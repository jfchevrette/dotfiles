local system_name
if vim.fn.has('mac') == 1 then
  system_name = 'macOS'
elseif vim.fn.has('unix') == 1 then
  system_name = 'Linux'
elseif vim.fn.has('win32') == 1 then
  system_name = 'Windows'
else
  print('Unsupported system for sumneko')
end

local sumneko_root = '/Users/jfchevrette/code/utils/lua-language-server'
local sumneko_binary = sumneko_root..'/bin/'..system_name..'/lua-language-server'
require('lspconfig').sumneko_lua.setup {
  cmd = {sumneko_binary, '-E', sumneko_root..'/main.lua'},
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        --library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}

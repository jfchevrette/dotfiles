local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end


-- Workaround for compiler issue on Darwin
if vim.loop.os_uname().sysname == "Darwin" then
  require'nvim-treesitter.install'.compilers = { "gcc-11" }
end


configs.setup {
  ensure_installed = { "bash", "lua", "python", "rust" },
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

deps = {
  "nvim-lsp-installer",
  "lspconfig",
}

if not INSTALLED(deps) then
  return
end

require("nvim-lsp-installer").setup({
  automatic_installation = true,
})

-- lua
require("lspconfig").sumneko_lua.setup{
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    }
  }
}

-- rust
require("lspconfig").rust_analyzer.setup{}

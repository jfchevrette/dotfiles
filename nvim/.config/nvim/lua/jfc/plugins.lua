_ = vim.cmd [[packadd packer.nvim]]

return require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"
    use "lewis6991/impatient.nvim"
    use "tjdevries/nlua.nvim"
    use "neovim/nvim-lspconfig"
  end,
  config = {},
}

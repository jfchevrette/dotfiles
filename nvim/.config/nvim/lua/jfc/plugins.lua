_ = vim.cmd [[packadd packer.nvim]]

return require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"
    use "lewis6991/impatient.nvim"
    use "tjdevries/nlua.nvim"
    use "neovim/nvim-lspconfig"
    use "tjdevries/colorbuddy.nvim"
    use "norcalli/nvim-colorizer.lua"
    use "tjdevries/gruvbuddy.nvim"
  end,
  config = {},
}

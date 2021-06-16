local exec = vim.api.nvim_command
local fn = vim.fn

-- Bootstrap packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  exec 'packadd packer.nvim'
end

return require("packer").startup {
  function(use)
    use 'wbthomason/packer.nvim'

    -- colors
    use 'marko-cerovac/material.nvim'

    -- lang stuff
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/playground'
    use 'neovim/nvim-lspconfig'
    use 'windwp/nvim-autopairs'

    -- visual
    use {'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use 'akinsho/nvim-bufferline.lua'
    use 'folke/trouble.nvim'

    use {'nvim-telescope/telescope.nvim',
    	requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
    use "nvim-telescope/telescope-media-files.nvim"
    use 'nvim-telescope/telescope-project.nvim'

    -- terminal
    use 'voldikss/vim-floaterm'
  end
}

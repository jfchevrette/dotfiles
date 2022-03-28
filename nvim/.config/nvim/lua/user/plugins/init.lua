local install_path = string.format("%s/site/pack/packer/start/packer.nvim", vim.fn.stdpath "data")
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  local out = vim.fn.system(
    string.format(
      "git clone --depth 1 %s %s",
      "https://github.com/wbthomason/packer.nvim",
      install_path
    )
  )
  print(out)
  print("Installed packer, please close and reopen neovim")
end

-- Autocommand that reloads neovim whenever the plugins.lua file is saved
local group = vim.api.nvim_create_augroup("Packer_User_Plugins", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*plugins/init.lua",
  callback = function()
    vim.cmd [[source <afile>]]
    vim.cmd [[PackerSync]]
  end,
  group = group
})

local ok, packer = pcall(require, "packer")
if not ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup {
  function(use)
    use "wbthomason/packer.nvim"        -- have packer manage itself
    use "nvim-lua/popup.nvim"           -- Lua implementation of vim's popup api
    use "nvim-lua/plenary.nvim"         -- collection of useful lua functions
    use "lewis6991/impatient.nvim"      -- speed up startup time by optimizing lua modules
    use "windwp/nvim-autopairs"         -- Autopairs, integrates with both cmp and treesitter
    use "numToStr/Comment.nvim"         -- Easy comment management
    use "lukas-reineke/indent-blankline.nvim"
    use "ahmedkhalf/project.nvim"

    -- Color scheme
    use {
      "Shatur/neovim-ayu",
      config = function ()
        require('ayu').setup({
          mirage = true,
          overrides = {},
        })
        vim.cmd [[colorscheme ayu]]
      end
    }

    -- startup page
    use {
      "goolord/alpha-nvim",
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
      end
    }

    -- Statusline
    use "nvim-lualine/lualine.nvim"

    -- cmp plugins
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-nvim-lsp"

    -- snippets
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- LSP
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "tamago324/nlsp-settings.nvim"
    use "jose-elias-alvarez/null-ls.nvim"

    -- Git
    use "lewis6991/gitsigns.nvim"

    -- Terminal
    use "akinsho/toggleterm.nvim"

    -- Telescope
    use "nvim-telescope/telescope.nvim"

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    }
    use "JoosepAlviste/nvim-ts-context-commentstring"

  end,
  config = {},
}


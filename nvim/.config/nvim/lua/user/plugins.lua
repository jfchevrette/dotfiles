local download_packer = function()
  if vim.fn.input("Download Packer? (y/n) ") ~= "y" then
    return
  end

  local dir = string.format("%s/site/pack/packer/start/", vim.fn.stdpath "data")
  vim.fn.mkdir(dir, "p")

  local out = vim.fn.system(
    string.format(
      "git clone %s %s",
      "https://github.com/wbthomason/packer.nvim",
      dir .. "/packer.nvim"
    )
  )

  print(out)
end

if not pcall(require, "packer") then
  download_packer()
  return false
end

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


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

local M = {}

function M.run()
  if not pcall(require, "packer") then
    download_packer()
    return true
  end
  return false
end

return M

-- Packer
vim.keymap.set("n", "<leader>pks", "<Cmd>PackerSync<cr>")

-- Map <leader><k> to corresponding <C-W><k>
for _, k in ipairs({"h", "j", "k", "l", "c", "o"}) do
  vim.keymap.set("n", "<leader>" .. k, "<C-w>" .. k)
end

-- Remove whitespace
vim.keymap.set("n", "<leader>sws", [[:%s/\s\+$//<CR>]])

vim.keymap.set("n", "<leader>t", function()
  if vim.bo.filetype == "rust" then
    -- do rust tests
    return ""
  end
  return ""
end, { expr = true })


-- tabs navigation with arrow keys
vim.keymap.set("n", "<Left>", function()
  vim.cmd [[checktime]]
  vim.api.nvim_feedkeys("gT", "n", true)
end)

vim.keymap.set("n", "<Right>", function()
  vim.cmd [[checktime]]
  vim.api.nvim_feedkeys("gt", "n", true)
end)
--

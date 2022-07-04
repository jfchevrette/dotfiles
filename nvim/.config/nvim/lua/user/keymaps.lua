local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","
keymap("", ",", "<Nop>", opts)

-- Packer
keymap("n", "<leader>ps", "<Cmd>PackerSync<cr>")

-- Better split nativation
for _, k in ipairs({"h", "j", "k", "l", "c", "o"}) do
  keymap("n", "<leader>" .. k, "<C-w>" .. k, opts)
end

-- Split resize with arrow keys
keymap("n", "<Up>", ":resize -2<CR>", opts)
keymap("n", "<Down>", ":resize +2<CR>", opts)
keymap("n", "<Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<Right>", ":vertical resize +2<CR>", opts)

-- clear highlight
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- File explorer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprev<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)
keymap("n", "<leader>bn", ":bnext<CR>", opts)
keymap("n", "<leader>bp", ":bprev<CR>", opts)

-- Telescope
keymap("n", "<leader>fb", function()
  require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})
end, opts)
keymap("n", "<leader>ff", function()
  require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})
end, opts)
keymap("n", "<leader>fp", function()
  require('telescope').extensions.projects.projects()
end, opts)
keymap("n", "<leader>fl", function()
  require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown{previewer = false})
end, opts)
keymap("n", "<leader>,fgf", "<cmd>Telescope git_files<cr>", opts)
keymap("n", "<leader>,fgg", "<cmd>Telescope git_files<cr>", opts)

-- Remove whitespace
keymap("n", "<leader>sws", [[:%s/\s\+$//e<CR>]])

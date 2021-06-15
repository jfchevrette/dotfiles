local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opts = {}


-- Windows
map("n", "<leader>wc", [[<Cmd>close<CR>]], opts)
map("n", "<leader>wo", [[<Cmd>only<CR>]], opts)
map("n", "<leader>wh", [[<Cmd>wincmd h<CR>]], opts)
map("n", "<leader>wj", [[<Cmd>wincmd j<CR>]], opts)
map("n", "<leader>wk", [[<Cmd>wincmd k<CR>]], opts)
map("n", "<leader>wl", [[<Cmd>wincmd l<CR>]], opts)

-- Buffers
map("n", "<leader>bn", [[<Cmd>bnext<CR>]], opts)
map("n", "<leader>bp", [[<Cmd>bprevious<CR>]], opts)
map("n", "<leader>bk", [[<Cmd>bdelete<CR>]], opts)

-- Open stuff
map("n", "<leader>ec", [[:e $MYVIMRC <CR>]], opts) -- vim config
map("n", "<leader>ee", [[:Explore <CR>]], opts) -- Explore

-- Telescope
map("n", "<leader>ff", [[<Cmd>Telescope find_files<CR>]], opts)
map("n", "<leader>fg", [[<Cmd>Telescope live_grep<CR>]], opts)
map("n", "<leader>fb", [[<Cmd>Telescope buffers<CR>]], opts)
map("n", "<leader>fh", [[<Cmd>Telescope help_tags<CR>]], opts)

-- Toggle line numbers
map("n", "<leader>n", [[<Cmd> set nu!<CR><Cmd> set rnu!<CR>]], opts)

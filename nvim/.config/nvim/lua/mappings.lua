local keymap = require('utils').keymap
local opts = {}

-- Windows
keymap("n", "<leader>wc", [[<Cmd>close<CR>]], opts)
keymap("n", "<leader>wo", [[<Cmd>only<CR>]], opts)
keymap("n", "<leader>wh", [[<Cmd>wincmd h<CR>]], opts)
keymap("n", "<leader>wj", [[<Cmd>wincmd j<CR>]], opts)
keymap("n", "<leader>wk", [[<Cmd>wincmd k<CR>]], opts)
keymap("n", "<leader>wl", [[<Cmd>wincmd l<CR>]], opts)

-- Buffers
keymap("n", "<leader>bn", [[<Cmd>bnext<CR>]], opts)
keymap("n", "<leader>bp", [[<Cmd>bprevious<CR>]], opts)
keymap("n", "<leader>bk", [[<Cmd>bdelete<CR>]], opts)

-- Open stuff
keymap("n", "<leader>ec", [[:e $MYVIMRC <CR>]], opts) -- vim config
keymap("n", "<leader>ee", [[:Explore <CR>]], opts) -- Explore

-- Telescope
keymap("n", "<leader>ff", [[<Cmd>lua require('telescope-config').project_files()<CR>]], opts)
keymap("n", "<leader>fs", [[<Cmd>Telescope live_grep<CR>]], opts)
keymap("n", "<leader>fb", [[<Cmd>Telescope buffers<CR>]], opts)
keymap("n", "<leader>fh", [[<Cmd>Telescope help_tags<CR>]], opts)
keymap("n", "<leader>fgf", [[<Cmd>Telescope git_files<CR>]], opts)
keymap("n", "<leader>fgb", [[<Cmd>Telescope git_branches<CR>]], opts)
keymap("n", "<leader>fgs", [[<Cmd>Telescope git_status<CR>]], opts)
keymap("n", "<leader>ft", [[<Cmd>Telescope treesitter<CR>]], opts)
keymap("n", "<leader>fp", [[<Cmd>lua require('telescope').extensions.project.project{display_type='full'}<CR>]], opts)

-- Toggle line numbers
keymap("n", "<leader>n", [[<Cmd> set nu!<CR>]], opts)

-- Terminal
keymap("n", "<leader><leader>", [[<Cmd>FloatermToggle<CR>]], opts)
keymap("t", "<leader><leader>", [[<Cmd>FloatermToggle<CR>]], opts)

vim.g.mapleader = " "

local keymap = vim.keymap
 
-- general keymaps

keymap.set("i", "jk", "<ESC>")

keymap.set("n", "<leader>nh", ":nohl<CR>")

keymap.set("n", "<leader>w", ":w<CR>")
keymap.set("n", "<leader>q", ":q<CR>")
keymap.set("n", "<leader>wq", ":wq<CR>")
keymap.set("n", "<leader>qq", ":q!<CR>")

-- moving between windows
keymap.set("n", "<S-k>", ":wincmd K<CR>")
keymap.set("n", "<S-j>", ":wincmd J<CR>")
keymap.set("n", "<S-h>", ":wincmd H<CR>")
keymap.set("n", "<S-l>", ":wincmd L<CR>")

-- splitting screen
keymap.set("n", "<C-v>", ":vsplit<CR>")
keymap.set("n", "<C-h>", ":split<CR>")

-- make split windows equal width
keymap.set("n", "<C-s>", "<C-w>=")

-- nvim-tree toggle
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
local builtin = require('telescope.builtin')
keymap.set('n', '<leader>ff', builtin.find_files, {})
keymap.set('n', '<leader>fg', builtin.live_grep, {})
keymap.set('n', '<leader>fb', builtin.buffers, {})
keymap.set('n', '<leader>fh', builtin.help_tags, {})

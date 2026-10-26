local map = vim.keymap.set

-- Clear search highlight
map('n', '<Esc>', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Resize windows
map('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })

-- Move selected lines up/down in visual mode
-- map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
-- map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Keep cursor centered when scrolling/searching
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Better paste (don't overwrite register when pasting over a selection)
map('x', '<leader>p', '"_dP', { desc = 'Paste without overwriting register' })

-- Quick save/quit
local function write_formatted()
  local buf = vim.api.nvim_get_current_buf()
  if next(vim.lsp.get_clients({ bufnr = buf, name = 'eslint' })) then
    vim.cmd('LspEslintFixAll')
  elseif next(vim.lsp.get_clients({ bufnr = buf, method = 'textDocument/formatting' })) then
    vim.lsp.buf.format({ bufnr = buf, timeout_ms = 3000 })
  end
  vim.cmd('write')
end

map('n', '<leader>w', write_formatted, { desc = 'Format and save file' })
map('n', '<leader>q', ':q<CR>', { desc = 'Quit' })

-- Split management
map('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
map('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
map('n', '<leader>se', '<C-w>=', { desc = 'Equalize window sizes' })
map('n', '<leader>sx', ':close<CR>', { desc = 'Close current split' })

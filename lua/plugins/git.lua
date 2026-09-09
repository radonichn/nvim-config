vim.pack.add({
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
})

local gs = require('gitsigns')

gs.setup({
  signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '▁' },
    topdelete = { text = '▔' },
    changedelete = { text = '▎' },
    untracked = { text = '▎' },
  },
  current_line_blame_opts = { virt_text_pos = 'eol', delay = 200 },
})

vim.keymap.set('n', '<leader>gb', gs.toggle_current_line_blame, { desc = 'Toggle git blame' })
vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview git hunk' })
vim.keymap.set('n', ']h', function() gs.nav_hunk('next') end, { desc = 'Next git hunk' })
vim.keymap.set('n', '[h', function() gs.nav_hunk('prev') end, { desc = 'Previous git hunk' })

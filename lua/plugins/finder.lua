vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.nvim' },
})

-- Icons used by mini.pick and mini.files (and later mini.statusline)
require('mini.icons').setup()

vim.env.RIPGREP_CONFIG_PATH = vim.fn.stdpath('config') .. '/rg.conf'

-- Fuzzy finder
require('mini.pick').setup({
  mappings = {
    move_down = '<Tab>',
    move_up = '<S-Tab>',
    toggle_preview = '',
    toggle_info = '',
  },
})
vim.ui.select = MiniPick.ui_select -- route vim.ui.select() (e.g. LSP code actions later) through mini.pick

local pick = require('mini.pick').builtin
vim.keymap.set('n', '<leader>ff', pick.files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', pick.grep_live, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', pick.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', pick.help, { desc = 'Find help tags' })

-- File explorer
require('mini.files').setup({
  mappings = {
    go_in = '',        -- disable plain go_in
    go_in_plus = 'l',  -- 'l' now does go_in AND closes if it's a file
  },
})

local toggle_files = function()
  if not MiniFiles.close() then
    MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
  end
end
vim.keymap.set('n', '<leader>e', toggle_files, { desc = 'Toggle file explorer' })

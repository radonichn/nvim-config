local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = 'yes'        -- always show sign column, prevents text-shift when diagnostics/git signs appear
opt.termguicolors = true
opt.scrolloff = 8             -- keep 8 lines visible above/below cursor
opt.wrap = false

-- Indentation (2 spaces is the JS/TS/Vue/CSS/Tailwind convention)
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- PHP/Laravel follows PSR-12, which uses 4 spaces — override per-filetype
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php',
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Search
opt.ignorecase = true
opt.smartcase = true          -- case-sensitive only if search contains uppercase

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Files & undo
opt.undofile = true           -- persistent undo across sessions
opt.swapfile = false
opt.updatetime = 250          -- faster CursorHold events (diagnostics, etc.)

-- Clipboard
opt.clipboard = 'unnamedplus' -- use system clipboard for yank/paste

-- Completion (revisited in Step 8)
opt.completeopt = { 'menuone', 'noselect', 'popup' }

-- Mouse
opt.mouse = 'a'

-- Whitespace visualization
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- define local variables for easier configuration
local opt = vim.opt
local g = vim.g
local cmd = vim.cmd

-- line numbers
opt.relativenumber = true
opt.number = true
-- g.did_load_filetypes = 1

-- formatting
g.formatoptions = "qrn1"

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
cmd("autocmd BufEnter * set fo-=c fo-=r fo-=o") -- disable auto commenting when going to the next line

-- line wrapping
opt.wrap = false

-- search settings
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

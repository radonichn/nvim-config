local opt = vim.opt
local g = vim.g
local cmd = vim.cmd

opt.relativenumber = true
opt.number = true

g.formatoptions = "qrn1"

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
cmd("autocmd BufEnter * set fo-=c fo-=r fo-=o")

opt.wrap = false

opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("config.options")
require("config.keymaps")

require("plugins.colorscheme")
require("plugins.treesitter")
require("plugins.finder")
require("plugins.lsp")

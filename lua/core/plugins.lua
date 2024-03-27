local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "rebelot/kanagawa.nvim" },

    { "nvim-lua/plenary.nvim" },
    { "tpope/vim-surround" },
    { "windwp/nvim-autopairs" },
    { "numToStr/Comment.nvim" },
    { "nvim-tree/nvim-tree.lua" },
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-lualine/lualine.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    { "nvim-telescope/telescope.nvim", branch = "0.1.x" },
    { "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-vsnip" },
	{ "hrsh7th/vim-vsnip" },
	{ "hrsh7th/vim-vsnip-integ" },
})

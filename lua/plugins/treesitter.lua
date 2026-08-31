vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
})

require('nvim-treesitter').install({
  'javascript',
  'typescript',
  'tsx',
  'vue',
  'css',
  'scss',
  'html',
  'php',
  'json',
  'jsdoc',
  'bash',
  'yaml',
  'markdown',
  'markdown_inline',
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local ok = pcall(vim.treesitter.start)
    if not ok then return end -- no parser installed for this filetype, skip silently
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

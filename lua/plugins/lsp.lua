vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
})

-- Resolve npm's global install location dynamically, so this works on
-- any machine regardless of where npm puts global packages.
local npm_root = vim.trim(vim.fn.system('npm root -g'))
local vue_language_server_path = npm_root .. '/@vue/language-server'

-- TypeScript/JavaScript, extended with the Vue plugin so it also
-- understands the <script> blocks inside .vue files
vim.lsp.config('ts_ls', {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
      },
    },
  },
  filetypes = {
    'javascript', 'javascriptreact',
    'typescript', 'typescriptreact',
    'vue',
  },
})

-- Vue's own server, handling template/CSS parts of .vue files
-- (hybrid mode is the default — no extra config needed here)
vim.lsp.config('vue_ls', {})

-- CSS
vim.lsp.config('cssls', {})

-- HTML
vim.lsp.config('html', {})

-- Tailwind CSS (works alongside cssls, gives class-name completion + hover swatches)
vim.lsp.config('tailwindcss', {})

-- PHP / Laravel
vim.lsp.config('intelephense', {
  settings = {
    intelephense = {
      files = { maxSize = 5000000 },
    },
  },
})

-- Lua, for editing this config with proper diagnostics
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.enable({
  'ts_ls', 'vue_ls', 'cssls', 'html', 'tailwindcss', 'intelephense', 'lua_ls',
})

-- Baseline keymaps + diagnostic styling, applied once per buffer an LSP attaches to
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  end,
})

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.INFO] = '●',
      [vim.diagnostic.severity.HINT] = '○',
    },
  },
})

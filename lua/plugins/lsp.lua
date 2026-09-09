vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
})

-- Locate a globally installed npm package by way of its executable.
--
-- `npm root -g` is no help here: pnpm puts each global in its own hashed
-- directory and installs a shell shim that records the real target in a
-- trailing comment. npm symlinks straight into the package instead.
--
-- The result is realpath'd because tsserver resolves a plugin by walking
-- node_modules up from `location`, and under pnpm only the real package
-- directory has @vue/typescript-plugin as a sibling.
local function global_package_dir(exe)
  local bin = vim.fn.exepath(exe)
  if bin == '' then
    return nil
  end
  local last_line = vim.fn.readfile(bin, '', -1)[1] or ''
  local entry = last_line:match('cmd%-shim%-target=(.+)') or vim.uv.fs_realpath(bin)
  -- both layouts put the entry point at <package>/bin/<file>
  return entry and vim.uv.fs_realpath(vim.fs.dirname(vim.fs.dirname(entry)))
end

local vue_ls_path = global_package_dir('vue-language-server')

-- TypeScript/JavaScript, extended with the Vue plugin so it also
-- understands the <script> blocks inside .vue files
vim.lsp.config('ts_ls', {
  init_options = {
    plugins = vue_ls_path and {
      {
        name = '@vue/typescript-plugin',
        location = vue_ls_path,
        languages = { 'vue' },
      },
    } or nil,
  },
  filetypes = {
    'javascript', 'javascriptreact',
    'typescript', 'typescriptreact',
    'vue',
  },
})

-- Vue's own server, handling template/CSS parts of .vue files
-- (hybrid mode is the default -- it leaves TypeScript to ts_ls above)
vim.lsp.config('vue_ls', {
  cmd = function(dispatchers, config)
    local cmd = { 'vue-language-server', '--stdio' }
    -- Volar loads TypeScript from --tsdk. Left to itself it requires whatever
    -- copy sits next to the global install, and dies on startup if that is
    -- TypeScript 7, whose "." export is a version stub with no compiler API.
    local tsdk = config.root_dir
      and vim.fs.joinpath(config.root_dir, 'node_modules', 'typescript', 'lib')
    if tsdk and vim.uv.fs_stat(vim.fs.joinpath(tsdk, 'typescript.js')) then
      table.insert(cmd, '--tsdk=' .. tsdk)
    else
      vim.notify('vue_ls: no TypeScript 5 in this project; the server may not start.',
        vim.log.levels.WARN)
    end
    return vim.lsp.rpc.start(cmd, dispatchers)
  end,
})

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

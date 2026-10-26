vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
})

local function global_package_dir(exe)
  local bin = vim.fn.exepath(exe)
  if bin == '' then
    return nil
  end
  local last_line = vim.fn.readfile(bin, '', -1)[1] or ''
  local entry = last_line:match('cmd%-shim%-target=(.+)') or vim.uv.fs_realpath(bin)
  return entry and vim.uv.fs_realpath(vim.fs.dirname(vim.fs.dirname(entry)))
end

local vue_ls_path = global_package_dir('vue-language-server')

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

local function find_tsdk(dir)
  while dir do
    local lib = vim.fs.joinpath(dir, 'node_modules', 'typescript', 'lib')
    if vim.uv.fs_stat(vim.fs.joinpath(lib, 'typescript.js')) then
      return lib
    end
    local parent = vim.fs.dirname(dir)
    if parent == dir then
      return nil
    end
    dir = parent
  end
end

vim.lsp.config('vue_ls', {
  cmd = function(dispatchers, config)
    local cmd = { 'vue-language-server', '--stdio' }
    local tsdk = config.root_dir and find_tsdk(config.root_dir)
    if tsdk then
      table.insert(cmd, '--tsdk=' .. tsdk)
    else
      vim.notify('vue_ls: no TypeScript 5 at or above the project root; the server may not start.',
        vim.log.levels.WARN)
    end
    return vim.lsp.rpc.start(cmd, dispatchers)
  end,
})

vim.lsp.config('intelephense', {
  settings = {
    intelephense = {
      files = { maxSize = 5000000 },
    },
  },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
    },
  },
})

vim.lsp.enable({
  'ts_ls', 'vue_ls', 'eslint', 'cssls', 'html', 'tailwindcss', 'intelephense', 'lua_ls',
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
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

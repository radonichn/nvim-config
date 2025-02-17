require("cmp").setup({
	sources = {
		{ name = "nvim_lsp" },
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")
local lsputil = require("lspconfig/util")

lspconfig.pyright.setup({
	root_dir = lsputil.root_pattern(
		".git",
		"pyrightconfig.json",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyproject.toml"
	),
	capabilities = capabilities,
})

lspconfig.html.setup({
	capabilities = capabilities,
})

lspconfig.cssls.setup({
	capabilities = capabilities,
})

lspconfig.tailwindcss.setup({
	capabilities = capabilities,
})

lspconfig.ts_ls.setup({
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = "/usr/local/lib/node_modules/@vue/language-server", -- change this to actual path to @vue/language-server if this doesn't work
				-- location = "/usr/local/lib/node_modules/@vue/language-server", -- for MacOS
				languages = { "vue" },
			},
		},
	},
	filetypes = { "typescript", "javascript", "vue" },
	capabilities = capabilities,
})
-- No need to set `hybridMode` to `true` as it's the default value
lspconfig.volar.setup({})

lspconfig.eslint.setup({
	on_attach = function(_, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
	capabilities = capabilities,
})

lspconfig.intelephense.setup({
    filetypes = { "php", "blade" },
	capabilities = capabilities,
})

require("neodev").setup({})
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

vim.keymap.set("n", "<space>do", vim.diagnostic.open_float)
vim.keymap.set("n", "<space>dp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<space>dn", vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-sh>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

vim.diagnostic.config({ update_in_insert = false })

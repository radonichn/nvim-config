require("mason").setup({
	ui = {
		check_outdated_packages_on_open = true,
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		width = 0.8,
		height = 0.9,

		icons = {
			package_installed = "󰄳 ",
			package_pending = " ",
			package_uninstalled = "󰚌 ",
		},
	},
	keymaps = {
		toggle_package_expand = "<CR>",
		install_package = "i",
		update_package = "u",
		check_package_version = "c",
		update_all_packages = "U",
		check_outdated_packages = "C",
		uninstall_package = "X",
		cancel_installation = "<C-c>",
		apply_language_filter = "<C-f>",
		toggle_package_install_log = "<CR>",
		toggle_help = "g?",
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"pyright",
		"ts_ls",
		"html",
		"cssls",
		"tailwindcss",
		"dockerls",
		"docker_compose_language_service",
		"jsonls",
		"intelephense",
		"volar",
		"lua_ls",
		"eslint",
	},
	automatic_installation = true,
	handlers = nil,
})

require("mason").setup{
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
}

require("mason-lspconfig").setup {
    ensure_installed = {
        "pyright",
        "tsserver",
        "html",
        "cssls",
        "tailwindcss",
        "dockerls",
        "docker_compose_language_service",
        "jsonls",
        "intelephense",
        "volar",
        "lua_ls",
    },
    automatic_installation = true,
    handlers = nil,
}

require("mason-null-ls").setup({
  ensure_installed = {
    "prettier",
    "stylua",
    "eslint_d",
  },
  automatic_installation = true,
})

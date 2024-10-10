return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"gopls",
				"jsonls",
				"solc",
				"tflint",
				"ts_ls",
				"yamlls",
				"bashls",
				"pyright",
				"lua_ls",
				"clangd",
				"vimls",
				"jsonls",
				"cmake",
				"cssls",
				"cssmodules_ls",
				"html",
				"csharp_ls",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"eslint-lsp",
				"prettier",
				"prettierd",
				"stylua",
				"typescript-language-server",
				"rust-analyzer",
				"clang-format",
				"gofumpt",
				"cpptools",
				"go-debug-adapter",
				"delve",
				"codelldb",
				"autopep8",
				"js-debug-adapter",
			},
		})
	end,
}

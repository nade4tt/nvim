return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

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
			ensure_installed = {
				"bashls",
				"clangd",
				"cssls",
				"cssmodules_ls",
				"gopls",
				"html",
				"graphql",
				"jsonls",
				"jsonls",
				"lua_ls",
				"pyright",
				"rust_analyzer",
				"sqls",
				"tailwindcss",
				"tflint",
				"ts_ls",
				"vimls",
				"yamlls",
			},
			automatic_installation = true,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"black",
				"clang-format",
				"codelldb",
				"cpplint",
				"cpptools",
				"csharpier",
				"delve",
				"eslint-lsp",
				"go-debug-adapter",
				"gofumpt",
				"isort",
				"js-debug-adapter",
				"markdownlint",
				"netcoredbg",
				"prettier",
				"prettierd",
				"rustywind",
				"sqlfmt",
				"stylua",
				"typescript-language-server",
			},
			automatic_installation = true,
		})
	end,
}

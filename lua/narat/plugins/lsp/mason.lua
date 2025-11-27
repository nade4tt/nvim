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
				"fish_lsp",
				"bashls",
				"clangd",
				"cssls",
				"cssmodules_ls",
				"gopls",
				"html",
				"jsonls",
				"lua_ls",
				"rust_analyzer",
				"pyright",
				"sqls",
				"tflint",
				"ts_ls",
				"vimls",
				"yamlls",
			},
			automatic_enable = {
				exclude = {
					"python_ls",
					"lua_ls",
					"go_ls",
					"cpp_ls",
					"rust_ls",
					"bash_lsp",
				},
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"black",
				"eslint_d",
				"stylelint",
				"clang-format",
				"codelldb",
				"cpplint",
				"cpptools",
				"delve",
				"eslint-lsp",
				"go-debug-adapter",
				"gofumpt",
				"isort",
				"js-debug-adapter",
				"markdownlint",
				"prettier",
				"prettierd",
				"rustywind",
				"sqlfmt",
				"stylua",
				"typescript-language-server",
				"shellcheck",
				"shfmt",
			},
		})
	end,
}

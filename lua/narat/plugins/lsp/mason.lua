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
				-- "pyright",
				"bashls",
				"clangd",
				"cssls",
				"cssmodules_ls",
				"gopls",
				"html",
				"jsonls",
				"lua_ls",
				"rust_analyzer",
				"pylsp",
				"sqls",
				"tflint",
				"ts_ls",
				"vimls",
				"yamlls",
			},
			automatic_enable = {
				exclude = {
					"pylsp", -- Disable automatic setup for pylsp
					"lua_ls", -- Disable automatic setup for lua_ls
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
				-- "pylint",
				-- "netcoredbg",
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
			},
		})
	end,
}

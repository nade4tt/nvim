vim.pack.add({
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

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
		"clangd", -- C/C++
		"pyright", -- Python
		"lua_ls", -- Lua
		"bashls", -- Bash
	},
	automatic_enable = {
		-- exclude = {
		--   "python_ls",
		--   "pyright",
		--   "lua_ls",
		--   "go_ls",
		--   "cpp_ls",
		--   -- "rust_analyzer",
		--   "bash_lsp",
		-- },
	},
})

mason_tool_installer.setup({
	ensure_installed = {

		-- Python
		"black",
		"isort",

		-- C / C++
		"clang-format",
		"codelldb",
		"cpplint",

		-- Lua
		"stylua",

		-- Bash
		"shellcheck",
		"shfmt",

		-- Markdown
		"markdownlint",
		"prettier",
	},
})

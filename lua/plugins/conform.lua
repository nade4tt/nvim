vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim" } })

local conform = require("conform")

-- Keymap for manual formatting
require("utils").keymap("n", "<F5>", function()
	conform.format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

local is_windows = vim.fn.has("win32") == 1

conform.setup({
	formatters = {
		black = {
			command = "black",
			args = { "--line-length", "200", "--quiet", "-" },
		},
		clang_format = {
			command = "clang-format",
			args = {
				"-style={BasedOnStyle: llvm, IndentWidth: 4, AccessModifierOffset: 1}",
			},
		},
		isort = {
			command = "isort",
			args = { "-" },
		},
		stylua = {
			command = "stylua",
			args = { "-" },
		},
		rustywind = {
			command = "rustywind",
			args = { "-" },
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = {
			"isort",
			"black",
		},
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "jq" },
		css = { "prettier" },
		markdown = { "prettier" },
		cpp = { "clang_format" },
		c = { "clang_format" },
		sh = { "shfmt" },
		bash = { "shfmt" },
	},
	-- Disable format on save
	-- format_on_save = nil,
	format_on_save = not is_windows and {
		timeout_ms = 2000,
		lsp_fallback = true,
	} or nil,
	-- Add this if you want to stop after the first formatter that succeeds
	-- format_after_save = {
	-- 	stop_after_first = false,
	-- },
})

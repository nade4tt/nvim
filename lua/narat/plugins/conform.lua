return {
	-- Linting (diagnostics)
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				cpp = { "cpplint" },
				javascript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				python = { "flake8" }, -- or 'pylint'
				markdown = { "markdownlint" },
			}

			-- Set up autocmd to lint on save
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			-- Keymap for manual formatting
			require("narat.core.utils").keymap("n", "<F5>", function()
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
						args = { "--style={IndentAccessModifiers: AfterClass, AccessModifierOffset: 1}" },
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
					csharp = { "csharpier" },
					markdown = { "prettier" },
					cpp = {
						"clang_format",
					},
					css = { "rustywind" },
				},
				-- Disable format on save
				format_on_save = not is_windows and {
					timeout_ms = 2000,
					lsp_fallback = true,
				} or nil,
				-- Add this if you want to stop after the first formatter that succeeds
				-- format_after_save = {
				-- 	stop_after_first = false,
				-- },
			})
		end,
	},
}

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

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = {
						{ "black", extra_args = { "--line-length", "200" } },
						"isort",
					},
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "jq" },
					csharp = { "csharpier" },
					markdown = { "prettier" },
					cpp = {
						{
							"clang_format",
							extra_args = { "--style={IndentAccessModifiers: AfterClass, AccessModifierOffset: 1}" },
						},
					},
					css = { "rustywind" },
					rust = { "rustywind " },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})

			-- Keymap for manual formatting
			vim.keymap.set("n", "<F5>", function()
				conform.format({ async = true, lsp_fallback = true })
			end, { desc = "Format buffer" })
		end,
	},
}

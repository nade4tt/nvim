return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				require("none-ls.diagnostics.cpplint"),
				require("none-ls.formatting.jq"),
				require("none-ls.code_actions.eslint"),
				-- null_ls.builtins.completion.spell,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier.with({
					extra_filetypes = { "markdown" }, -- Include Markdown formatting
					extra_args = { "--print-width", "80" }, -- Set line width to 80
				}),
				null_ls.builtins.formatting.csharpier,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.black.with({
					extra_args = { "--line-length", "200" },
				}),
			},
		})

		vim.keymap.set("n", "<F5>", vim.lsp.buf.format, { desc = "Format buffer" })
	end,
}

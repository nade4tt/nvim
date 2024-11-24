return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local lspconfig = require("lspconfig")

		null_ls.setup({
			sources = {
				null_ls.builtins.completion.spell,
				null_ls.builtins.completion.clang_format,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.csharpier,
				null_ls.builtins.formatting.isort,
				require("none-ls.diagnostics.eslint"),
				lspconfig.ruff.setup({}),
			},
		})
		vim.keymap.set("n", "<F5>", vim.lsp.buf.format, { desc = "Format buffer" })
	end,
}

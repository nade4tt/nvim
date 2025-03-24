return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},

	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			sources = {
				require("none-ls.diagnostics.cpplint"),
				require("none-ls.formatting.jq"),
				require("none-ls.code_actions.eslint"),
				-- null_ls.builtins.completion.spell,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.csharpier,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.rustywind,
				null_ls.builtins.formatting.black.with({
					extra_args = { "--line-length", "200" },
				}),
				null_ls.builtins.formatting.clang_format.with({
					extra_args = { "--style={IndentAccessModifiers: AfterClass, AccessModifierOffset: 1}" },
				}),
			},

			-- format on save
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

					local filetype = vim.bo[bufnr].filetype
					local is_windows = vim.fn.has("win32")

					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,

						callback = function()
							if is_windows and filetype == "python" then
								print("Formatting on save disabled for python on Windows")
								return
							end
							vim.lsp.buf.format({ timeout_ms = 2000 })
						end,
					})
				end
			end,
		})

		vim.keymap.set({ "n", "v" }, "<F5>", vim.lsp.buf.format, { desc = "Format buffer" })
	end,
}

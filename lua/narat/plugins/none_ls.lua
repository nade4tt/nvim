return {
	-- "nvimtools/none-ls.nvim",
	-- dependencies = {
	--   "nvimtools/none-ls-extras.nvim",
	-- },
	-- config = function()
	--   local null_ls = require("null-ls")
	--   local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	--   null_ls.setup({
	--     sources = {
	--       require("none-ls.diagnostics.cpplint"),
	--       require("none-ls.formatting.jq"),
	--       require("none-ls.code_actions.eslint"),
	--       -- null_ls.builtins.completion.spell,
	--       null_ls.builtins.formatting.stylua,
	--       null_ls.builtins.formatting.prettier,
	--       null_ls.builtins.formatting.csharpier,
	--       null_ls.builtins.formatting.isort,
	--       null_ls.builtins.formatting.rustywind,
	--       null_ls.builtins.formatting.black.with({
	--         extra_args = { "--line-length", "200" },
	--       }),
	--       null_ls.builtins.formatting.clang_format.with({
	--         extra_args = { "--style={IndentAccessModifiers: AfterClass, AccessModifierOffset: 1}" },
	--       }),
	--     },

	--     -- format on save
	--     on_attach = function(client, bufnr)
	--       if vim.fn.has("win32") == 0 then
	--         if client.supports_method("textDocument/formatting") then
	--           vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	--           vim.api.nvim_create_autocmd("BufWritePre", {
	--             group = augroup,
	--             buffer = bufnr,
	--             callback = function()
	--               -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
	--               -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
	--               vim.lsp.buf.format()
	--             end,
	--           })
	--         end
	--       end
	--     end,
	--   })

	--   vim.keymap.set("n", "<F5>", vim.lsp.buf.format, { desc = "Format buffer" })
	-- end,
}

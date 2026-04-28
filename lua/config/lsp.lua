local keymap = require("utils").keymap

vim.lsp.config("*", {
	root_markers = { ".git" },
	capabilities = {
		textDocument = {
			semanticTokens = { multilineTokenSupport = true },
		},
	},
})

-- Auto-load all LSP configs from lsp/*.lua
for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
	local server_name = vim.fn.fnamemodify(f, ":t:r")
	local config = dofile(f)
	vim.lsp.config(server_name, config)
	vim.lsp.enable(server_name)
end

-- LSP keymaps
keymap("n", "gR", "<cmd>Telescope lsp_references<cr>")
keymap("n", "gD", vim.lsp.buf.declaration)
keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>")
keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>")
keymap("n", "<leader>ca", vim.lsp.buf.code_action)
keymap("n", "<leader>rn", vim.lsp.buf.rename)
keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>")
keymap("n", "<leader>d", vim.diagnostic.open_float)
keymap("n", "K", vim.lsp.buf.hover)
keymap("n", "<leader>rs", ":LspRestart<CR>")
keymap("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)
keymap("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)

-- Toggle inlay hints
keymap("n", "<F8>", function()
	local enabled = not vim.lsp.inlay_hint.is_enabled()
	vim.lsp.inlay_hint.enable(enabled)
	vim.notify("Inlay hints: " .. (enabled and "on" or "off"))
end, { desc = "Toggle inlay hints" })

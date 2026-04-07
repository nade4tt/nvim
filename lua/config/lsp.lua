local keymap = require("utils").keymap

vim.lsp.config("*", {
	root_markers = { ".git" },
	capabilities = {
		textDocument = {
			semanticTokens = { multilineTokenSupport = true },
		},
	},
})

for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
	local server_name = vim.fn.fnamemodify(f, ":t:r")
	local config = dofile(f)
	vim.lsp.config(server_name, config)
	vim.lsp.enable(server_name)
end

keymap("n", "gr", "<cmd>telescope lsp_references<cr>")
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
keymap("n", "<leader>do", vim.diagnostic.open_float)

keymap("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)
keymap("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)

-- vim.api.nvim_create_autocmd("lspattach", {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client and client:supports_method(vim.lsp.protocol.methods.textdocument_completion) then
-- 			vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
-- 			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })

-- 			require("utils").keymap("i", "<c-space>", function()
-- 				vim.lsp.completion.get()
-- 			end)
-- 		end
-- 	end,
-- })

-- vim.lsp.config("pyright", {
-- 	filetypes = { "py" },
-- })

-- diagnostics
-- vim.diagnostic.config({
-- 	-- use the default configuration
-- 	virtual_lines = true,

-- 	-- alternatively, customize specific options
-- 	virtual_lines = {
-- 		-- only show virtual line diagnostics for the current cursor line
-- 		current_line = true,
-- 	},
-- })

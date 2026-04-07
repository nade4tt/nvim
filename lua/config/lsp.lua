vim.lsp.config("*", {
	root_markers = { ".git" },
	capabilities = {
		textDocument = {
			semanticTokens = { multilineTokenSupport = true },
		},
	},
})

-- local lsp_configs = {}

for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
	local server_name = vim.fn.fnamemodify(f, ":t:r")
	local config = dofile(f)
	vim.lsp.config(server_name, config)
	vim.lsp.enable(server_name)
end

-- vim.lsp.enable(lsp_configs)
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
-- 			vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
-- 			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })

-- 			require("utils").keymap("i", "<C-Space>", function()
-- 				vim.lsp.completion.get()
-- 			end)
-- 		end
-- 	end,
-- })

-- vim.lsp.config("pyright", {
-- 	filetypes = { "py" },
-- })

-- Diagnostics
-- vim.diagnostic.config({
-- 	-- Use the default configuration
-- 	virtual_lines = true,

-- 	-- Alternatively, customize specific options
-- 	virtual_lines = {
-- 		-- Only show virtual line diagnostics for the current cursor line
-- 		current_line = true,
-- 	},
-- })

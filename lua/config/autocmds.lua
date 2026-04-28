-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Disable line numbers and syntax in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("terminal-settings", { clear = true }),
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.bo.syntax = "off"
	end,
})

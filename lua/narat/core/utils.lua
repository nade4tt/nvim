local M = {}
M.keymap = vim.keymap.set
M.keymap_options = { noremap = true, silent = true }

function M.keymap(mode, keymap, command, additional_opts)
	local opts = vim.tbl_extend("force", M.keymap_options, additional_opts or {})
	vim.keymap.set(mode, keymap, command, opts)
end

return M

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local function floating_terminal(opts)
	opts = opts or {}
	local width = math.floor(vim.o.columns * 0.8) -- 80% of the editor width
	local height = math.floor(vim.o.lines * 0.8) -- 80% of the editor height

	local row = math.floor((vim.o.lines - height) / 2) -- Center row
	local col = math.floor((vim.o.columns - width) / 2) -- Center column

	local buf = nil
	if vim.api.nvim_buf_is_valid(state.floating.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	-- define new window configuration
	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	}

	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

local toggle_floating_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = floating_terminal({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

vim.api.nvim_create_user_command("FloatingTerminal", toggle_floating_terminal, {})
vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_floating_terminal)

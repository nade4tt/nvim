local M = {}

-- Persistent buffer handle and window handle
local buf = nil
local win = nil

-- Path where scratchpad contents are saved across sessions
local save_path = vim.fn.stdpath("data") .. "/scratchpad.md"

local function create_buf()
	buf = vim.api.nvim_create_buf(false, true) -- unlisted, scratch

	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "hide"
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = "markdown"
	vim.api.nvim_buf_set_name(buf, "Scratchpad")

	-- Load persisted content if it exists
	if vim.fn.filereadable(save_path) == 1 then
		local lines = vim.fn.readfile(save_path)
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	end

	-- Auto-save on every change
	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
		buffer = buf,
		callback = function()
			local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
			vim.fn.writefile(lines, save_path)
		end,
		desc = "Scratchpad: auto-save on change",
	})
end

local function open_win()
	local width = math.floor(vim.o.columns * 0.6)
	local height = math.floor(vim.o.lines * 0.6)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " Scratchpad ",
		title_pos = "center",
	})

	vim.wo[win].wrap = true
	vim.wo[win].linebreak = true
	vim.wo[win].cursorline = true

	-- Close the window (not the buffer) with q or <Esc> in normal mode
	local close = function()
		if win and vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, false)
			win = nil
		end
	end

	vim.keymap.set("n", "q", close, { buffer = buf, nowait = true, desc = "Scratchpad: close" })
	vim.keymap.set("n", "<Esc>", close, { buffer = buf, nowait = true, desc = "Scratchpad: close" })
end

function M.toggle()
	-- Buffer doesn't exist yet — create it
	if not buf or not vim.api.nvim_buf_is_valid(buf) then
		create_buf()
	end

	-- Window is open — close it
	if win and vim.api.nvim_win_is_valid(win) then
		vim.api.nvim_win_close(win, false)
		win = nil
		return
	end

	-- Window is closed — open it
	open_win()
end

return M

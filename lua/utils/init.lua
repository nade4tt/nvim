local M = {}

local default_opts = { noremap = true, silent = false }
M.keymap = function(mode, lhs, rhs, opts)
	local options = vim.tbl_extend("force", default_opts, opts or {})
	vim.keymap.set(mode, lhs, rhs, options)
end

M.get_root_pattern = function(...)
	local patterns = { ... }
	return function(bufnr)
		bufnr = bufnr or 0
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		if bufname == "" then
			return vim.fn.getcwd()
		end
		local dir = vim.fs.dirname(bufname)

		local found = vim.fs.find(patterns, { upward = true, path = dir })[1]
		if found then
			return vim.fn.fnamemodify(vim.fs.dirname(found), ":p")
		end
		return dir
	end
end

M.get_python_path = function()
	-- check if a venv is active (VIRTUAL_ENV)
	local venv = os.getenv("VIRTUAL_ENV")
	if venv then
		if vim.loop.os_uname().sysname == "Windows" then
			return venv .. "\\Scripts\\python.exe"
		else
			return venv .. "/bin/python"
		end
	end

	-- fallback: look for ./venv in project root
	local cwd = vim.fn.getcwd()
	local local_venv = cwd .. "/venv/bin/python"
	if vim.fn.filereadable(local_venv) == 1 then
		return local_venv
	end

	return nil
end

M.center_window = function()
	vim.cmd("only")
	local width = vim.o.columns
	local win_width = math.floor(width * 0.6)
	local pad = math.floor((width - win_width) / 2)
	vim.cmd("topleft vsplit")
	vim.api.nvim_win_set_width(0, pad)
	vim.cmd("enew")
	vim.cmd("setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile")
	vim.cmd("wincmd l")
	vim.cmd("wincmd l")
	vim.cmd("vsplit")
	vim.api.nvim_win_set_width(0, pad)
	vim.cmd("enew")
	vim.cmd("setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile")
	vim.cmd("wincmd h")
end

return M

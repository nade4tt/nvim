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

return M

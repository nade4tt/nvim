local keymap = require("narat.core.utils").keymap

-- Toggle copilot
local copilot_on = true
vim.api.nvim_create_user_command("CopilotToggle", function()
	if copilot_on then
		vim.cmd("Copilot disable")
		print("Copilot OFF")
	else
		vim.cmd("Copilot enable")
		print("Copilot ON")
	end
	copilot_on = not copilot_on
end, { nargs = 0 })

-- Search without jumping
function SearchWithoutJump()
	local pattern = vim.fn.input("Search: ")
	vim.fn.setreg("/", pattern)
	vim.cmd("set hlsearch")
end

-- Telescope current buffer grep
function TelescopeCurrentBufferGrep()
	require("telescope.builtin").live_grep({
		search_dirs = { vim.fn.expand("%:p") },
	})
end

-- Telescope grep for files
function TelescopeGrepFiles()
	require("telescope.builtin").live_grep({ additional_args = { "-l" } })
end

-- Terminal
local job_id = 0

keymap("n", "<leader>st", function()
	local file_path = vim.fn.expand("%:p")
	local file_extension = vim.fn.expand("%:e")

	vim.cmd.vnew()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 10)
	vim.cmd.term()
	job_id = vim.bo.channel

	if file_extension == "py" then
		vim.fn.chansend(job_id, "python " .. file_path .. "\n")
	end
end)

-- Toggle checkbox
keymap("n", "<CR>", function()
	local current_line = vim.api.nvim_get_current_line()
	local pattern = "^([%s-]*%[)([x%s]+)(%].*)$"

	local prefix, status, sufix = current_line:match(pattern)

	-- If the line doesn't match the pattern, return
	if not status then
		return
	end

	local new_status = (status == " ") and "x" or " "
	vim.api.nvim_set_current_line(prefix .. new_status .. sufix)
end)

function CreatePresentableName(filepath)
	local file_name = vim.fn.fnamemodify(filepath, ":t")
	local file_extension = vim.fn.fnamemodify(filepath, ":e")

	local presentable_name = file_name

	if file_extension == "md" then
		presentable_name = string.gsub(file_name, "%d%d%d%d%-%d%d%-%d%d%-", "")
		presentable_name = string.gsub(presentable_name, "%.md", "")
		presentable_name = string.gsub(presentable_name, "%-", " ")
	end

	return presentable_name
end

-- Insert a reference to a markdown file and open it
function CreateMdReferenceFile()
	local current_file = vim.api.nvim_buf_get_name(0)
	local current_dir = vim.fn.fnamemodify(current_file, ":h")

	local new_file_name = vim.fn.input("Enter new markdown file name: ", "", "file")

	if not new_file_name:match("%.md$") then
		new_file_name = new_file_name .. ".md"
	end

	local new_file_path = current_dir .. "/" .. new_file_name

	local reference_link = string.format("- [%s](%s)", CreatePresentableName(new_file_name), new_file_name)
	vim.api.nvim_put({ reference_link }, "l", true, true)

	vim.cmd("write")
	vim.cmd("edit " .. new_file_path)
end

function GetPythonPath()
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

function GetRootPattern(...)
	local patterns = { ... }
	return function(bufnr)
		local found = vim.fs.find(patterns, { upward = true, path = vim.api.nvim_buf_get_name(bufnr) })[1]
		return found and vim.fs.dirname(found) or vim.loop.cwd()
	end
end

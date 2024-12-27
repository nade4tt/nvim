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

-- Print current range
function PrintRange()
	local range = vim.fn.getpos("'<") .. "," .. vim.fn.getpos("'>")
	print(range)
end

-- Fix sibaus auto formatting
function FixSibau()
	-- Brackets
	vim.cmd([[%g/(\n/norm Jx]])
	-- Commas
	vim.cmd([[%g/,\n/norm Jx]])
	-- Square brackets
	vim.cmd([[%g/\[\n/norm Jx]])
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

vim.keymap.set("n", "<leader>st", function()
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

-- For runnign AVL tests
vim.keymap.set("n", "<leader>rr", function()
	local filename = vim.fn.expand("%:t")

	vim.ui.input({ prompt = "Test Execution: " }, function(input)
		vim.cmd.vnew()
		vim.cmd.wincmd("L")
		vim.cmd.term()
		job_id = vim.bo.channel

		-- for windows
		vim.fn.chansend(job_id, "powershell" .. "\r")

		if input then
			vim.fn.chansend(job_id, "rr " .. filename .. " " .. input .. "\r")
		else
			vim.fn.chansend(job_id, "rr " .. filename .. "\r")
		end
	end)
end)

-- Toggle checkbox
vim.keymap.set("n", "<CR>", function()
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

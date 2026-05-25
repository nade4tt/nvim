local M = {}

-- Live grep in current buffer
function M.telescope_current_buffer_grep()
	require("telescope.builtin").live_grep({
		search_dirs = { vim.fn.expand("%:p") },
	})
end

-- Live grep, show only matching files
function M.telescope_grep_files()
	require("telescope.builtin").live_grep({ additional_args = { "-l" } })
end

-- Close all buffers not visible in any window
function M.close_invisible_buffers()
	local visible = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		visible[vim.api.nvim_win_get_buf(win)] = true
	end

	local closed = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and not visible[buf] then
			local ok, err = pcall(vim.api.nvim_buf_delete, buf, { force = false })
			if ok then
				closed = closed + 1
			else
				vim.notify("Could not close buffer " .. buf .. ": " .. err, vim.log.levels.WARN)
			end
		end
	end

	vim.notify("Closed " .. closed .. " invisible buffer(s)", vim.log.levels.INFO)
end

return M

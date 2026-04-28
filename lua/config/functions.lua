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

return M

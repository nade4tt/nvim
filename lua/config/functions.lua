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

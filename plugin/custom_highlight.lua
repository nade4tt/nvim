vim.api.nvim_set_hl(0, "DEBUG", { fg = "#FFFFFF", bg = "#FF0000", bold = true })
vim.api.nvim_set_hl(0, "DEBUG", { fg = "#FFFFFF", bg = "#FF0000", bold = true })
vim.api.nvim_set_hl(0, "INFO", { fg = "#000000", bg = "#E6E600", bold = true })

local highlight_on = false

-- create a new function
local function avl_highlight()
	if highlight_on then
		vim.fn.matchdelete(1001)
		vim.fn.matchdelete(1002)
		vim.fn.matchdelete(1003)
		vim.fn.matchdelete(1004)
		vim.fn.matchdelete(1005)
		vim.fn.matchdelete(1006)
		vim.fn.matchdelete(1007)
		vim.fn.matchdelete(1008)
		highlight_on = false
	else
		vim.fn.matchadd("DEBUG", ".*breakpoint().*", 1, 1001)
		vim.fn.matchadd("DEBUG", '.*print("breakpoint").*', 1, 1002)
		vim.fn.matchadd("DEBUG", ".*COF.*False.*", 1, 1003)
		vim.fn.matchadd("DEBUG", ".*am.home*", 1, 1004)
		vim.fn.matchadd("DEBUG", ".*am.topology*", 1, 1005)
		vim.fn.matchadd("DEBUG", ".*app_manip*", 1, 1006)
		vim.fn.matchadd("DEBUG", ".*app_manip as am*", 1, 1007)
		vim.fn.matchadd("INFO", [[\v.*test_CMTEST_\d+.*\n?.*line \d+, in \w+]], 1, 1008)
		highlight_on = true
	end
end

vim.api.nvim_create_user_command("AvlHighlightPtest", avl_highlight, {})

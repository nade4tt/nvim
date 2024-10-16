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

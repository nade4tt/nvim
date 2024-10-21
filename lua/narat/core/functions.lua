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


function reverse_selected_lines()
  local start_line, _, end_line, _ = unpack(vim.fn.getpos("'<"))
  local lines = vim.fn.getline(start_line, end_line)
  
  -- Reverse the lines
  local reversed_lines = {}
  for i = #lines, 1, -1 do
    table.insert(reversed_lines, lines[i])
  end

  -- Replace the original lines with reversed lines
  vim.fn.setline(start_line, reversed_lines)
end

-- Call this function after selecting lines in visual mode
vim.api.nvim_set_keymap('v', '<leader>r', ':lua reverse_selected_lines()<CR>', { noremap = true, silent = true })

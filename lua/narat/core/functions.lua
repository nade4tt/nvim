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
  local current_file = vim.fn.expand("%:p")
  local file_extension = vim.fn.expand("%:e")

  vim.cmd.vnew()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 10)
  vim.cmd.term()
  job_id = vim.bo.channel

  if file_extension == "py" then
    vim.fn.chansend(job_id, "python " .. current_file .. "\n")
  end
end)

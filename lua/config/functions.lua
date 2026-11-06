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


-- Save file to remote (RH9)
local remote_sync = {
  host = "simarlw000011",
  local_root = "C:/github/platform-sdt-test",
  remote_root = "/home/u23c66/platform-sdt-test",
}

local function normalize(path)
  return path:gsub("\\", "/")
end

function M.save_and_sync()
  vim.cmd("write")

  local file = normalize(vim.fn.expand("%:p"))
  local local_root = normalize(remote_sync.local_root)

  if file:sub(1, #local_root) ~= local_root then
    vim.notify("File not under configured local root, skipping sync", vim.log.levels.WARN)
    return
  end

  local rel = file:sub(#local_root + 1):gsub("^/", "")
  local remote_path = remote_sync.remote_root .. "/" .. rel
  local cmd = { "scp", file, remote_sync.host .. ":" .. remote_path }

  vim.fn.jobstart(cmd, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("Synced to remote", vim.log.levels.INFO)
      else
        vim.notify("Remote sync failed (exit " .. code .. ")", vim.log.levels.ERROR)
      end
    end,
  })
end

return M

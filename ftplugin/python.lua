-- require("nvim-tree").setup {
--   diagnostics = {
--     enable = false,
--   },
-- }
-- function SaveOnRemote()
--     local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
--     local newPath = filename:gsub("C:\\", "\\\\SIMARWD010080\\")
--     vim.cmd("w! ".. newPath)
-- end
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.textwidth = 0

local job_id = 0

if vim.fn.has("win32") == 1 then
  -- Disable format on save

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
else
  vim.keymap.set("n", "<leader>rr", ":!python %<CR>", { noremap = true })
end

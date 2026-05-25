local keymap = require("utils").keymap

-- require("nvim-tree").setup {
--   diagnostics = {
--     enable = false,
--   },
-- }
-- function SaveOnRemote()
-- 	local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
-- 	local newPath = filename:gsub("C:\\", "\\\\SIMARWD010080\\")
-- 	vim.cmd("w! " .. newPath)
-- end

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.textwidth = 0

vim.opt.formatoptions:remove({ "t", "c", "a" })

local function save_to_avl_pc()
	local src_file = vim.fn.expand("%:p")
	local dst_file = src_file:gsub("^/home/narat/avl/", "/mnt/c/github/")
	vim.cmd("w! " .. dst_file)
	print("Saved to: " .. dst_file)
end

keymap({ "n", "t" }, "<F9>", save_to_avl_pc)

-- iron.nvim REPL (Python only)
local view = require("iron.view")
local common = require("iron.fts.common")

require("iron").setup({
	config = {
		scratch_repl = true,
		repl_definition = {
			sh = {
				command = { "zsh" },
			},
			python = {
				command = function()
					local venv = os.getenv("VIRTUAL_ENV")
					if venv then
						return { "ptpython" }
					else
						return { "ptpython" }
					end
				end,
				format = common.bracketed_paste_python,
				block_dividers = { "# %%", "#%%" },
				env = { PYTHON_BASIC_REPL = "1" }, -- needed for python3.13+
			},
		},
		repl_filetype = function(bufnr, ft)
			return ft
		end,
		dap_integration = true,
		repl_open_cmd = {
			view.split.vertical.rightbelow("%40"), -- cmd_1: open a repl to the right
			view.split.rightbelow("%25"),          -- cmd_2: open a repl below
		},
	},
	keymaps = {
		toggle_repl = "<space>rr",
		restart_repl = "<space>RR",
		send_motion = "<space>sc",
		visual_send = "<space>sc",
		send_file = "<space>sf",
		send_line = "<space>sl",
		send_paragraph = "<space>sp",
		send_until_cursor = "<space>su",
		send_mark = "<space>sm",
		send_code_block = "<space>sb",
		send_code_block_and_move = "<space>sn",
		mark_motion = "<space>mc",
		mark_visual = "<space>mc",
		remove_mark = "<space>md",
		cr = "<space>s<cr>",
		interrupt = "<space>s<space>",
		exit = "<space>sq",
		clear = "<space>cl",
	},
	highlight = {
		italic = true,
	},
	ignore_blank_lines = true,
})

local keymap = require("utils").keymap

vim.pack.add({
	{ src = "https://github.com/kylechui/nvim-surround", name = "surround", version = vim.version.range("4.x") },
})

require("nvim-surround").setup()

-- ys{motion}{char}  → add surround around a motion
-- yss               → add surround around current line
-- cs{old}{new}      → change surrounding pair
-- ds{char}          → delete surrounding pair
-- S{char}           → add surround in visual mode

keymap("n", "ys", "<Plug>(nvim-surround-normal)", { desc = "Add surround around motion" })
keymap("n", "yss", "<Plug>(nvim-surround-normal-cur)", { desc = "Add surround around current line" })
keymap("n", "cs", "<Plug>(nvim-surround-change)", { desc = "Change surrounding pair" })
keymap("n", "ds", "<Plug>(nvim-surround-delete)", { desc = "Delete surrounding pair" })
keymap("x", "S", "<Plug>(nvim-surround-visual)", { desc = "Surround visual selection" })

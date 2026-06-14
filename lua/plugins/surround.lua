vim.pack.add({
	{ src = "https://github.com/kylechui/nvim-surround", name = "surround", version = vim.version.range("4.x") },
})

-- Disable default normal/visual keymaps so we can remap them
vim.g.nvim_surround_no_normal_mappings = true
vim.g.nvim_surround_no_visual_mappings = true

require("nvim-surround").setup()

-- Keymaps (v4 uses <Plug> mappings, not setup keymaps table)
--
-- cs{motion}{char}  → add surround around a motion  (instead of default ys)
-- ds{char}          → delete surround                (same as default)
-- cS{old}{new}      → change surround                (was cs, now cS)
-- S{char}           → add surround in visual mode    (same as default)

vim.keymap.set("n", "cs", "<Plug>(nvim-surround-normal)", { desc = "Add surround around motion" })
vim.keymap.set("n", "css", "<Plug>(nvim-surround-normal-cur)", { desc = "Add surround around current line" })
vim.keymap.set("n", "cS", "<Plug>(nvim-surround-change)", { desc = "Change surrounding pair" })
vim.keymap.set("n", "ds", "<Plug>(nvim-surround-delete)", { desc = "Delete surrounding pair" })
vim.keymap.set("x", "S", "<Plug>(nvim-surround-visual)", { desc = "Surround visual selection" })

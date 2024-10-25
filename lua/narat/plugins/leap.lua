return {
	"ggandor/leap.nvim",
	config = function()
		local leap = require("leap")

		vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
		vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
		vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")

    -- Use `cl` instead of `s` to avoid conflicts with `s` in normal mode
		vim.keymap.set("n", "cl", "s", { noremap = true, silent = true })

		leap.opts.safe_labels = {}
		leap.opts.preview_filter = function()
			return false
		end
	end,
}

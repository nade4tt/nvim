return {
	"ggandor/leap.nvim",
	config = function()
		local leap = require("leap")

		vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
		vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
		vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")

		-- Use `cl` instead of `s` to avoid conflicts with `s` in normal mode
		vim.keymap.set("n", "cl", "s", { noremap = true, silent = true })

		-- Disable auto-jumping to the first match
		-- leap.opts.safe_labels = {}

		-- Disable previewing labels (labels preview as soon as you press the first character)
		leap.opts.preview_filter = function()
			return false
		end

		-- Disable graying out the search area
		vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'None' })
	end,
}

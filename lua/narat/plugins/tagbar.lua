return {
	"preservim/tagbar",
	setup = function()
		local keymap = require("narat.core.utils").keymap
		keymap("n", "<F2>", "<cmd>TagbarToggle<CR>")
	end,
}

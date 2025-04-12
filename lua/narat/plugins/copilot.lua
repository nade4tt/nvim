return {
	"github/copilot.vim",
	setup = function()
		local substitute = require("copilot")
		substitute.setup()

		local keymap = require("narat.core.utils").keymap
		keymap("n", "<F3>", "<CMD>CopilotToggle<CR>")
		keymap("i", "<C-j>", "<Plug>(copilot-next)")
		keymap("i", "<C-k>", "<Plug>(copilot-previous)")
		keymap("i", "<C-\\>", "<Plug>(copilot-dismiss)")
	end,
}

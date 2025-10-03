return {
	"theprimeagen/harpoon",

	config = function()
		require("harpoon").setup({
			menu = {
				width = vim.api.nvim_win_get_width(0) - 4,
			},
		})

		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		local keymap = require("narat.core.utils").keymap

		keymap("n", "<leader>a", mark.add_file)
		keymap("n", "<leader>w", ui.toggle_quick_menu)

		keymap("n", "<C-1>", function()
			ui.nav_file(1)
		end)
		keymap("n", "<C-2>", function()
			ui.nav_file(2)
		end)
		keymap("n", "<C-3>", function()
			ui.nav_file(3)
		end)
		keymap("n", "<C-4>", function()
			ui.nav_file(4)
		end)
	end,
}

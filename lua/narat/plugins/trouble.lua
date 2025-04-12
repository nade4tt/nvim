return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	opts = {},
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble diagnostics toggle" },
		{ "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble Quickfix list" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Loclist" },
		{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Open todos in trouble" },
	},
}

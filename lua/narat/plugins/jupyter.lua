return {
	"kiyoon/jupynium.nvim",
	ft = { "python" },
	config = function()
		require("jupynium").setup({})
	end,
}

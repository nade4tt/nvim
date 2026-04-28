vim.pack.add({ { src = "https://github.com/mfussenegger/nvim-lint", name = "nvim_lint" } })

local lint = require("lint")

lint.linters_by_ft = {
	cpp = { "cpplint" },
	css = { "stylelint" },
	markdown = { "markdownlint" },
	sh = { "shellcheck" },
}

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
	callback = function()
		lint.try_lint()
	end,
})

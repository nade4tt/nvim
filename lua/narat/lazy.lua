local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "narat.plugins" },
	{ import = "narat.plugins.lsp" },
	{ import = "narat.plugins.treesitter" },
	{ import = "narat.plugins.debugger" },
	{ import = "narat.plugins.git" },
	checker = { enabled = false },
})

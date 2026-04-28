-- Essential
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.syntax = "enable"

-- Disable automatic line breaking
vim.opt.formatoptions:remove("t")

-- Clipboard for WSL
if vim.fn.has("win32") == 0 and vim.fn.executable("win32yank.exe") == 1 then
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = { "win32yank.exe", "-i", "--crlf" },
			["*"] = { "win32yank.exe", "-i", "--crlf" },
		},
		paste = {
			["+"] = { "win32yank.exe", "-o", "--lf" },
			["*"] = { "win32yank.exe", "-o", "--lf" },
		},
		cache_enabled = true,
	}
end

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = false

-- Search
vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Splits
vim.opt.splitright = true

-- UI
vim.opt.laststatus = 2
vim.opt.completeopt = { "menu", "popup" }
vim.opt.autoread = true
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.lazyredraw = true
vim.opt.wildmenu = true
vim.opt.history = 1000
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.cmdheight = 1
vim.opt.updatetime = 50
vim.opt.spelllang = "en_us"
vim.opt.colorcolumn = "80"

-- Appearance
vim.opt.winborder = "rounded"
vim.opt.termguicolors = true

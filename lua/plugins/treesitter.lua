vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		main = "nvim-treesitter",
	},
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
	},
	"https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
})

local keymap = require("utils").keymap

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		-- Enable treesitter highlighting and disable regex syntax
		pcall(vim.treesitter.start)
		-- Enable treesitter-based indentation
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

local ensure_installed = {
	"bash",
	"c",
	"c_sharp",
	"cpp",
	"css",
	"dockerfile",
	"gitignore",
	"go",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"mermaid",
	"python",
	"query",
	"rust",
	"scss",
	"sql",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

local alreadyInstalled = require("nvim-treesitter.config").get_installed()
local parsersToInstall = vim.iter(ensure_installed)
	:filter(function(parser)
		return not vim.tbl_contains(alreadyInstalled, parser)
	end)
	:totable()
require("nvim-treesitter").install(parsersToInstall)

-- context
require("treesitter-context").setup({
	enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
	max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
	min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	line_numbers = true,
	multiline_threshold = 20, -- Maximum number of lines to show for a single context
	trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- Separator between context and content. Should be a single character string, like '-'.
	-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	separator = nil,
	zindex = 20, -- The Z-index of the context window
	on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
})

-- textobjects
require("nvim-treesitter-textobjects").setup({
	select = {
		enable = true,
		lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
		selection_modes = {
			["@parameter.outer"] = "v", -- charwise
			["@function.outer"] = "V", -- linewise
			-- ['@class.outer'] = '<c-v>', -- blockwise
		},
		include_surrounding_whitespace = false,
	},
	move = {
		set_jumps = true,
	},
})

-- SELECT
local ts_select = require("nvim-treesitter-textobjects.select").select_textobject
keymap({ "x", "o" }, "am", function()
	ts_select("@function.outer", "textobjects")
end)
keymap({ "x", "o" }, "im", function()
	ts_select("@function.inner", "textobjects")
end)
keymap({ "x", "o" }, "ac", function()
	ts_select("@class.outer", "textobjects")
end)
keymap({ "x", "o" }, "ic", function()
	ts_select("@class.inner", "textobjects")
end)
keymap({ "x", "o" }, "as", function()
	ts_select("@local.scope", "locals")
end)

-- SWAP
local ts_swap = require("nvim-treesitter-textobjects.swap")
keymap("n", "<leader>a", function()
	ts_swap.swap_next("@parameter.inner")
end)
keymap("n", "<leader>A", function()
	ts_swap.swap_previous("@parameter.outer")
end)

-- MOVE
local ts_move = require("nvim-treesitter-textobjects.move")
keymap({ "n", "x", "o" }, "]m", function()
	ts_move.goto_next_start("@function.outer", "textobjects")
end)
keymap({ "n", "x", "o" }, "]]", function()
	ts_move.goto_next_start("@class.outer", "textobjects")
end)
-- You can also pass a list to group multiple queries.
keymap({ "n", "x", "o" }, "]o", function()
	ts_move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm` or `folds.scm`
keymap({ "n", "x", "o" }, "]s", function()
	ts_move.goto_next_start("@local.scope", "locals")
end)
keymap({ "n", "x", "o" }, "]z", function()
	ts_move.goto_next_start("@fold", "folds")
end)

keymap({ "n", "x", "o" }, "]M", function()
	ts_move.goto_next_end("@function.outer", "textobjects")
end)
keymap({ "n", "x", "o" }, "][", function()
	ts_move.goto_next_end("@class.outer", "textobjects")
end)

keymap({ "n", "x", "o" }, "[m", function()
	ts_move.goto_previous_start("@function.outer", "textobjects")
end)
keymap({ "n", "x", "o" }, "[[", function()
	ts_move.goto_previous_start("@class.outer", "textobjects")
end)

keymap({ "n", "x", "o" }, "[M", function()
	ts_move.goto_previous_end("@function.outer", "textobjects")
end)
keymap({ "n", "x", "o" }, "[]", function()
	ts_move.goto_previous_end("@class.outer", "textobjects")
end)

-- Go to either the start or the end, whichever is closer.
-- Use if you want more granular movements
-- keymap({ "n", "x", "o" }, "]d", function()
-- 	ts_move.goto_next("@conditional.outer", "textobjects")
-- end)
-- keymap({ "n", "x", "o" }, "[d", function()
-- 	ts_move.goto_previous("@conditional.outer", "textobjects")
-- end)

-- REPEAT MOVE
local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
keymap({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
keymap({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
keymap({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
keymap({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
keymap({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
keymap({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

require("ts_context_commentstring").setup({
	enable_autocmd = false,
	languages = {
		typescript = "// %s",
	},
})

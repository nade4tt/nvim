vim.pack.add({
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-lua/popup.nvim",
	"https://github.com/princejoogie/dir-telescope.nvim",
	"https://github.com/nvim-telescope/telescope-file-browser.nvim",
	{
		src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
		name = "fzf",
	},
})

-- Build fzf native if available
local fzf_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/fzf"
if vim.fn.isdirectory(fzf_path) == 1 then
	vim.fn.system({ "make", "-C", fzf_path })
end

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local telescope = require("telescope")

local file_ignore_patterns =
	{ "node%_modules/.*", "package.json", "package%-lock.json", "%.csproj", "%.png", "%.ttf", "%.lock" }

-- Create a presentable display name for markdown files
local function presentable_name(filepath)
	local name = vim.fn.fnamemodify(filepath, ":t")
	if vim.fn.fnamemodify(filepath, ":e") == "md" then
		name = name:gsub("%d%d%d%d%-%d%d%-%d%d%-", ""):gsub("%.md", ""):gsub("%-", " ")
	end
	return name
end

local function insert_reference_link(prompt_bufnr)
	actions.close(prompt_bufnr)
	local filepath = action_state.get_selected_entry().value
	local link = string.format("- [%s](%s)", presentable_name(filepath), filepath)
	vim.api.nvim_put({ link }, "l", true, true)
end

local shared_mappings = {
	["<C-k>"] = actions.move_selection_previous,
	["<C-j>"] = actions.move_selection_next,
	["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
	["<C-n>"] = actions.cycle_history_next,
	["<C-p>"] = actions.cycle_history_prev,
}

local normal_mappings = vim.tbl_extend("force", shared_mappings, {
	["<C-r>"] = insert_reference_link,
})

local layout_config = {
	horizontal = { preview_width = 0.6, width = 0.9 },
	vertical = { preview_height = 0.5, height = 0.9 },
	center = { width = 0.8, preview_cutoff = 40 },
}

local function layout_strategy()
	local width = vim.fn.winwidth(0)
	local height = vim.fn.winheight(0)
	if width > 160 and height > 40 then
		return "horizontal"
	elseif width > 120 then
		return "vertical"
	else
		return "center"
	end
end

telescope.setup({
	defaults = {
		smart_case = true,
		prompt_prefix = " >",
		color_devicons = true,
		layout_strategy = layout_strategy(),
		layout_config = layout_config,
		initial_mode = "insert",
		file_ignore_patterns = file_ignore_patterns,
		mappings = {
			i = shared_mappings,
			n = normal_mappings,
		},
	},
	pickers = {},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "ignore_case",
		},
		file_browser = {
			hijack_netrw = true,
			mappings = {
				i = shared_mappings,
				n = normal_mappings,
			},
			file_ignore_patterns = file_ignore_patterns,
		},
		telescope_dir = {
			hidden = false,
			follow_symlinks = false,
			file_ignore_patterns = file_ignore_patterns,
			show_preview = true,
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")

local builtin = require("telescope.builtin")
local keymap = require("utils").keymap

keymap("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
keymap("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
keymap("n", "<leader>fB", function()
	telescope.extensions.file_browser.file_browser({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "File browser (current dir)" })
keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
keymap("n", "<leader>fw", builtin.grep_string, { desc = "Grep word under cursor" })
keymap("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
keymap("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })
keymap("n", "<leader>fc", function()
	require("config.functions").telescope_current_buffer_grep()
end, { desc = "Live grep current file" })
keymap("n", "<leader>Ff", "<cmd>Telescope dir find_files<CR>", { desc = "Find files in dir" })
keymap("n", "<leader>Fg", "<cmd>Telescope dir live_grep<CR>", { desc = "Live grep in dir" })
keymap("n", "<leader>fs", function()
	builtin.lsp_document_symbols({
		symbols = { "Class", "Function", "Method", "Component", "Hook" },
	})
end, { desc = "Find symbols" })

-- Resume last telescope picker (or start live_grep on first call)
local telescope_opened = false
keymap("n", "<leader>fh", function()
	if not telescope_opened then
		telescope_opened = true
		builtin.live_grep()
	else
		builtin.resume()
	end
end, { desc = "Resume telescope" })

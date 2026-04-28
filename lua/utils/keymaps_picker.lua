local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")

local MODES = { "n", "i", "v", "x", "o", "t", "c", "s" }

local MODE_LABEL = {
	n = "NOR",
	i = "INS",
	v = "VIS",
	x = "VIS",
	o = "OPR",
	t = "TRM",
	c = "CMD",
	s = "SEL",
}

-- Resolve the rhs of a keymap to a human-readable string
local function resolve_rhs(km)
	if km.desc and km.desc ~= "" then
		return km.desc
	end
	if km.rhs and km.rhs ~= "" then
		return km.rhs
	end
	if km.callback then
		local info = debug.getinfo(km.callback, "S")
		if info and info.short_src then
			local src = info.short_src:gsub(".*/nvim/", "")
			return string.format("<lua> %s:%s", src, info.linedefined)
		end
		return "<lua function>"
	end
	return "?"
end

-- Collect keymaps from all modes, global + buffer-local
local function collect_keymaps()
	local seen = {}
	local results = {}

	local function add(km, source)
		-- deduplicate by mode+lhs
		local key = (km.mode or "?") .. "|" .. (km.lhs or "")
		if seen[key] then
			return
		end
		seen[key] = true

		table.insert(results, {
			mode = km.mode or "?",
			lhs = km.lhs or "",
			rhs = resolve_rhs(km),
			source = source,
			noremap = km.noremap == 1,
		})
	end

	for _, mode in ipairs(MODES) do
		for _, km in ipairs(vim.api.nvim_get_keymap(mode)) do
			add(km, "global")
		end
		for _, km in ipairs(vim.api.nvim_buf_get_keymap(0, mode)) do
			add(km, "buffer")
		end
	end

	table.sort(results, function(a, b)
		if a.mode ~= b.mode then
			return a.mode < b.mode
		end
		return a.lhs < b.lhs
	end)

	return results
end

function M.show_keymaps(opts)
	opts = opts or {}

	local keymaps = collect_keymaps()

	local displayer = entry_display.create({
		separator = "  ",
		items = {
			{ width = 3 }, -- mode label
			{ width = 20 }, -- lhs
			{ remaining = true }, -- description / rhs
		},
	})

	local function make_display(entry)
		return displayer({
			{ MODE_LABEL[entry.mode] or entry.mode, "TelescopeResultsNumber" },
			{ entry.lhs, "TelescopeResultsIdentifier" },
			{ entry.rhs, "TelescopeResultsComment" },
		})
	end

	pickers
		.new(opts, {
			prompt_title = "Keymaps",
			finder = finders.new_table({
				results = keymaps,
				entry_maker = function(entry)
					return {
						value = entry,
						display = make_display,
						ordinal = entry.mode .. " " .. entry.lhs .. " " .. entry.rhs,
						mode = entry.mode,
						lhs = entry.lhs,
						rhs = entry.rhs,
					}
				end,
			}),
			sorter = require("telescope.sorters").get_substr_matcher(),
			attach_mappings = function(prompt_bufnr)
				-- pressing <CR> feeds the lhs into normal mode so you can execute it
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if selection and selection.mode == "n" then
						vim.api.nvim_feedkeys(
							vim.api.nvim_replace_termcodes(selection.lhs, true, false, true),
							"m",
							false
						)
					end
				end)
				return true
			end,
		})
		:find()
end

return M

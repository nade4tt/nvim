local keymap = require("narat.core.utils").keymap

vim.opt.linebreak = true
vim.opt.wrap = false

vim.wo.spell = true
vim.opt.spelllang = "en_us"

vim.opt.fo = "want"
vim.opt.textwidth = 80

-- Hide markups
vim.opt.conceallevel = 3
vim.opt.concealcursor = "nc"

keymap("n", "<F12>", function()
	local conceal_level = vim.api.nvim_get_option_value("conceallevel", {})
	if conceal_level == 0 then
		vim.opt.conceallevel = 3
		vim.opt.concealcursor = "nc"
	else
		vim.opt.conceallevel = 0
		vim.opt.concealcursor = ""
	end
end)

-- Folding
function _G.markdown_foldexpr()
	local lnum = vim.v.lnum
	local line = vim.fn.getline(lnum)
	local heading = line:match("^(#+)%s")
	if heading then
		local level = #heading
		if level == 1 then
			-- Special handling for H1
			if lnum == 1 then
				return ">1"
			else
				local frontmatter_end = vim.b.frontmatter_end
				if frontmatter_end and (lnum == frontmatter_end + 1) then
					return ">1"
				end
			end
		elseif level >= 2 and level <= 6 then
			-- Regular handling for H2-H6
			return ">" .. level
		end
	end
	return "="
end

local function set_markdown_folding()
	vim.opt_local.foldmethod = "expr"
	vim.opt_local.foldexpr = "v:lua.markdown_foldexpr()"
	vim.opt_local.foldlevel = 99

	-- Detect frontmatter closing line
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local found_first = false
	local frontmatter_end = nil
	for i, line in ipairs(lines) do
		if line == "---" then
			if not found_first then
				found_first = true
			else
				frontmatter_end = i
				break
			end
		end
	end
	vim.b.frontmatter_end = frontmatter_end
end

-- Use autocommand to apply only to markdown files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = set_markdown_folding,
})

local function fold_headings_of_level(level)
	-- Move to the top of the file without adding to jumplist
	vim.cmd("keepjumps normal! gg")
	-- Get the total number of lines
	local total_lines = vim.fn.line("$")
	for line = 1, total_lines do
		-- Get the content of the current line
		local line_content = vim.fn.getline(line)
		-- "^" -> Ensures the match is at the start of the line
		-- string.rep("#", level) -> Creates a string with 'level' number of "#" characters
		-- "%s" -> Matches any whitespace character after the "#" characters
		-- So this will match `## `, `### `, `#### ` for example, which are markdown headings
		if line_content:match("^" .. string.rep("#", level) .. "%s") then
			-- Move the cursor to the current line without adding to jumplist
			vim.cmd(string.format("keepjumps call cursor(%d, 1)", line))
			-- Check if the current line has a fold level > 0
			local current_foldlevel = vim.fn.foldlevel(line)
			if current_foldlevel > 0 then
				-- Fold the heading if it matches the level
				if vim.fn.foldclosed(line) == -1 then
					vim.cmd("normal! za")
				end
				-- else
				--   vim.notify("No fold at line " .. line, vim.log.levels.WARN)
			end
		end
	end
end

local function fold_markdown_headings(levels)
	-- I save the view to know where to jump back after folding
	local saved_view = vim.fn.winsaveview()
	for _, level in ipairs(levels) do
		fold_headings_of_level(level)
	end
	vim.cmd("nohlsearch")
	-- Restore the view to jump to where I was
	vim.fn.winrestview(saved_view)
end

keymap("n", "<leader>f1", function()
	vim.cmd("edit!")
	vim.cmd("normal! zR")
	fold_markdown_headings({ 6, 5, 4, 3, 2 })
	vim.cmd("normal! zz")
end)

keymap("n", "<leader>f2", function()
	vim.cmd("edit!")
	vim.cmd("normal! zR")
	fold_markdown_headings({ 6, 5, 4, 3 })
	vim.cmd("normal! zz")
end)

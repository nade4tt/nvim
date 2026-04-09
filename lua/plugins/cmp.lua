vim.pack.add({ { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1"), name = "cmp" } })

local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	group = group,
	once = true,
	callback = function()
		require("blink.cmp").setup({
			keymap = {
				preset = "default",
				list = { selection = { preselect = false, auto_insert = true } },

				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				-- disable a keymap from the preset
				["<C-e>"] = false, -- or {}
				["<C-y>"] = { "accept", "fallback" },

				-- show with a list of providers
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			},
			appearance = {
				nerd_font_variant = "mono",
				use_nvim_cmp_as_default = true,
			},
			completion = {
				documentation = { auto_show = true },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			snippets = { preset = "luasnip" },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		})
	end,
})

return {
	"windwp/nvim-ts-autotag",
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
			-- Also override individual filetype configs, these take priority.
			-- Empty by default, useful if one of the "opts" global settings
			-- doesn't work well in a specific filetype
			per_filetype = {
				["html"] = {
					enable_close = true,
				},
				["javascript"] = {
					enable_close = true,
				},
				["typescript"] = {
					enable_close = true,
				},
				["typescriptreact"] = {
					enable_close = true,
				},
				["javascriptreact"] = {
					enable_close = true,
				},
				["vue"] = {
					enable_close = true,
				},
				["svelte"] = {
					enable_close = true,
				},
			},
			did_setup = function()
				-- This is called after the plugin has been setup
				-- and all filetypes have been configured.
				-- You can use this to set up keymaps or other things
				-- that require the plugin to be fully configured.
			end,
			setup = function()
				-- This is called before the plugin is setup
				-- and before any filetypes are configured.
				-- You can use this to set up keymaps or other things
				-- that require the plugin to be fully configured.
			end,
			get_opts = function()
				-- This is called to get the options for the plugin
				-- and can be used to override the default options.
				-- You can use this to set up keymaps or other things
				-- that require the plugin to be fully configured.
			end,
		})
	end,
}

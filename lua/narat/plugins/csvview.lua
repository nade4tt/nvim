return {
	"hat0uma/csvview.nvim",
	opts = {
		parser = {
			async_chunksize = 50,

			delimiter = {
				ft = {
					csv = ";",
					tsv = "\t",
				},
				fallbacks = {
					",",
					"\t",
					";",
					"|",
					":",
					" ",
				},
			},

			quote_char = '"',
			comments = {},
			comment_lines = nil,
			max_lookahead = 50,
		},
		keymaps = {
			textobject_field_inner = { "if", mode = { "o", "x" } },
			textobject_field_outer = { "af", mode = { "o", "x" } },
			jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
			jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
			jump_next_row = { "<Enter>", mode = { "n", "v" } },
			jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
		},
	},
	cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	parser = {},
	view = {
		min_column_width = 5,

		spacing = 2,

		display_mode = "highlight",

		header_lnum = true,

		sticky_header = {
			enabled = true,

			separator = "─",
		},
	},

	keymaps = {},

	actions = {},
}

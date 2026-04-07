local root_pattern = require("utils").get_root_pattern("compile_commands.json", ".git")

return {
	cmd = { "clangd", "--compile-commands-dir=build" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_dir = root_pattern,
	settings = {
		clangd = {
			fallbackFlags = { "-std=c++17" },
		},
	},
	flags = { debounce_text_changes = 150 },
}

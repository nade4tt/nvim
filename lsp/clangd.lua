return {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
	settings = {
		clangd = {
			fallbackFlags = { "-std=c++17" },
		},
	},
	flags = { debounce_text_changes = 150 },
}

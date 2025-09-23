local root_pattern = GetRootPattern("go.mod", ".git", "go.work")

return {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_dir = root_pattern,
	settings = {
		clangd = {
			fallbackFlags = { "-std=c++17" },
		},
	},
	flags = { debounce_text_changes = 150 },
}

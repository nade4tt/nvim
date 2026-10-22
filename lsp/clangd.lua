return {
	cmd = {
		"clangd",
		"--background-index",
		-- Let clangd query the actual compiler named in compile_commands.json
		-- (e.g. ESP-IDF's xtensa-esp32-elf-gcc / riscv32-esp-elf-gcc) for its
		-- system include paths and built-in defines. Required for any
		-- cross-compiled project (ESP-IDF/FreeRTOS, embedded toolchains, ...),
		-- since clangd's bundled headers don't match a foreign target.
		-- NOTE: this allowlists *any* compiler path found in the compilation
		-- database for execution by clangd; fine for trusted/local projects.
		"--query-driver=**",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	-- ESP-IDF keeps "sdkconfig"/"sdkconfig.defaults" at the project root only
	-- (never inside a component), so prefer those over a generic ".git" root.
	root_markers = {
		{ "sdkconfig", "sdkconfig.defaults" },
		".clangd",
		"compile_commands.json",
		"compile_flags.txt",
		".git",
	},
	init_options = {
		fallbackFlags = { "-std=c++17" },
	},
	capabilities = {
		textDocument = {
			-- Better completion for function calls (e.g. xTaskCreate(...)):
			-- clangd fills in placeholders for the remaining arguments.
			completion = { editsNearCursor = true },
		},
	},
	flags = { debounce_text_changes = 150 },
}

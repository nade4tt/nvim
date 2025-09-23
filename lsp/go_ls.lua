local root_pattern = GetRootPattern("go.mod", ".git", "go.work")

return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = root_pattern,
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = { unusedparams = true },
		},
	},
}

local python_path = GetPythonPath()

return {
	cmd = { "pyright-langserver", "--stdio" }, -- changed from pylsp
	filetypes = { "python" },
	root_markers = { ".git", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" }, -- typical Pyright roots
	settings = {
		python = {
			pythonPath = python_path,
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
				typeCheckingMode = "basic",
				extraPaths = { "numpy", "pandas", "matplotlib" },
			},
		},
	},
}

-- return {
-- 	cmd = { "pylsp" },
-- 	filetypes = { "python" },
-- 	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
-- 	settings = {
-- 		pylsp = {
-- 			plugins = {
-- 				pyflakes = { enabled = true },
-- 				pycodestyle = { enabled = false },
-- 				pylint = {
-- 					enabled = true,
-- 					args = { "--max-line-length=200", "--disable=C0114", "--disable=C0116" },
-- 				},
-- 				preload = {
-- 					modules = { "numpy", "pandas", "matplotlib" },
-- 				},
-- 				jedi = { environment = python_path, jedi_completion = true },
-- 			},
-- 		},
-- 	},
-- }

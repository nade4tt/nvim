local python_path = GetPythonPath()

return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { ".git", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" },

	settings = {
		python = {
			pythonPath = python_path,
			venvPath = vim.fn.getcwd(),
			venv = "venv",
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
				typeCheckingMode = "basic",
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

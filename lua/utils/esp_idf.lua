-- ESP-IDF / FreeRTOS project detection and clangd bootstrap.
--
-- ESP-IDF is cross-compiled (xtensa-esp32-elf-gcc / riscv32-esp-elf-gcc), and
-- `idf.py build` writes GCC-only flags (-mlongcalls, -fno-tree-switch-conversion,
-- ...) into build/compile_commands.json that clangd's driver rejects outright.
-- A project-local `.clangd` fixes this (see CLANGD_TEMPLATE below); clangd
-- picks up `build/compile_commands.json` automatically, and `--query-driver`
-- (configured in lsp/clangd.lua) lets clangd ask the real cross-compiler for
-- its system headers and built-in defines.
local M = {}

local uv = vim.uv or vim.loop

local CLANGD_TEMPLATE = [[
CompileFlags:
  CompilationDatabase: build
  Remove: [-m*, -f*]
  BuiltinHeaders: QueryDriver
]]

local function exists(path)
	return uv.fs_stat(path) ~= nil
end

-- A directory is an ESP-IDF project root if it has an sdkconfig (written
-- after the first `idf.py build`/`set-target`, or committed as
-- sdkconfig.defaults), a finished CMake configure, or a root CMakeLists.txt
-- that bootstraps the build via ESP-IDF's project.cmake. Component
-- directories have their own CMakeLists.txt too, but never these markers.
local function is_idf_root(dir)
	if exists(dir .. "/sdkconfig") or exists(dir .. "/sdkconfig.defaults") then
		return true
	end
	if exists(dir .. "/build/project_description.json") then
		return true
	end
	local cmake = dir .. "/CMakeLists.txt"
	if exists(cmake) then
		for _, line in ipairs(vim.fn.readfile(cmake, "", 30)) do
			if line:find("project%.cmake") then
				return true
			end
		end
	end
	return false
end

-- Walk upward from `start_dir` (a directory) looking for an ESP-IDF project root.
function M.find_root(start_dir)
	-- Normalize to an absolute path without a trailing slash, without
	-- discarding the last path component (`start_dir` is already a directory).
	local dir = vim.fn.fnamemodify(start_dir, ":p"):gsub("/$", "")
	while dir and dir ~= "" do
		if is_idf_root(dir) then
			return dir
		end
		local parent = vim.fs.dirname(dir)
		if not parent or parent == dir then
			break
		end
		dir = parent
	end
	return nil
end

-- Write `root/.clangd` unless it already exists (pass `force` to overwrite).
-- Returns true if the file was (re)written.
function M.write_clangd(root, force)
	local path = root .. "/.clangd"
	if exists(path) and not force then
		return false
	end
	local file = io.open(path, "w")
	if not file then
		vim.notify("esp-idf: could not write " .. path, vim.log.levels.ERROR)
		return false
	end
	file:write(CLANGD_TEMPLATE)
	file:close()
	return true
end

-- Called from ftplugin/c.lua and ftplugin/cpp.lua: silently scaffold a
-- `.clangd` the first time a C/C++ buffer inside an ESP-IDF project opens.
function M.setup()
	local root = M.find_root(vim.fn.expand("%:p:h"))
	if not root then
		return
	end
	if M.write_clangd(root) then
		vim.notify("esp-idf: generated " .. root .. "/.clangd for clangd", vim.log.levels.INFO)
	end
end

vim.api.nvim_create_user_command("EspIdfClangd", function()
	local root = M.find_root(vim.fn.getcwd())
	if not root then
		vim.notify("esp-idf: no ESP-IDF project found (looked for sdkconfig/CMakeLists.txt)", vim.log.levels.WARN)
		return
	end
	M.write_clangd(root, true)
	vim.notify("esp-idf: (re)generated " .. root .. "/.clangd", vim.log.levels.INFO)
	pcall(vim.cmd, "LspRestart clangd")
end, { desc = "(Re)generate .clangd for the current ESP-IDF project" })

return M

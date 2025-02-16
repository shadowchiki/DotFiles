local M = {}

function M.remove_unused_includes()
	local bufnr = vim.api.nvim_get_current_buf()
	local diagnostics = vim.diagnostic.get(bufnr)

	local lines_to_remove = {}

	for _, diag in ipairs(diagnostics) do
		if diag.code == "unused-includes" then
			table.insert(lines_to_remove, diag.lnum)
		end
	end

	table.sort(lines_to_remove, function(a, b)
		return a > b
	end)

	for _, line in ipairs(lines_to_remove) do
		vim.api.nvim_buf_set_lines(bufnr, line, line + 1, false, {})
	end
end

function M.get_class_info()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local namespaces = {}
	local class_name = nil
	local methods = {}

	local namespace_stack = {}
	local inside_class = false

	for _, line in ipairs(lines) do
		-- Detectar namespaces
		if line:match("^%s*namespace%s+([%a_][%w_:]*)%s*") then
			table.insert(namespace_stack, line)
			table.insert(namespaces, line)
		end

		-- Salir de un namespace
		if line:match("^%s*}%s*") and #namespace_stack > 0 then
			table.remove(namespace_stack)
		end

		-- Detectar clase
		local class_match = line:match("^%s*class%s+(%w+)")
		if line:match("^%s*class%s+(%w+)") then
			class_name = class_match
			inside_class = true
		end

		-- Salir de la clase
		if inside_class and line:match("^%s*};") then
			inside_class = false
		end

		-- Detectar constructores, destructores y funciones
		if inside_class then
			local method_match = line:match("^%s*[%w%s%*&]+(%w+)%s*%b()%s*[constvirtualstatic]*%s*;") -- Mejor regex
			if line:match("^%s*[%w%s%*&]+(%w+)%s*%b()%s*[constvirtualstatic]*%s*;") then
				local params = line:match("%((.-)%)") or ""
				table.insert(methods, { name = method_match, params = params })
			end
		end
	end
	-- vim.pretty_print("Namespaces:", namespaces)
	-- vim.pretty_print("Clase:", vim.inspect(class_name))
	-- vim.pretty_print("Métodos:", vim.inspect(methods))
	return {
		namespaces = namespaces,
		class_name = class_name,
		methods = methods,
	}
end

function M.generate_cpp_file()
	local info = M.get_class_info()
	if not info.class_name then
		print("No se encontró ninguna clase en el archivo actual.")
		return
	end

	local h_filename = vim.api.nvim_buf_get_name(0)
	local cpp_filename = h_filename:gsub("%.h$", ".cpp"):gsub("%.hpp$", ".cpp")

	local cpp_lines = {
		'#include "' .. h_filename:match("([^/]+)$") .. '"',
		"",
	}

	-- Abrir namespaces
	for _, ns in ipairs(info.namespaces) do
		table.insert(cpp_lines, ns .. " {")
	end

	-- Agregar implementación de métodos
	for _, method in ipairs(info.methods) do
		local method_def = info.class_name .. "::" .. method.name .. "(" .. method.params .. ")"
		table.insert(cpp_lines, method_def .. " {")
		table.insert(cpp_lines, "    // TODO: Implementar " .. method.name)
		table.insert(cpp_lines, "}")
		table.insert(cpp_lines, "")
	end

	-- Cerrar namespaces
	for _ = 1, #info.namespaces do
		table.insert(cpp_lines, "}")
	end

	-- Escribir el archivo .cpp
	local file = io.open(cpp_filename, "w")
	if file then
		file:write(table.concat(cpp_lines, "\n"))
		file:close()
		-- print("Archivo generado: " .. cpp_filename)
		vim.cmd("edit " .. cpp_filename)
	else
		print("Error al crear el archivo " .. cpp_filename)
	end
end

vim.keymap.set(
	"n",
	"<leader>co",
	M.remove_unused_includes,
	{ desc = "Remove unused includes", noremap = true, silent = true }
)
vim.keymap.set("n", "gh", "<cmd>ClangdSwitchSourceHeader<CR>", { desc = "Swap .hpp/.cpp files" })
vim.keymap.set(
	"n",
	"<Leader>ci",
	M.generate_cpp_file,
	{ desc = "Generate Implementation", noremap = true, silent = true }
)
return M

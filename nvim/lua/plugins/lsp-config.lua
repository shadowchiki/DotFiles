local capabilities = vim.lsp.protocol.make_client_capabilities()
return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			-- angularls = {},
			-- jsonls = {},
			html = {},
			cssls = {},
			-- tailwindcss = {},
			-- kotlin_language_server = {},
			lemminx = {},
			docker_compose_language_service = {},
			dockerls = {},
			-- ts_ls = {},
			-- cmake = {},
			-- clangd = {},
			qmlls = {
				-- -- cmd = { "/opt/Qt/6.9.1/gcc_64/bin/qmlls" },
				-- filetypes = { "qml", "qmljs" },
				--     capabilities = capabilities,
				-- root_dir = function(fname)
				-- 	return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
				-- end,
				-- buildDir = "/home/alejandro/workspace/excursions/build", -- Obligatorio para tipos C++
				-- noCMakeCalls = false, -- Impide CMake rebuild
				-- docDir = "/opt/Qt/Docs/Qt-6.9.1", -- Ruta de archivos .qch
				-- importPaths = { -- Rutas QML adicionales
				-- 	"/opt/Qt/6.9.1/gcc_64/qml",
				-- 	"/home/alejandro/workspace/excursions/build/excursion",
				-- },
				-- single_file_support = true,
			},
		},
	},
}

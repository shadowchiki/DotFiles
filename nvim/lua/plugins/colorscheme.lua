return {
	"rmehri01/onenord.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onenord").setup({
			custom_highlights = {
				["@lsp.type.namespace.cpp"] = { fg = "#C58E60" },
				["@lsp.type.namespace.java"] = { fg = "#C58E60" },
				["@lsp.type.class"] = { fg = "#89C7FA" },
				["@lsp.typemod.method.abstract"] = { fg = "#80F6A7" },
				["@lsp.type.modifier.java"] = { link = "@keyword" },
				["@lsp.mod.importDeclaration.java"] = { link = "@string" },
			},
			custom_colors = {},
		})
		vim.cmd("colorscheme onenord")
	end,
}

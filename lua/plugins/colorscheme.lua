return {
	"uloco/bluloco.nvim",
	lazy = false,
	priority = 1000,
	dependencies = { "rktjmp/lush.nvim" },
	config = function()
		require("bluloco").setup({
			style = "dark",
			transparent = false,
			italics = false,
			terminal = vim.fn.has("gui_running") == 1,
			guicursor = true,
		})

		vim.opt.termguicolors = true
		vim.cmd("colorscheme bluloco")
		-- "navarasu/onedark.nvim",
		-- require("onedark").setup({
		-- 	style = "warmer",
		-- highlights = {
		-- 	["@lsp.type.variable"] = { fg = "#F2F250" },
		-- 	["@lsp.type.property"] = { fg = "#66E1F8" },
		-- 	["@lsp.type.parameter"] = { fg = "#79ABFF" },
		-- 	["@lsp.typemod.variable.declaration"] = { fg = "#F2F250" },
		-- 	["@lsp.typemod.method.declaration"] = { fg = "#1EB540" },
		-- 	["@lsp.type.method"] = { fg = "#A7EC21" },
		-- 	["@lsp.typemod.class"] = { fg = "#1290C3" },
		-- 	["@lsp.typemod.method.static"] = { fg = "96EC3F" },
		-- 	["@lsp.type.interface"] = { fg = "#80F2F6" },
		-- 	["@lsp.type.annotationMember"] = { fg = "#EB4B64" },
		-- 	["@lsp.type.enumMember"] = { fg = "#BDDAF8", fmt = "italic,bold" },
		-- 	["@lsp.type.modifier"] = { fg = "#CC6C1D", fmt = "bold" },
		-- 	["@string"] = { fg = "#17C6A3" },
		-- 	["@keyword.modifier"] = { fg = "#CC6C1D", fmt = "bold" },
		-- 	["@keyword.operator"] = { fg = "#CC6C1D" },
		-- 	["@keyword.import"] = { fg = "#CC6C1D" },
		-- 	["@type.builtin"] = { fg = "#CC6C1D" },
		-- 	["@keyword.return"] = { fg = "#CC6C1D" },
		-- 	["@keyword.exception"] = { fg = "#CC6C1D" },
		-- 	["@keyword.conditional"] = { fg = "#CC6C1D" },
		-- 	["@keyword"] = { fg = "#CC6C1D" },
		-- 	["@keyword.repeat"] = { fg = "#CC6C1D" },
		-- 	["@lsp.typemod.method.abstract"] = { fg = "#80F6A7" },
		-- 	["@lsp.typemod.class.constructor"] = { fg = "#A7EC21" },
		-- 	["@lsp.type.annotation"] = { fg = "#CECC31" },
		-- 	["@attribute"] = { fg = "#CECC31" },
		-- 	["@lsp.type.namespace"] = { fg = "#1290C3" },
		-- 	["@type.tsx"] = { fg = "#F2F250" },
		-- 	["@type.builtin.tsx"] = { fg = "#FF7055" },
		-- 	["@lsp.type.enum"] = { fg = "#B389C5" },
		-- 	["@tag.tsx"] = { fg = "#1290C3" },
		-- },
		-- })
		-- require("onedark").load()
	end,
}

-- This file contains the configuration overrides for specific Neovim plugins.

return {

	-- Add symbols-outline.nvim plugin
	-- Plugin: symbols-outline.nvim
	-- URL: https://github.com/simrat39/symbols-outline.nvim
	-- Description: A tree like view for symbols in Neovim using the Language Server Protocol.
	"simrat39/symbols-outline.nvim",
	cmd = "SymbolsOutline", -- Command to open the symbols outline
	keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } }, -- Keybinding to open the symbols outline
	config = true, -- Use default configuration
}

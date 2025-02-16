-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all text" })
keymap.set("n", "<leader>fh", function()
	local cwd = vim.fn.input("Insert path to find", "", "dir")
	if cwd and cwd ~= "" then
		vim.cmd(":Telescope find_files cwd=" .. cwd)
	end
end, { desc = "Find files from specific route", silent = true })

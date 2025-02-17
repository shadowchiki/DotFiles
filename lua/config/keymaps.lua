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

keymap.set("x", "<leader>re", ":Refactor extract ")
keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")

keymap.set("x", "<leader>rv", ":Refactor extract_var ")

keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

keymap.set("n", "<leader>rI", ":Refactor inline_func")

keymap.set("n", "<leader>rb", ":Refactor extract_block")
keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

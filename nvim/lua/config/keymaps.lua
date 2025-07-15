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

keymap.set("n", "<leader>fH", function()
	vim.cmd(":Telescope find_files cwd=$HOME")
end, { desc = "Find files from $HOME", silent = true })

keymap.set(
	"n",
	"<leader>cp",
	":%s/= 1/override/g<CR>",
	{ desc = "Replace = 1 to override", noremap = true, silent = true }
)
keymap.set("n", "<leader>cf", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format code" })

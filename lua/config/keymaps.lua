-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all text" })
keymap.set("n", "<leader>h", ":b#<CR>", { desc = "Back to prev buffer" })

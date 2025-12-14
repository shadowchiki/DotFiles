-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all text" })
keymap.set("n", "<leader>fH", function()
	local cwd = vim.fn.input("Insert path to find", "", "dir")
	if cwd and cwd ~= "" then
		vim.cmd(":Telescope find_files cwd=" .. cwd)
	end
end, { desc = "Find files from specific route", silent = true })

keymap.set("n", "<leader>fh", function()
	local cwd = vim.fn.input("Insert path to find", vim.fn.expand("$HOME") .. "/", "dir")
	if cwd and cwd ~= "" then
		vim.cmd(":Telescope find_files cwd=" .. cwd)
	end
end, { desc = "Find files from $HOME", silent = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		keymap.set(
			"n",
			"<leader>cp",
			":%s/= 0/override/g<CR>",
			{ desc = "Replace = 0 to override", noremap = true, silent = true }
		)
	end,
})

-- keymap.set("n", "<leader>cf", function()
--   vim.g.autoformat = true
-- 	vim.lsp.buf.format({ async = true })
--   vim.g.autoformat = false
-- end, { desc = "Format code" })

vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open parent directory" })

keymap.set("n", "<leader>bw", function()
	local function get_workspace_root_for_buf(bufnr)
		local clients = vim.lsp.get_clients({ bufnr = bufnr })
		for _, client in ipairs(clients) do
			local workspaces = client.workspace_folders
			if workspaces then
				for _, ws in ipairs(workspaces) do
					return vim.uri_to_fname(ws.uri)
				end
			elseif client.config.root_dir then
				return client.config.root_dir
			end
		end
		return nil
	end

	local bufnr = vim.api.nvim_get_current_buf()
	local current_root = get_workspace_root_for_buf(bufnr) or vim.fn.getcwd()
	local bufs = vim.api.nvim_list_bufs()

	for _, buf in ipairs(bufs) do
		local bufname = vim.api.nvim_buf_get_name(buf)
		local bufroot = get_workspace_root_for_buf(buf)
		if bufname ~= "" and vim.bo[buf].buflisted and not vim.bo[buf].modified then
			if not bufroot or bufroot ~= current_root then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	end
	vim.notify("Buffers out of workspace closed", vim.log.levels.INFO)
end, { desc = "Delete buffers out of workspace" })

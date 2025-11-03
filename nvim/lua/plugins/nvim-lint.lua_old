return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- lint.linters_by_ft = {
		-- 	javascript = { "sonarlint_language_server" },
		-- 	typescript = { "sonarlint_language_server" },
		-- 	json = { "jsonlint" },
		-- 	cpp = { "sonarlint_language_server" },
		-- 	java = { "sonarlint_language_server" },
		-- }
		--
		-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		-- 	callback = function()
		-- 		lint.try_lint()
		-- 	end,
		-- })
	end,
}

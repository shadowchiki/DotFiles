return {
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"cmake",
				"cpp",
				"gitignore",
				"http",
				"java",
				"scss",
				"sql",
				"typescript",
				"javascript",
			},
			query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_events = { "BufWrite", "CursorHold" },
			},
			playground = {
				enable = true,
				disable = {},
				updatetime = 25,
				persist_queries = true,
			},
		},
	},
}

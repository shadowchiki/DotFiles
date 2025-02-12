return {
	{ "saghen/blink.cmp", enabled = false },

	{
		"hrsh7th/nvim-cmp",
		version = false,
		enabled = true,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			{
				"garymjr/nvim-snippets",
				opts = {
					friendly_snippets = true,
				},
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load({
						paths = { vim.fn.stdpath("config") .. "/lua/plugins/snippets" },
					})
				end,
			},
		},
		opts = function(_, opts)
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			opts.sources = opts.sources or {}

			opts.snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			}

			table.insert(opts.sources, { name = "luasnip" })

			if LazyVim.has("nvim-snippets") then
				table.insert(opts.sources, { name = "snippets" })
			end

			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local defaults = require("cmp.config.default")()
			local auto_select = true

			opts.auto_brackets = {}
			opts.completion = {
				completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
			}
			opts.preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None
			opts.mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
				["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
				["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
				["<C-CR>"] = function(fallback)
					cmp.abort()
					fallback()
				end,
				["<tab>"] = function(fallback)
					return LazyVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
				end,
			})
			opts.sources = cmp.config.sources({
				{ name = "lazydev" },
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "luasnip" }, -- Snippets
			}, {
				{ name = "buffer" },
			})
			opts.formatting = {
				format = function(entry, item)
					local icons = LazyVim.config.icons.kinds
					if icons[item.kind] then
						item.kind = icons[item.kind] .. item.kind
					end
					local widths = {
						abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
						menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
					}
					for key, width in pairs(widths) do
						if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
							item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
						end
					end
					return item
				end,
			}
			opts.experimental = {
				ghost_text = vim.g.ai_cmp and {
					hl_group = "CmpGhostText",
				} or false,
			}
			opts.sorting = defaults.sorting
		end,
		main = "lazyvim.util.cmp",
	},
}

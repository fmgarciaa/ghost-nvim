return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Copilot integration
			"zbirenbaum/copilot.lua",
			"zbirenbaum/copilot-cmp",
			-- existing sources
			"hrsh7th/cmp-nvim-lsp",  -- LSP completion source
			"hrsh7th/cmp-buffer",    -- Buffer words completion
			"hrsh7th/cmp-path",      -- Filesystem path completion
			"L3MON4D3/LuaSnip",      -- Snippet engine
			"saadparwaiz1/cmp_luasnip", -- Snippet completion source
		},
		config = function()
			-- setup copilot-cmp _before_ nvim-cmp so the source is registered
			require("copilot_cmp").setup({
				method = "getCompletionsCycling", -- or "getCompletions"
			})

			local cmp = require("cmp")
			local luasnip = require("luasnip")

			local kind_icons = {
				Text = "󰉿",
				Method = "m",
				Function = "󰊕",
				Constructor = "",
				Field = "",
				Variable = "󰆧",
				Class = "󰌗",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰇽",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰊄",
			}

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- Expand snippets
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),       -- Trigger completion
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "copilot", group_index = 2 }, -- Copilot suggestions first
					{ name = "nvim_lsp" },            -- LSP completions
					{ name = "luasnip" },             -- Snippets
					{ name = "buffer" },              -- Current buffer words
					{ name = "path" },                -- Filesystem paths
				}),
				formatting = {
					format = function(entry, vim_item)
						if entry.source.name == "copilot" then
							vim_item.kind = "" -- Copilot icon
							vim_item.menu = "[Copilot]"
						else
							vim_item.kind = kind_icons[vim_item.kind]
							vim_item.menu = ({
								nvim_lsp = "[LSP]",
								luasnip = "[Snip]",
								buffer = "[Buf]",
								path = "[Path]",
							})[entry.source.name]
						end
						return vim_item
					end,
				},
			})
		end,
	},
}

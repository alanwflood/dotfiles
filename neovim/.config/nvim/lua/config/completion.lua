local M = {}

M.setup = function()
	local status_cmp_ok, cmp = pcall(require, "cmp")
	if not status_cmp_ok then
		return
	end

	local status_luasnip_ok, luasnip = pcall(require, "luasnip")
	if not status_luasnip_ok then
		return
	end

	local menu = {
		buffer = " Buffer",
		nvim_lsp = " LSP",
		luasnip = " Snip",
		path = " Path",
		tmux = " Tmux",
		-- orgmode = ' Org',
		-- emoji = ' Emoji',
		-- spell = ' Spell',
		-- conjure = ' Conjure',
	}

	cmp.setup({
		completion = {
			completeopt = "menu,menuone,noinsert",
		},
		sources = {
			{ name = "buffer" },
			{ name = "luasnip" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "tmux" },
			{ name = "emoji" },
			{ name = "spell" },
			{ name = "cmdline" },
			{ name = "calc" },
			-- { name = 'orgmode' },
			-- { name = 'tags' },
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		formatting = {
			format = require("lspkind").cmp_format({
				with_text = true,
				max_width = 100,
				menu = menu,
			}),
		},
		mapping = {
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
			["<Tab>"] = function(fallback)
				if vim.fn.pumvisible() == 1 then
					vim.fn.feedkeys(utils.t("<C-n>"), "n")
				elseif has_luasnip and luasnip.expand_or_jumpable() then
					vim.fn.feedkeys(utils.t("<Plug>luasnip-expand-or-jump"), "")
				else
					fallback()
				end
			end,
			["<S-Tab>"] = function(fallback)
				if vim.fn.pumvisible() == 1 then
					vim.fn.feedkeys(utils.t("<C-p>"), "n")
				elseif has_luasnip and luasnip.jumpable(-1) then
					vim.fn.feedkeys(utils.t("<Plug>luasnip-jump-prev"), "")
				else
					fallback()
				end
			end,
		},
	})

	pcall(function()
		require("nvim-autopairs.completion.cmp").setup({
			map_cr = true, --  map <CR> on insert mode
			map_complete = true, -- it will auto insert `(` after select function or method item
		})
	end)
end

return M

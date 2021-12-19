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
         if cmp.visible() then
            cmp.select_next_item()
         elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
         else
            fallback()
         end
      end,
      ["<S-Tab>"] = function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
         else
            fallback()
         end
      end,
		},
	})
end

return M

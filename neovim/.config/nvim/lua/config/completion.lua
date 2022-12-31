local M = {}

local function t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.setup = function()
	local has_cmp, cmp = pcall(require, "cmp")
	if not has_cmp then
		return
	end

	local has_luasnip, luasnip = pcall(require, "luasnip")
	if not has_luasnip then
		return
	end

	local menu = {
		buffer = " Buffer",
		--[[ cmdline = " Term", ]]
		calc = " Calc",
		emoji = " Emoji",
		luasnip = " Snip",
		nvim_lsp = " LSP",
		path = " Path",
		spell = " Spell",
		tmux = " Tmux",
		tabnine = " AI",
	}

	cmp.setup({
		sources = {
			{
				name = "buffer",
				max_item_count = 10,
				keyword_length = 5,
			},
			{ name = "calc" },
			--[[ { name = "cmdline" }, ]]
			{ name = "emoji" },
			{ name = "luasnip" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "spell" },
			{
				name = "tmux",
				max_item_count = 10,
			},
			{ name = "nvim_lsp_signature_help" },
			{ name = "lsp" },
			{ name = "tabnine" },
		},
		preselect = cmp.PreselectMode.None,
		formatting = {
			format = require("lspkind").cmp_format({
				with_text = true,
				max_width = 100,
				menu = menu,
			}),
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		duplicates = {
			nvim_lsp = 1,
			luasnip = 1,
			buffer = 1,
			path = 1,
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			documentation = {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			},
		},
		experimental = {
			ghost_text = false,
			native_menu = false,
		},
		completion = {
			completeopt = "menu,menuone,noinsert",
			keyword_length = 1,
		},
		mapping = {
			["<Up>"] = cmp.mapping.select_prev_item(),
			["<Down>"] = cmp.mapping.select_next_item(),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-y>"] = cmp.config.disable,
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		},
	})
end

return M

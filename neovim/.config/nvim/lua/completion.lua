return function()
  local completion_loaded = pcall(function()
    local cmp = require 'cmp'
    local has_luasnip, luasnip = pcall(require, 'luasnip')

    cmp.setup {
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      sources = {
        { name = 'buffer' },
        { name = 'nvim_lsp' },
        { name = 'tmux' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'emoji' },
        { name = 'spell' },
      },
      snippet = {
        expand = has_luasnip and function(args)
          luasnip.lsp_expand(args.body)
        end or nil,
      },
      mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = function(fallback)
          if vim.fn.pumvisible() == 1 then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
          elseif luasnip.expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
          else
            fallback()
          end
        end,
        ['<S-Tab>'] = function(fallback)
          if vim.fn.pumvisible() == 1 then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
          elseif has_luasnip and luasnip.jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
          else
            fallback()
          end
        end,
      },
    }
  end)

  if not completion_loaded then
    vim.notify('Completion failed to set up', vim.log.levels.INFO, { title = ':: Local ::' })
  end

  pcall(function()
    require('nvim-autopairs.completion.cmp').setup {
      map_cr = true, --  map <CR> on insert mode
      map_complete = true, -- it will auto insert `(` after select function or method item
    }
  end)
end


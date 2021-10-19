return function()
  local utils = require 'utils'

  local completion_loaded = pcall(function()
    local cmp = require('cmp')
    local has_luasnip, luasnip = pcall(require, 'luasnip')

    cmp.setup {
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      sources = {
        { name = 'buffer' },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'tmux' },
        -- { name = 'orgmode' },
        -- { name = 'tags' },
      },
      snippet = {
        expand = has_luasnip and function(args)
          luasnip.lsp_expand(args.body)
        end or nil,
      },
      formatting = {
        format = function(entry, item)
            item.kind = lsp_symbols[item.kind]
            item.menu = ({
                buffer = "[Buffer]",
                luasnip = "[Snippet]",
                nvim_lsp = "[LSP]",
                path = "[Path]",
                tmux = "[Tmux]",
            })[entry.source.name]

            return item
        end,
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
            vim.fn.feedkeys(utils.t '<C-n>', 'n')
          elseif has_luasnip and luasnip.expand_or_jumpable() then
            vim.fn.feedkeys(utils.t '<Plug>luasnip-expand-or-jump', '')
          else
            fallback()
          end
        end,
        ['<S-Tab>'] = function(fallback)
          if vim.fn.pumvisible() == 1 then
            vim.fn.feedkeys(utils.t '<C-p>', 'n')
          elseif has_luasnip and luasnip.jumpable(-1) then
            vim.fn.feedkeys(utils.t '<Plug>luasnip-jump-prev', '')
          else
            fallback()
          end
        end,
      },
    }
  end)

  if not completion_loaded then
    utils.notify 'Completion failed to set up'
  end

  pcall(function()
    require('nvim-autopairs.completion.cmp').setup {
      map_cr = true, --  map <CR> on insert mode
      map_complete = true, -- it will auto insert `(` after select function or method item
    }
  end)
end

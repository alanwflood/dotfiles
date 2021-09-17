local M = {}

function M.find_files()
  require('telescope.builtin').find_files {
    previewer = false,
    hidden = true,
    follow = true,
    -- results_height = 50,
    find_command = {
      'fd',
      '--hidden',
      '--follow',
      '--no-ignore-vcs',
      '-t',
      'f',
    },
    prompt_title = string.format(
      '%s/',
      vim.fn.fnamemodify(vim.loop.cwd(), ':~')
    ),
    prompt_prefix = ' ',
  }
end

function M.setup()
  require('telescope').setup {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = false, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = 'smart_case',
      },
    },
    defaults = {
      selection_caret = '▶ ',
      -- winblend = 30,
      layout_strategy = 'flex',
      layout_config = {
        width = 0.95,
        prompt_position = 'top',
        horizontal = {
          preview_width = 0.6,
        },
        vertical = {
          mirror = true,
        },
      },
      mappings = {
        n = {
          ['q'] = require('telescope.actions').close,
        }
      },
      sorting_strategy = 'ascending',
      generic_sorter = require('telescope.sorters').get_fzy_sorter,
      file_sorter = require('telescope.sorters').get_fzy_sorter,
    },
  }

  require('telescope').load_extension 'fzf'

  local opts = { noremap = true, silent = true }
  -- Quick shortcuts
  vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers { sort_lastused = true }<CR>]], opts)
  vim.api.nvim_set_keymap('n', '<C-p>', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], opts)

  -- Buffers
  vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').buffers { sort_lastused = true }<CR>]], opts)
  vim.api.nvim_set_keymap('n', '<leader>sc', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opts)

  -- Files
  vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], opts)
  vim.api.nvim_set_keymap('n', '<leader>sa', [[<cmd>lua require('telescope.builtin').find_files { hidden = true } <CR>]], opts)
  vim.api.nvim_set_keymap('n', '<leader>sr', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)

  -- Tags
  vim.api.nvim_set_keymap('n', '<leader>s?', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
  vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
  vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags { only_current_buffer = true }<CR>]], opts)

  -- Grep
  vim.api.nvim_set_keymap('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
  vim.api.nvim_set_keymap('n', '<leader>sg', [[<cmd>lua require('telescope.builtin').live_grep({ prompt_prefix="🔍" })<CR>]], opts)

  vim.api.nvim_set_keymap('n', 'z=', [[<cmd>lua require('telescope.builtin').spell_suggest()<CR>]], opts)
end

return M


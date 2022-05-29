local M = {}

function M.find_files()
  require("telescope.builtin").find_files({
    previewer = false,
    hidden = true,
    follow = true,
    -- results_height = 50,
    find_command = {
      "fd",
      "--hidden",
      "--follow",
      "--no-ignore-vcs",
      "-t",
      "f",
    },
    prompt_title = string.format("%s/", vim.fn.fnamemodify(vim.loop.cwd(), ":~")),
    prompt_prefix = " ",
  })
end

function M.setup()
  local has_telescope, telescope = pcall("telescope")
  local has_trouble, trouble = pcall("trouble")

  if not has_telescope then
    return
  end

  local actions = require("telescope.actions")
  local sorters = require("telescope.sorters")

  local mappings = {
    n = {
      ["q"] = actions.close,
      ["<c-t>"] = has_trouble and trouble.open_with_trouble,
    },
    i = {
      ["<c-t>"] = has_trouble and trouble.open_with_trouble,
      ["<C-u>"] = false,
    },
  }

  telescope.setup({
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = false, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case",
      },
    },
    defaults = {
      selection_caret = "▶ ",
      -- winblend = 30,
      layout_strategy = "flex",
      layout_config = {
        width = 0.95,
        prompt_position = "top",
        horizontal = {
          preview_width = 0.6,
        },
        vertical = {
          mirror = true,
        },
      },
      mappings = mappings,
      sorting_strategy = "ascending",
      generic_sorter = sorters.get_fzy_sorter,
      file_sorter = sorters.get_fzy_sorter,
    },
  })

  telescope.load_extension("fzf")
end

return M

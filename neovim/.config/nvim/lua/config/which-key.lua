local M = {}

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
    spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
}

local leader = {
  mappings = {
    ["<space>"] = { '<cmd>lua require(telescope.builtin).buffers { sort_lastused = true}<CR>', 'Buffers' },
    ['<C-space>'] = { '<cmd>Telescope resume<CR>', 'Last Search' },
    s = {
      -- Set in telescope.lua
      name = "Search",
      b = { '<cmd>lua require(telescope.builtin).buffers { sort_lastused = true }<CR>', 'Buffers' },
      c = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", "In Current Buffer" },
      f = {  "<cmd>lua require('telescope.builtin').find_files()<CR>", "Files" },
      F = { "<cmd>lua require('telescope.builtin').find_files { hidden = true }<CR>", "All Files" },
      r = { "<cmd>lua require('telescope.builtin').oldfiles()<CR>", "Recent Files" },
      ['?'] = { "<cmd>lua require('telescope.builtin').help_tags()<CR>", "Help Tags",},
      t = { "<cmd>lua require('telescope.builtin').tags()<CR>", "Tags" },
      o = { "<cmd>lua require('telescope.builtin').tags { only_current_buffer = true }<CR>", "Tags in Current Buffer" },
      s = { "<cmd>lua require('telescope.builtin').grep_string({ prompt_prefix='🔍' })<CR>", "Grep String" },
      g = { "<cmd>lua require('telescope.builtin').live_grep({ prompt_prefix='🔍' })<CR>", "Grep" },
      l = { "<cmd>lua require('telescope.builtin').resume()<CR>", 'Last Search' },
    },
    l = {
      -- Set in lsp.lua
      name = "LSP",
      a = { "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", "Code Action" },
      d = { 'Go to definition' },
      D = { 'Go to declaration' },
      e = { 'Show diagnostics' },
      f = { 'Format buffer' },
      i = { 'Go to implementation' },
      l = { 'Diagnostics list' },
      p = { 'Preview definition' },
      r = { 'Rename' },
      R = { 'List references' },
      s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
      S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
        "Workspace Symbols",
      },
      w = {
        name = "Workspace",
        a = { 'Add workspace' },
        d = { 'Delete workspace' },
        l = { 'List workspaces' },
      }
    },
    g = {
      name = 'Git',
      g = { "<cmd>Git<CR>", "Open Fugitive" },
      b = { "Blame line" },
      B = { "<dmd>Git blame<CR>", "Open Blame" },
      d = { "<cmd>DiffviewOpen<CR>", "Open Diffview" },
      o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
      C = { "<cmd>Telescope git_bcommits<CR>", "Checkout commit (for current file)" },
      h = {
        name = 'Hunk',
        s = { "Stage hunk" },
        u = { "Undo stage hunk"},
        r = { "Reset hunk"},
        R = { "Reset buffer"},
        p = { "Preview hunk"},
        S = { "Stage buffer"},
        U = { "Reset buffer index"},
      },
    },
    t = {
      name = 'File Tree',
      t = {"<cmd>NvimTreeToggle<CR>", "Toggle file tree"},
      r = {"<cmd>NvimTreeRefresh<CR>", "Refresh file tree"},
      f = {"<cmd>NvimTreeFindFile<CR>", "Find file in tree"}
    },
  },
  opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }
};

-- Vim Unimpaired, LSP, Gitsigns bindings
local other = {
  mappings = {
    ["z="] = { "<cmd>lua require('telescope.builtin').spell_suggest()<CR>", 'Correct Spelling',},
    ["<C-p>"] = { "<cmd>lua require('telescope.builtin').find_files()<CR>", 'Find Files',},
    ["["] = {
      ['<space>'] = { 'Add [count] blank lines above' },
      a = { 'Previous file' },
      A = { 'First file' },
      b = { 'Previous buffer' },
      B = { 'First buffer' },
      l = { 'Previous location list' },
      L = { 'First location list' },
      ["<C-L>"] = { 'Previous file location list' },
      q = { 'Previous Quick fix list' },
      Q = { 'First Quick fix list' },
      ["<C-Q>"] = { 'Previous file Quick fix list' },
      t = { 'Previous tag' },
      T = { 'First tag' },
      ["<C-T>"] = { 'Previous tag preview' },
      e = { 'Exchange line above [count]' },
      c = { 'Previous SCM hunk' }, -- Gitsigns
      f = { 'Previous file in directory' },
      n = { 'Previous SCM conflict' },
      d = { 'Previous diagnostic' },
      x = { 'XML encode' },
      u = { 'Url encode' },
      C = { 'C string encode' },
      o = {
        name = "+enable",
        b = { "background dark" },
        c = { "cursorline" },
        d = { "diff" },
        h = { "hlsearch" },
        i = { "ignorecase" },
        l = { "list" },
        n = { "number" },
        r = { "relativenumber" },
        s = { "spell" },
        u = { "cursorcolumn" },
        v = { "virtualedit" },
        w = { "wrap" },
        x = { "cursorline & cursorcolumn" },
      },
    },
    ["]"] = {
      ['<space>'] = { 'Add [count] blank lines below' },
      a = { 'Next file' },
      A = { 'Last file' },
      b = { 'Next buffer' },
      B = { 'Last buffer' },
      l = { 'Next location list' },
      L = { 'Last location list' },
      ["<C-L>"] = { 'Next file location list' },
      q = { 'Next Quick fix list' },
      Q = { 'Last Quick fix list' },
      ["<C-Q>"] = { 'Next file Quick fix list' },
      t = { 'Next tag' },
      T = { 'Last tag' },
      ["<C-T>"] = { 'Next tag preview' },
      e = { 'Exchange line below [count]' },
      c = { 'Next SCM hunk' }, -- Gitsigns
      f = { 'Next file in directory' },
      n = { 'Next SCM conflict' },
      d = { 'Next diagnostic' },
      x = { 'XML decode' },
      u = { 'Url decode' },
      C = { 'C string decode' },
      o = {
        name = "+disable",
        b = { "background light" },
        c = { "cursorline" },
        d = { "diff" },
        h = { "hlsearch" },
        i = { "ignorecase" },
        l = { "list" },
        n = { "number" },
        r = { "relativenumber" },
        s = { "spell" },
        u = { "cursorcolumn" },
        v = { "virtualedit" },
        w = { "wrap" },
        x = { "cursorline & cursorcolumn" },
      },
    },
    ["y"] = {
      o = {
        name = "+toggle",
        b = { "background" },
        c = { "cursorline" },
        d = { "diff" },
        h = { "hlsearch" },
        i = { "ignorecase" },
        l = { "list" },
        n = { "number" },
        r = { "relativenumber" },
        s = { "spell" },
        u = { "cursorcolumn" },
        v = { "virtualedit" },
        w = { "wrap" },
        x = { "cursorline & cursorcolumn" },
        g = {
          name = "+git signs",
          b = {":Gitsigns toggle_current_line_blame<CR>", "Toggle Inline Blame"},
          g = {":Gitsigns toggle_signs<CR>", "Toggle Column Signs"},
          n = {":Gitsigns toggle_numhl<CR>", "Toggle Line Number Highlight"},
          l = {":Gitsigns toggle_linehl<CR>", "Toggle Line Highlight"},
          w = {":Gitsigns toggle_word_diff<CR>", "Toggle Word Diff"},
        }
      },
    },
  },
  opts = {
    silent = true,
    noremap = true,
    nowait = true,
  }
}

function M.setup()
  local wk_exists, wk = pcall(require, 'which-key');

  if not wk_exists then
    return
  end

  wk.setup(setup)
  wk.register(leader.mappings, leader.opts)
  wk.register(other.mappings, other.opts)
end

return M
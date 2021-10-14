local wk_exists, wk = pcall(require, 'which-key');

if not wk_exists then
  return
end

wk.register({
  ["<space>"] = { 'Buffers' },
  ['<C-space>'] = { 'Last Search' },
  s = {
    -- Set in telescope.lua
    name = "Search",
    a = { "All Files" },
    b = { "Buffers" },
    c = { "Current Buffer" },
    f = { "Files" },
    r = { "Recent Files" },
    ['?'] = { "Help Tags" },
    t = { "Tags" },
    o = { "Tags in Current Buffer" },
    s = { "Grep String" },
    g = { "Grep" },
    l = { 'Last Search' },
  },
  l = {
    -- Set in lsp.lua
    name = "LSP",
    a = { 'Perform code action' },
    d = { 'Go to definition' },
    D = { 'Go to declaration' },
    e = { 'Show diagnostics' },
    f = { 'Format buffer' },
    i = { 'Go to implementation' },
    l = { 'Open diagnostics list' },
    p = { 'Preview definition' },
    r = { 'Rename' },
    s = { 'Search for references' },
    w = {
      name = "Workspace",
      a = { 'Add workspace' },
      d = { 'Delete workspace' },
      l = { 'List workspaces' },
    }
  },
  g = {
    name = 'Git',
    g = { ":Git<cr>", "Open Fugitive" },
    b = { ":Git blame<cr>", "Open Blame" },
    d = { ":DiffviewOpen<cr>", "Open Diffview" },
    c = { ":Telescope git_commits<cr>", "View Commits" },
    s = { ":Telescope git_status<cr>", "View Current Status" },
    h = {
      name = 'Hunk',
      s = {"<cmd>lua require'gitsigns'.stage_hunk()<cr>", "Stage hunk"},
      u = {"<cmd>lua require'gitsigns'.undo_stage_hunk()<cr>", "Undo stage hunk"},
      r = {"<cmd>lua require'gitsigns'.reset_hunk()<cr>", "Reset hunk"},
      R = {"<cmd>lua require'gitsigns'.reset_buffer()<cr>", "Reset buffer"},
      p = {"<cmd>lua require'gitsigns'.preview_hunk()<cr>", "Preview hunk"},
    },
  },
  t = {
    name = 'Toggles',
    g = {
      name = 'Git Signs',
      b = {":Gitsigns toggle_current_line_blame<CR>", "Toggle Inline Blame"},
      g = {":Gitsigns toggle_signs<CR>", "Toggle Column Signs"},
      n = {":Gitsigns toggle_numhl<CR>", "Toggle Line Number Highlight"},
      l = {":Gitsigns toggle_linehl<CR>", "Toggle Line Highlight"},
      w = {":Gitsigns toggle_word_diff<CR>", "Toggle Word Diff"},
    },
    t = {":NvimTreeToggle<CR>", "Toogle File Tree"}
  },
  o = {
    name = 'Open',
    t = { "Termimal" }
  }
}, { prefix = "<leader>" });

-- Vim Unimpaired + LSP bindings
wk.register({
  ["["] = {
    ['<space>'] = { 'Add [count] blank lines above' },
    e = { 'Exchange line above [count]' },
    f = { 'Next file in directory' },
    n = { 'Next SCM conflict' },
    d = { 'Next diagnostic' },
    x = { 'XML encode' },
    u = { 'Url encode' },
    c = { 'C string encode' },
    o = {
      name = "+enable",
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
    },
  },
  ["]"] = {
    ['<space>'] = { 'Add [count] blank lines belwo' },
    e = { 'Exchange line below [count]' },
    f = { 'Previous file in directory' },
    n = { 'Previous SCM conflict' },
    d = { 'Previous diagnostic' },
    x = { 'XML decode' },
    u = { 'Url decode' },
    c = { 'C string decode' },
    o = {
      name = "+disable",
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
    },
  },
})

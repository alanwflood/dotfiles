local wk_exists, wk = pcall(require, 'which-key');

if not wk_exists then
  return
end

wk.register({
  s = {
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
    b = {":Gitsigns :toggle_current_line_blame<cr>", "Toggle Inline Blame"},
    g = {":Gitsigns :toggle_signs", "Toggle Git Signs"}
  }
}, { prefix = "<leader>" });

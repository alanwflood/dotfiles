local wk_exists, wk = pcall(require, 'which-key');

if not wk_exists then
  return
end

wk.register({
  s = {
    name = "Search",
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
}, { prefix = "<leader>" })

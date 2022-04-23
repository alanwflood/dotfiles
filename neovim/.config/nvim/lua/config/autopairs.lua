local M = {}

function M.setup()
  local has_autopairs, autopairs = pcall(require, "nvim-autopairs")
  local has_cmp_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
  local has_cmp, cmp = pcall(require, "cmp")

  if has_autopairs and has_cmp_autopairs and has_cmp then
    autopairs.setup({
      close_triple_quotes = true,
      check_ts = true,
      disable_filetype = { "TelescopePrompt", "fzf" },
      fast_wrap = {},
    })
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
end

return M

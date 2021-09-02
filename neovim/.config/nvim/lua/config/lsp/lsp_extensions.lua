return function()
  vim.api.nvim_exec([[
    augroup __Completion
    autocmd!
    autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require'lsp_extensions'.inlay_hints()
    augroup end
  ]], false)
end



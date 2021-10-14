local lsp_extensions_exist = pcall(require, 'lsp_extensions');

return function()
  if not lsp_extensions_exist then return end
  vim.api.nvim_exec([[
    augroup __Completion
    autocmd!
    autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require'lsp_extensions'.inlay_hints()
    augroup end
  ]], false)
end



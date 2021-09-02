return function()
  vim.g.undotree_WindowLayout = 2
  vim.g.undotree_SplitWidth = 50
  vim.g.undotree_SetFocusWhenToggle = 1

  vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeToggle<CR>', { noremap = true, silent = true })
end


local has_lspsaga = pcall(require, 'lspsaga')

if not has_lspsaga then
  return
end

vim.g.is_saga_term_open = false

function FloatTermToggle()
  if vim.g.is_saga_term_open then
    require("lspsaga.floaterm").close_float_terminal()
    vim.g.is_saga_term_open = false
  else
    require("lspsaga.floaterm").open_float_terminal()
    vim.g.is_saga_term_open = true
  end
end

vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>lua FloatTermToggle()<CR>', { noremap = true })

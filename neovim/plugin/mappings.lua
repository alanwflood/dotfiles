-- Movement
-------------------

-- highlight last inserted text
vim.keymap.set("n", "gV", [[`[v`]']], {})

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
vim.keymap.set("x", "<", "<gv", { noremap = true })
vim.keymap.set("x", ">", ">gv", { noremap = true })

-- qq to record, Q to replay
vim.keymap.set("n", "Q", "@@", { noremap = true })

-- For neovim terminal :term, escape insert mode with esc
vim.keymap.set("t", "<esc>", [["\<c-\>\<c-n>"]], { expr = true })

-- Paste without overwriting register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y') -- yank motion
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y') -- yank line

-- Delete into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d') -- delete motion
vim.keymap.set({ "n", "v" }, "<leader>D", '"+D') -- delete line

-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", '"+p') -- paste after cursor
vim.keymap.set("n", "<leader>P", '"+P') -- paste before cursor

vim.api.nvim_create_augroup("TerminalSetup", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	group = "TerminalSetup",
	pattern = "*",
	callback = function()
		vim.opt_local.filetype = "terminal"
		vim.opt_local.number = false
		vim.opt_local.signcolumn = "no"
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = "TerminalSetup",
	pattern = "term://*",
	command = "startinsert",
})

vim.api.nvim_create_autocmd("TermClose", {
	group = "TerminalSetup",
	pattern = "term://*",
	command = "stopinsert",
})

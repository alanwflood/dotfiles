local M = {}

function M.setup()
	local status_ok, toggleterm = pcall(require, "toggleterm")
	if not status_ok then
		return
	end

	toggleterm.setup({
		size = 10,
		cmd = "fish",
		open_mapping = [[<c-\>]],
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = os.getenv("SHELL"),
		float_opts = {
			border = "curved",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	})

	function _G.set_terminal_keymaps()
		local opts = { noremap = true, buffer = 0 }
		vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
		vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
		vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
		vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
		vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
		vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
	end

	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
end

return M

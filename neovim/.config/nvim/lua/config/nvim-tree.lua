return function()
	vim.g.nvim_tree_quit_on_open = 0
	vim.g.nvim_tree_disable_window_picker = 1
	vim.g.nvim_tree_indent_markers = 1
	vim.g.nvim_tree_show_icons = {
		git = 1,
		folders = 0,
		files = 0,
		folder_arrows = 0,
	}

	vim.api.nvim_set_keymap("", "-", ":NvimTreeToggle<CR>", { silent = true })

	local tree_cb = require("nvim-tree.config").nvim_tree_callback
	require("nvim-tree").setup({
		view = {
			width = "10%",
			auto_resize = true,
			mappings = {
				list = {
					{ key = { "<2-RightMouse>", "l", "<C-]>" }, cb = tree_cb("cd") },
					{ key = { "-", "h" }, cb = tree_cb("dir_up") },
				},
			},
		},
		auto_close = true,
		update_focused_file = {
			enable = true,
		},
	})
end

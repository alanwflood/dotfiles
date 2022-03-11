return function()
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
			width = "15%",
			auto_resize = true,
			mappings = {
				list = {
					{ key = { "l" }, cb = tree_cb("edit") },
					{ key = { "h" }, cb = tree_cb("close_node") },
					{ key = { "<2-RightMouse>", "L", "<C-]>" }, cb = tree_cb("cd") },
					{ key = { "H" }, cb = tree_cb("dir_up") },
					{ key = { "-" }, cb = tree_cb("close") },
				},
			},
		},
		auto_close = true,
		update_focused_file = {
			enable = false,
		},
	})
end

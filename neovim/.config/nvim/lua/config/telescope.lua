local M = {}

function M.find_files()
	require("telescope.builtin").find_files({
		previewer = false,
		hidden = true,
		follow = true,
		-- results_height = 50,
		find_command = {
			"fd",
			"--hidden",
			"--follow",
			"--no-ignore-vcs",
			"-t",
			"f",
		},
		prompt_title = string.format("%s/", vim.fn.fnamemodify(vim.loop.cwd(), ":~")),
		prompt_prefix = " ",
	})
end

function M.setup()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local action_layout = require("telescope.actions.layout")
	local sorters = require("telescope.sorters")

	-- Fix code folding not working when entering a buffer from telescope
	vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx", })

	telescope.setup({
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = false, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case",
			},
		},
		defaults = {
			selection_caret = "▶ ",
			-- winblend = 30,
			layout_strategy = "flex",
			layout_config = {
				width = 0.95,
				prompt_position = "top",
				horizontal = {
					preview_width = 0.6,
				},
				vertical = {
					mirror = true,
				},
			},
			mappings = {
				n = {
					["q"] = actions.close,
					["<C-P>"] = action_layout.toggle_preview,
				},
				i = {
					["<C-u>"] = false,
					["<C-P>"] = action_layout.toggle_preview,
				},
			},
			sorting_strategy = "ascending",
			generic_sorter = sorters.get_fzy_sorter,
			file_sorter = sorters.get_fzy_sorter,
		},
	})
	telescope.load_extension("fzf")
	telescope.load_extension("undo")
end

return M

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
	require("telescope").setup({
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
					["q"] = require("telescope.actions").close,
				},
			},
			sorting_strategy = "ascending",
			generic_sorter = require("telescope.sorters").get_fzy_sorter,
			file_sorter = require("telescope.sorters").get_fzy_sorter,
		},
	})

	require("telescope").load_extension("fzf")
end

return M

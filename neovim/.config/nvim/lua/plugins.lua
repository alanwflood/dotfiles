-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

return require("packer").startup({
	function(use)
		-- Package manager
		use({
			"wbthomason/packer.nvim",
			event = "VimEnter",
		})

		use({
			"nvim-lua/plenary.nvim",
			module = "plenary",
		})

		use({
			"tweekmonster/startuptime.vim",
			cmd = "StartupTime",
		})

		use({
			"max397574/better-escape.nvim",
			event = "InsertEnter",
			config = function()
				require("better_escape").setup({
					mapping = { "jk", "jj", "kj" },
					timeout = vim.o.timeoutlen,
					clear_empty_lines = true,
					keys = "<Esc>",
				})
			end,
		})

		-- Useful shortcuts for commands
		use({
			"tpope/vim-unimpaired",
			event = "VimEnter",
		})

		-- "gc" to comment visual regions/lines
		use({
			"terrortylor/nvim-comment",
			event = "BufRead",
			config = function()
				require("config.comment").setup()
			end,
		})

		-- 'Add's plenty of sugar syntax for unix commands like, :Move, :Rename, :Mkdir etc,
		use("tpope/vim-eunuch")

		-- Automatic tags management
		use("ludovicchabant/vim-gutentags")

		-- UI to select things (files, grep results, open buffers...)
		use({
			"nvim-telescope/telescope.nvim",
			cmd = "Telescope",
			module = "telescope",
			requires = {
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			},
			config = function()
				require("config.telescope").setup()
			end,
		})

		-- Fancier statusline
		use("itchyny/lightline.vim")

		-- Transparency for all!
		use({
			"xiyaowong/nvim-transparent",
			cmd = { "TransparentToggle", "TransparentEnable", "TransparentEnable" },
		})

		-- Themes
		use("joshdick/onedark.vim") -- Theme inspired by Atom
		use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }) -- Retro style
		use("folke/tokyonight.nvim")

		-- Add indentation guides even on blank lines
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "BufReadPre",
			config = function()
				require("config.indent-blankline").setup()
			end,
		})

		-- Git utils {{{
		use("tpope/vim-fugitive") -- Git commands in nvim
		use({ "sindrets/diffview.nvim", cmd = { "DiffviewOpen" } }) -- Git Diff View for files
		-- Add git related info in the signs columns and popups
		use({
			"lewis6991/gitsigns.nvim",
			event = "BufRead",
			config = function()
				require("config.gitsigns").setup()
			end,
		})
		-- }}}

		-- Auto closes elements
		use({
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
			config = function()
				require("config.autopairs").setup()
			end,
		})

		use({
			"andymass/vim-matchup",
			event = "CursorMoved",
		})

		-- Highlight, edit, and navigate code using a fast incremental parsing library
		use({
			"nvim-treesitter/nvim-treesitter",
			branch = "0.5-compat",
			run = ":TSUpdate",
			config = function()
				require("config.treesitter").setup()
			end,
			requires = {
				{
					-- Additional textobjects for treesitter
					"nvim-treesitter/nvim-treesitter-textobjects",
					after = "nvim-treesitter",
					branch = "0.5-compat",
				},
				{
					"p00f/nvim-ts-rainbow",
					after = "nvim-treesitter",
					config = function()
						require("nvim-treesitter.configs").setup({
							rainbow = {
								enable = true,
								extended_mode = true,
								max_file_lines = 1000,
							},
						})
					end,
				},
			},
		})

		use({
			"norcalli/nvim-colorizer.lua",
			event = "BufReadPre",
			config = function()
				require("colorizer").setup()
			end,
		})

		-- Better Quick Fix window
		use("kevinhwang91/nvim-bqf")
		use("ten3roberts/qf.nvim")

		-- Collection of configurations for built-in LSP client
		use({
			"neovim/nvim-lspconfig",
			requires = {
				"kosayoda/nvim-lightbulb",
				"tjdevries/lsp_extensions.nvim",
				"folke/lua-dev.nvim",
				"williamboman/nvim-lsp-installer",
				{
					"folke/todo-comments.nvim",
					config = function()
						require("todo-comments").setup()
					end,
				},
				{
					"ray-x/lsp_signature.nvim",
					config = function()
						require("lsp_signature").setup({
							hint_prefix = "⏵",
							zindex = 50,
						})
					end,
				},
				{
					"jose-elias-alvarez/null-ls.nvim",
					config = function()
						require("config.null-ls").setup()
					end,
				},
			},
		})

		-- Format runner
		-- use 'mhartington/formatter.nvim'

		-- Snippets plugin
		use({
			"L3MON4D3/LuaSnip",
			wants = "friendly-snippets",
			after = "nvim-cmp",
		})

		use({
			"rafamadriz/friendly-snippets",
			event = "InsertEnter",
		})

		-- Autocompletion plugin
		use({
			"hrsh7th/nvim-cmp",
			config = require("config.completion"),
			requires = {
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "andersevenrud/compe-tmux", branch = "cmp" },
				{ "saadparwaiz1/cmp_luasnip" },
				{ "hrsh7th/cmp-path" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-emoji" },
				{ "f3fora/cmp-spell" },
				{ "onsails/lspkind-nvim" },
			},
		})

		use({
			"editorconfig/editorconfig-vim",
			config = function()
				vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
			end,
		})

		-- Surround plugins
		use({
			"machakann/vim-sandwich",
			config = function()
				require("config.vim-sandwich").setup()
			end,
		})

		-- Extend repeating plugin actions
		use("tpope/vim-repeat")

		-- Make nvim easier to use inside tmux
		use({
			"christoomey/vim-tmux-navigator",
			opt = true,
			cond = function()
				return vim.env.TMUX ~= nil
			end,
			config = function()
				if vim.fn.exists("g:loaded_tmux_navigator") == 0 then
					vim.g.tmux_navigator_disable_when_zoomed = 1
				end
			end,
		})

		-- use { 'kyazdani42/nvim-web-devicons' } -- for file icons
		use({
			"kyazdani42/nvim-tree.lua",
			config = require("config.nvim-tree"),
		})

		-- Make looking up paths easier
		use("tpope/vim-apathy")

		-- Time tracking files
		use({
			"wakatime/vim-wakatime",
			event = "VimEnter",
		})

		-- emacs style which key
		use({
			"folke/which-key.nvim",
			event = "VimEnter",
			config = function()
				require("config.which-key").setup()
			end,
		})
	end,
})

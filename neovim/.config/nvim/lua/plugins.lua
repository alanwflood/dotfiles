-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

return require("packer").startup({
	function(use)
		-- Package manager
		use({ "wbthomason/packer.nvim" })

		-- Optimiser
		use({ "lewis6991/impatient.nvim" })

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

		use({ "kyazdani42/nvim-web-devicons" })

		-- Indent detection
		use({
			"Darazaki/indent-o-matic",
			event = "BufRead",
			config = function()
				require("indent-o-matic").setup({
					max_lines = 2048,
					standard_widths = { 2, 4, 8 },
				})
			end,
		})

		-- Cursorhold fix
		use({
			"antoinemadec/FixCursorHold.nvim",
			event = "BufRead",
			config = function()
				vim.g.cursorhold_updatetime = 100
			end,
		})

		-- Better buffer closing
		use({
			"famiu/bufdelete.nvim",
			cmd = { "Bdelete", "Bwipeout" },
		})

		-- Useful shortcuts for commands
		use({
			"tpope/vim-unimpaired",
			event = "VimEnter",
		})

		-- "gc" to comment visual regions/lines
		use({
			"numToStr/Comment.nvim",
			event = "BufRead",
			config = function()
				require("config.comment").setup()
			end,
		})

		-- Add's plenty of sugar syntax for unix commands like, :Move, :Rename, :Mkdir etc,
		use("tpope/vim-eunuch")

		-- Lots of helpers for string manipulation
		use("tpope/vim-abolish")

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

		-- Terminal
		use({
			"akinsho/nvim-toggleterm.lua",
			config = function()
				require("config.toggleterm").setup()
			end,
		})

		-- Fancier statusline
		use({
			"nvim-lualine/lualine.nvim",
			config = function()
				require("config.statusline").setup()
			end,
		})

		-- Transparency for all!
		use({
			"xiyaowong/nvim-transparent",
			cmd = { "TransparentToggle", "TransparentEnable", "TransparentEnable" },
		})

		-- Add indentation guides even on blank lines
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "BufReadPre",
			config = function()
				require("config.indent-blankline").setup()
			end,
		})

		-- Git utils {{{
		use({
			"tpope/vim-fugitive",
			cmd = {
				"Git",
				"Gstatus",
				"Gblame",
				"Gpush",
				"Gpull",
				"Gclog",
				"G",
				"Gedit",
				"Gsplit",
				"Gdiffsplit",
				"Gvdiffsplit",
				"Ggrep",
				"Ggrep",
				"GRename",
				"GMove",
				"GRemove",
				"GDelete",
				"GBrowse",
			},
		})

		-- Git Diff View for files
		use({ "sindrets/diffview.nvim", cmd = { "DiffviewOpen" } })

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

		-- Highlight, edit, and navigate code using a fast incremental parsing library
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			event = "BufRead",
			cmd = {
				"TSInstall",
				"TSInstallInfo",
				"TSInstallSync",
				"TSUninstall",
				"TSUpdate",
				"TSUpdateSync",
				"TSDisableAll",
				"TSEnableAll",
			},
			config = function()
				require("config.treesitter").setup()
			end,
			requires = {
				{
					-- Additional textobjects for treesitter
					"nvim-treesitter/nvim-treesitter-textobjects",
					after = "nvim-treesitter",
				},
				{
					-- Context based commenting
					"JoosepAlviste/nvim-ts-context-commentstring",
					after = "nvim-treesitter",
				},
				-- Annotation generator
				{
					"danymat/neogen",
					config = function()
						require("neogen").setup({ snippet_engine = "luasnip" })
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
		use({ "kevinhwang91/nvim-bqf", ft = "qf" })
		use({
			"ten3roberts/qf.nvim",
			config = function()
				require("qf").setup({})
			end,
		})
		use({
			"folke/trouble.nvim",
			config = function()
				require("trouble").setup()
			end,
		})

		-- Collection of configurations for built-in LSP client
		use({
			"neovim/nvim-lspconfig",
			requires = {
				-- LSP Installer
				{
					"williamboman/mason.nvim",
					config = function()
						require("mason").setup()
					end,
				},
				-- Bridges Mason with LSP config
				{
					"williamboman/mason-lspconfig.nvim",
					config = function()
						require("mason-lspconfig").setup()
					end,
				},
				-- LSP loading status
				{
					"j-hui/fidget.nvim",
					config = function()
						require("fidget").setup({
							window = {
								relative = "editor", -- where to anchor the window, either `"win"` or `"editor"`
								blend = 0, -- `&winblend` for the window
							},
							text = {
								spinner = "dots",
							},
						})
					end,
				},
				"folke/lua-dev.nvim",
				{
					"folke/todo-comments.nvim",
					requires = "nvim-lua/plenary.nvim",
					config = function()
						require("todo-comments").setup()
					end,
				},
				"jose-elias-alvarez/null-ls.nvim",
				{
					"jayp0521/mason-null-ls.nvim",
					config = function()
						require("config.null-ls").setup()
					end,
				},
				-- LSP enhancer
				{
					"tami5/lspsaga.nvim",
					event = "BufRead",
					config = function()
						require("config.lspsaga").config()
					end,
				},
				-- JSON Schemas
				{ "b0o/SchemaStore.nvim" },
			},
		})

		-- Format runner
		-- use 'mhartington/formatter.nvim'

		-- Snippets plugin
		use({
			"L3MON4D3/LuaSnip",
			require = {
				{ "rafamadriz/friendly-snippets" },
			},
		})

		-- Autocompletion plugin
		use({
			"hrsh7th/nvim-cmp",
			config = function()
				require("config.completion").setup()
			end,
			requires = {
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "andersevenrud/cmp-tmux" },
				{ "saadparwaiz1/cmp_luasnip" },
				{ "hrsh7th/cmp-path" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-cmdline" },
				{ "hrsh7th/cmp-calc" },
				{ "hrsh7th/cmp-emoji" },
				{ "f3fora/cmp-spell" },
				{ "onsails/lspkind-nvim" },
				{ "hrsh7th/cmp-nvim-lsp-signature-help" },
				{ "tzachar/cmp-tabnine", run = "./install.sh" },
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

		-- Make nvim easier to use inside tmux
		use({
			"christoomey/vim-tmux-navigator",
			opt = true,
			cond = function()
				return vim.env.TMUX ~= nil
			end,
			config = function()
				require("config.nvim-tmux-navigation").setup()
			end,
		})

		-- Bufferline
		use({
			"akinsho/bufferline.nvim",
			config = function()
				require("bufferline").setup({
					options = {
						mode = "tabs",
						separator_style = "thick",
						always_show_bufferline = false,
					},
				})
			end,
		})

		-- Show buffer names by each window
		use({
			"b0o/incline.nvim",
			config = function()
				require("incline").setup({
					hide = {
						cursorline = true,
						only_win = true,
					},
				})
			end,
		})

		use({
			"karb94/neoscroll.nvim",
			event = { "BufRead", "BufNewFile" },
			config = function()
				require("neoscroll").setup()
			end,
		})

		use({
			"kyazdani42/nvim-tree.lua",
			config = function()
				require("config.nvim-tree").setup()
			end,
		})

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

		-- DAP {{{
		--[[ use("mfussenegger/nvim-dap") ]]
		--[[ use("rcarriga/nvim-dap-ui") ]]
		--[[ use("theHamsta/nvim-dap-virtual-text") ]]
		-- }}}

		-- Themes
		-- use("joshdick/onedark.vim") -- Theme inspired by Atom
		use("RRethy/nvim-base16")
		use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }) -- Retro style
		-- use({ "rose-pine/neovim", as = "rose-pine" })
		-- use("ful1e5/onedark.nvim")
		-- use("EdenEast/nightfox.nvim")
		-- use("folke/tokyonight.nvim")
		-- use("bluz71/vim-nightfly-guicolors")
	end,
})

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec([[
  augroup Packer
  autocmd!
  autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- "gc" to comment visual regions/lines
  use 'tpope/vim-commentary'

  -- Automatic tags management
  use 'ludovicchabant/vim-gutentags'

  -- UI to select things (files, grep results, open buffers...)
  use {
    'nvim-telescope/telescope.nvim',
    event = 'CursorHold',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      {
        'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
      },
    },
    config = function()
      require('config.telescope').setup()
    end,
  }


  -- Fancier statusline
  use 'itchyny/lightline.vim'

  -- Transparency for all!
  use { 'xiyaowong/nvim-transparent' }

  -- Themes
  use { 'joshdick/onedark.vim' } -- Theme inspired by Atom
  use { "ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"} } -- Retro style

  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'

  -- Git utils {{{
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use { 'sindrets/diffview.nvim', cmd = { 'DiffviewOpen' } } -- Git Diff View for files
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- }}}


  -- Auto closes elements
  use { 'windwp/nvim-autopairs' }
  use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use {
    'nvim-treesitter/nvim-treesitter',
      branch = '0.5-compat',
      run = ':TSUpdate',
      config = require('config.treesitter'),
      requires = {
        {
	  -- Additional textobjects for treesitter
          'nvim-treesitter/nvim-treesitter-textobjects',
          after = 'nvim-treesitter',
          branch = '0.5-compat',
        },
        {
          'p00f/nvim-ts-rainbow',
          after = 'nvim-treesitter',
        },
      },
    }

  use {
    'norcalli/nvim-colorizer.lua',
     config = function()
       require('colorizer').setup()
     end,
  }

  -- Collection of configurations for built-in LSP client
  use {
      'neovim/nvim-lspconfig',
      requires = {
        {
          'kabouzeid/nvim-lspinstall'
        },
        {
          'tjdevries/lsp_extensions.nvim',
          config = function()
            vim.api.nvim_exec([[
              augroup __Completion
              autocmd!
              autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require'lsp_extensions'.inlay_hints()
              augroup end
            ]], false)
          end
        },
        {
          'folke/todo-comments.nvim',
          config = function()
            require('todo-comments').setup {}
          end,
        },
        {
          'https://github.com/glepnir/lspsaga.nvim',
          config = function()
            require('lspsaga').init_lsp_saga {}
          end,
        },
        { 'ray-x/lsp_signature.nvim' },
        { 'folke/lua-dev.nvim' },
      },
    }

  -- Snippets plugin
  use {
    'L3MON4D3/LuaSnip',
    requires = {
      { 'rafamadriz/friendly-snippets' },
    },
  }

  -- Autocompletion plugin
  use {
    'hrsh7th/nvim-cmp',
    config = require 'config.completion',
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'andersevenrud/compe-tmux', branch = 'cmp' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-emoji' },
      { 'f3fora/cmp-spell' },
    },
  }

  -- Surround plugins
  use 'machakann/vim-sandwich'

  -- Extend repeating plugin actions
  use 'tpope/vim-repeat'

  -- Make nvim easier to use inside tmux
  use {
    'christoomey/vim-tmux-navigator',
    opt = true,
    cond = function()
      return vim.env.TMUX ~= nil
    end,
    config = function()
      if vim.fn.exists 'g:loaded_tmux_navigator' == 0 then
        vim.g.tmux_navigator_disable_when_zoomed = 1
      end
    end,
  }

  -- Replace netrw with something sane
  use {
    "mcchrish/nnn.vim",
    cmd = { 'NnnPicker' },
    config = function()
      require("nnn").setup({
        command = "nnn -o -H",
        set_default_mappings = 0,
        replace_netrw = 1,
      })

      -- Fix weird slowdown when opening on osx
      vim.cmd([[
        if system('uname -s') == "Darwin\n"
          let g:nnn#shell = 'zsh'
        endif
      ]], "")
    end
  }

  -- Extends " and @ to show what's contained in those registers
  use {
    'junegunn/vim-peekaboo',
    event = 'BufReadPre',
    config = function()
      vim.g.peekaboo_window = 'vertical botright 60new'
    end,
  }

  -- Make looking up paths easier
  use 'tpope/vim-apathy'

  -- emacs style which key
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end
  }
end)

-- spaces per tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- spaces per tab (when shifting)
vim.opt.shiftwidth = 2

-- always use spaces instead of tabs
vim.opt.expandtab = true

-- don't bother updating screen during macro playback
vim.opt.lazyredraw = true

-- show trailing whitespace
vim.opt.list = true
vim.opt.listchars = {
  tab = '………',
  nbsp = '░',
  extends = '»',
  precedes = '«',
  trail = '·',
}

vim.opt.ruler = true

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.o.background = "dark" -- or "light" for light mode
vim.cmd [[colorscheme gruvbox]]
vim.g.transparent_enabled = true

--Set statusbar
vim.g.lightline = {
  colorscheme = 'gruvbox',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- NNN
vim.api.nvim_set_keymap('n', '-', ':NnnPicker %:p:h<CR>', { noremap = true, silent = true })

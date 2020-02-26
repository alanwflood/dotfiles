let s:VIM_PLUG_FOLDER = expand(g:VIMHOME . '/plugged')
let s:VIM_PLUG_EXE = glob(g:VIMHOME . '/autoload/plug.vim')
let s:CURRENT_FILE = expand('<sfile>')

function! plugins#install_vim_plug() abort
  if empty(s:VIM_PLUG_FOLDER)
    execute 'silent !curl -fLo' . s:VIM_PLUG_EXE . '--create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endfunction

" ============================== PLUGINS INSTALL - 37 Total
function! plugins#install_plugins() abort
  call plug#begin(s:VIM_PLUG_FOLDER)

  " File management
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers.
  Plug 'junegunn/vim-peekaboo'

  " Muh file explorer
  Plug 'tpope/vim-vinegar'

  " Git management
  Plug 'tpope/vim-fugitive'

  " Time management
  Plug 'wakatime/vim-wakatime'

  " matchit.vim enhancement
  Plug 'andymass/vim-matchup'
  " Sensible defaults
  Plug 'tpope/vim-sensible'


  " Vim helpers
  " ============
  " Autoparens
  Plug 'jiangmiao/auto-pairs'

  " Navigate Seamlessly between Vim and Tmux
  Plug 'christoomey/vim-tmux-navigator'

  " provides a bunch of shortcut mappings
  Plug 'tpope/vim-unimpaired'

  " Delete buffers using :Sayonara or :Sayonara!
  Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }

  " Help build up good habbits not use HJKL the whole time
  " Plug 'takac/vim-hardtime'

  " Comment Plugin
  Plug 'tyru/caw.vim'

  " Get context from filetypes for comment plugin
  Plug 'shougo/context_filetype.vim'

  " Allows . commands for non standard actions
  Plug 'tpope/vim-repeat'

  " Wrapping plugin
  Plug 'tpope/vim-surround'

  " Case Sensitive search and replace with :S
  Plug 'tpope/vim-abolish'

  " Figure out indentation based on filetype
  Plug 'tpope/vim-sleuth'

  " Colorful matching parens
  Plug 'junegunn/rainbow_parentheses.vim'

  " Move around files easier
  Plug 'unblevable/quick-scope'

  " Show indents
  Plug 'Yggdroot/indentLine'

  " Status Bar
  Plug 'vim-airline/vim-airline'

  " Linting
  Plug 'dense-analysis/ale', { 'do': 'npm install -g prettier' }

  " Autocomplete
  let g:coc_global_extensions = [
        \ 'coc-css',
        \ 'coc-rls',
        \ 'coc-html',
        \ 'coc-json',
        \ 'coc-python',
        \ 'coc-yaml',
        \ 'coc-emoji',
        \ 'coc-tsserver',
        \ 'coc-ultisnips',
        \ 'coc-github',
        \ 'coc-git',
        \ 'coc-svg',
        \ 'coc-tabnine',
        \ 'coc-tailwindcss'
        \ ]

  Plug 'neoclide/coc.nvim', { 'branch':  'release' }
  Plug 'antoinemadec/coc-fzf'

  Plug 'shougo/echodoc.vim'

  " Snippets management
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'alanwflood/vim-react-snippets'

  " Test Runner
  Plug 'janko/vim-test', {'on': [
        \ 'TestNearest',
        \ 'TestFile',
        \ 'TestSuite',
        \ 'TestSuite',
        \ 'TestVisit'
        \ ]}


  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'amadeus/vim-convert-color-to', {'on': 'ConvertColorTo'}
  " -- Js
  Plug 'heavenshell/vim-jsdoc'
  Plug 'neoclide/vim-jsx-improve'
  Plug 'HerringtonDarkholme/yats.vim'
  " -- Vue
  Plug 'posva/vim-vue', { 'for': ['vue']}
  " -- Reason
  Plug 'reasonml-editor/vim-reason-plus', { 'for': ['reason']}
  " -- Elm
  Plug 'ElmCast/elm-vim', { 'for': ['elm']}
  " -- Everything else
  Plug 'sheerun/vim-polyglot'

  Plug 'morhetz/gruvbox'

  " Emacs style which key menu
  Plug 'liuchengxu/vim-which-key'
  call plug#end()
endfunction

if !exists('*plugins#init')
  function! plugins#init() abort
    exec 'source ' . s:CURRENT_FILE

    if empty(glob(s:VIM_PLUG_FOLDER))
      call plugins#install_vim_plug() | set nomore | call plugins#install_plugins()
    else
      call plugins#install_plugins()
    endif
  endfunction
endif

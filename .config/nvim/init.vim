
" Map the leader key to SPACE
let mapleader="\<SPACE>"
set syntax=on
filetype plugin indent on
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=2           " Render TABs using this many spaces.
set shiftwidth=2        " Indentation amount for < and > commands.filetype plugin indent on
set icm=split
set mouse=a             " I can haz mouse?
set nostartofline       " Do not jump to first character with page commands.
set noerrorbells        " No beeps.
set modeline            " Enable modeline.
set linespace=0         " Set line-spacing to minimum.
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set magic               " Use 'magic' patterns (extended regular expressions).
set background=dark
set noswapfile

highlight LineNr ctermfg=blue "Change numbers color to blue

if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines.
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Change between: no numbers → absolute → relative → relative with absolute on cursor line:
function! NumberToggle()
  :exe 'set nu!' &nu ? 'rnu!' : ''
endfunc


" Toggle between normal and relative numbering.
nnoremap <leader>n :call NumberToggle()<cr>

" Caps Y copys a whole line
nnoremap Y y$

" Move to new splits when opened
nnoremap <C-w>s <C-w>s<C-w>w
nnoremap <C-w>v <C-w>v<C-w>w

" Delete's comment characters when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif






" ============================== PLUGINS INSTALL
call plug#begin('~/.local/share/nvim/plugged')

" File management
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" Git management
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Time management
Plug 'wakatime/vim-wakatime'

" Vim helpers
" ============
Plug 'wellle/targets.vim'
Plug 'tpope/vim-unimpaired'

" Comment Plugin
Plug 'tyru/caw.vim'
" Get context from fieltypes for comment plugin
Plug 'Shougo/context_filetype.vim'
" Allows . commands for non standard actions
Plug 'kana/vim-repeat'
" Wrapping plugin
Plug 'machakann/vim-sandwich'
" Figure out indentation based on filetype
Plug 'conormcd/matchindent.vim'
" Colorful matching parens
Plug 'junegunn/rainbow_parentheses.vim'
" Move around files easier
Plug 'easymotion/vim-easymotion'
Plug 'roman/golden-ratio'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
" Use Tab to expands lots of things
Plug 'ervandew/supertab'

" Status Bar
Plug 'vim-airline/vim-airline'

" Language Server Protocol management
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

" Linting
Plug 'w0rp/ale'

"Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Snippets management
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'alanwflood/vim-react-snippets'
Plug 'isRuslan/vim-es6'

" Additional Syntax
Plug 'sheerun/vim-polyglot'
Plug 'othree/yajs.vim'
Plug 'jparise/vim-graphql'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'posva/vim-vue'

Plug 'hecal3/vim-leader-guide'
call plug#end()





" ============================== PLUGINS CONFIGURATION

"Set indent character
let g:indentLine_char = '┆'

" Don't load golden_radio automagically
let g:golden_ratio_autocommand = 0

" Enable Rainbow parens
au VimEnter * RainbowParentheses
" Blacklist black and dark gray parens
let g:rainbow#blacklist = [233, 234, 235, 236, 237, 238, 239]

" Enable Deoplete
let g:deoplete#enable_at_startup = 1

" UltiSnips config
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-f>"
let g:UltiSnipsJumpBackwardTrigger="<C-b>"

" Configure Language Server
set hidden
let g:LanguageClient_serverCommands = {
\ 'javascript.jsx': ['javascript-typescript-stdio'],
\ 'javascript': ['javascript-typescript-stdio'],
\ 'typescript': ['javascript-typescript-stdio'],
\ 'reason': ['ocaml-language-server', '--stdio'],
\ 'ocaml': ['ocaml-language-server', '--stdio'],
\ 'vue': ['vls'],
\ 'dart': ['dart_language_server'],
\ 'rust': ['rustup', 'run', 'stable', 'rls']
\ }
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Let ale autofix code as it's typed
let g:ale_fixers = {
\ 'javascript': ['prettier'],
\ 'typescript': ['prettier'],
\ 'css': ['prettier'],
\ 'vue':['prettier'],
\ 'rust':['rustfmt']
\ }
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1

" Prefer using syntax plugins for certain languages
let g:polyglot_disabled = ['vue', 'graphql', 'javascript']

" Make airline use some l33t fonts
let g:airline_powerline_fonts = 1





" ============================== FZF/RIPGREP

" ========== files
" Make FZF Use ripgrep
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
" Use ripgrep for vims grep util
set grepprg=rg\ --vimgrep

" ========== words
command! -bang -nargs=* Find call fzf#vim#grep(
\ 'rg --column
\     --line-number
\     --no-heading
\     --ignore-case
\     --hidden
\     --follow
\     --color
\     "always" '
\   .shellescape(<q-args>),
\ 1,
\ fzf#vim#with_preview('right:50%:wrap', '?'))

" ========== word under cursor
command! -bang -nargs=* FindCurrent call fzf#vim#grep(
\ 'rg --column
\     --line-number
\     --no-heading
\     --fixed-strings
\     --ignore-case
\     --hidden
\     --follow
\     --color
\     "always" '
\   .shellescape(expand('<cword>')),
\ 1,
\ fzf#vim#with_preview('right:50%:wrap', '?'))

" ========== most recently used files
command! MRU call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\ 'down': '40%'})

" ==========  Ripgrep integration with fzf
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)





" ============================== Bindings

" Quickly toggle between two buffers
nnoremap <Leader><tab> :e #<CR>

nnoremap ; :    " Use ; for commands.
nnoremap Q @q   " Use Q to execute default register.

" ==> ==> Vim Leader Guide

" Vim leader mapped to space
call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

let g:lmap = {}

" open ranger as netrw in current dir
let g:ranger_map_keys = 0
let g:lmap.r = [':RangerWorkingDirectory', 'Open Ranger']
nnoremap - :Ranger<CR>
let g:ranger_replace_netrw = 1


" ==> Toggles
let g:lmap.t = { 'name' : 'Toggles' }
let g:lmap.t.s = [":ALEToggle", "Syntax Checking"]
" Toggle between normal and relative numbering.
let g:lmap.t.n = [":call NumberToggle()", "Relative Line Numbers"]
let g:lmap.t.g = [":GoldenRatioToggle", "Golden Ratio"]
let g:lmap.t.i = [":IndentLinesToggle", "Indentation Guide"]
let g:lmap.t.p = [":AutoPairsShortcutToggle", "Auto Parens"]
let g:lmap.t.r = [":RainbowParentheses!!", "Rainbow Parens"]

" ==> Easy Motion Bindings
let g:EasyMotion_do_mapping = 0
let g:lmap.e = { 'name' : 'Easymotion' }

" <Leader>f{char} to move to {char}
map  <Leader>ef <Plug>(easymotion-bd-f)
nmap <Leader>ef <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <Leader>ec <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>el <Plug>(easymotion-bd-jk)
nmap <Leader>el <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>ew <Plug>(easymotion-bd-w)
nmap <Leader>ew <Plug>(easymotion-overwin-w)


" ==> Files
let g:lmap.f = { 'name' : 'Files' }
" Open fzf file menu
let g:lmap.f.o = [':FZF', 'Open FZF']
" find and replace word
let g:lmap.f.r = [':%s//g<Left><Left>', 'Find & Replace Word']
" Recently used files
let g:lmap.f.R = [':MRU', 'Most Recently Used Files']
" find file
let g:lmap.f.z = [':Files', 'Find Files']
" find current
let g:lmap.f.c = [':FindCurrent', 'Find In Current Buffer']
" find fuzzy
let g:lmap.f.f = [':Find', 'Find']
" find lines
let g:lmap.f.l = [':Lines', 'Find Lines']

" ==> Search
let g:lmap.s = { 'name' : 'Search' }
" find history
let g:lmap.s.h = [':History', 'History']
" find marks
let g:lmap.s.m = [':Marks', 'Marks']
" find Windows
let g:lmap.s.w = [':Windows', 'Windows']
" Snippets
let g:lmap.s.n = [':Snippets', 'Snippets']

" ==> Git
let g:lmap.g = {'name' : 'Git'}
let g:lmap.g.f = [':GFiles', 'View Files']
let g:lmap.g.F = [':GFiles?', 'View File Status']
let g:lmap.g.s = [' :Gstatus', 'Status']
let g:lmap.g.d = [' :Gdiff', 'Diff']
let g:lmap.g.b = [':Gblame', 'Blame']
let g:lmap.g.e = [':Gedit', 'Edit']
let g:lmap.g.r = [':Gread', 'Read']
let g:lmap.g.w = [':Gwrite', 'Write']
let g:lmap.g.q = [':Gwq', 'Write and Quit']
let g:lmap.g.Q = [':Gwq!', 'Write and Quit!']

let g:lmap.g.c = {'name' : 'Commits'}
let g:lmap.g.c.s = [':Commits', 'View Commits']
let g:lmap.g.c.x = [':Commits', 'View Buffers Commits']
let g:lmap.g.c.c = [':Gcommit', 'Create Commit']

" ==> Help
let g:lmap.h = {'name' : 'Help'}
let g:lmap.h.c = [':Commands', 'View Commands']
let g:lmap.h.h = [':Helptags', 'View Help Tags']
let g:lmap.h.e = [':e ~/.config/nvim/init.vim', 'Edit init.vim']

" ==> Buffers
let g:lmap.b = { 'name' : 'Buffers' }
" find buffer
let g:lmap.b.b = [':Buffers', 'View Buffers']
let g:lmap.b.d = [':Bclose', 'Close Buffer']

" last buffer
let g:lmap.b.l = ['<tab> :e #', 'Last Buffer']

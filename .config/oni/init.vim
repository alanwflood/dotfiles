set nocompatible              " be iMproved, required
filetype off                  " required
syntax on

set number
set noswapfile
set smartcase
set inccommand=split  "Show text about to be replaced

set noshowmode          " Turn off statusbar, because it is externalized
set noruler
set laststatus=0
set noshowcmd
set expandtab           " Expand TABs to spaces
set mouse=a             " Enable GUI mouse behavior
set nostartofline       " Do not jump to first character with page commands.
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set list                " Show problematic characters.
set autoread            " Auto reload changed files
set cursorline          " Highlight cursor line

" Capital Y copys the whole line
noremap Y y$
" Clear search with CTRL-L
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

let mapleader="\<SPACE>" " Set leader to space

" Relative numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines.
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:·,extends:>,precedes:<,nbsp:+
endif

" Delete's comment characters when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/


call plug#begin('~/.config/oni/nvim-pluggins')

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
Plug 'hecal3/vim-leader-guide'
Plug 'conormcd/matchindent.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'easymotion/vim-easymotion'
Plug 'roman/golden-ratio'
Plug 'Yggdroot/indentLine'

Plug 'wellle/targets.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'

" Additional Syntax
Plug 'sheerun/vim-polyglot'
Plug 'jparise/vim-graphql'
Plug 'posva/vim-vue'

call plug#end()



let g:indentLine_char = '┆'
" ============================== FZF/RIPGREP

" ========== files
" Make FZF Use ripgrep
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

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
" Toggles
let g:lmap.t = { 'name' : 'Toggles' }
" Toggle between normal and relative numbering.
let g:lmap.t.n = [":call NumberToggle()", "Relative Line Numbers"]
let g:lmap.t.g = [":GoldenRatioToggle", "Golden Ratio"]
let g:lmap.t.i = [":IndentLinesToggle", "Indentation Guide"]

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
let g:lmap.f.f = [':find', 'Fuzzy Find']
" find lines
let g:lmap.f.l = [':FzfLines', 'Find Lines']

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

" ==> Buffers
let g:lmap.b = { 'name' : 'Buffers' }
" find buffer
let g:lmap.b.b = [':Buffers', 'View Buffers']
let g:lmap.b.d = [':Bclose', 'Close Buffer']

" last buffer
let g:lmap.b.l = ['<tab> :e #', 'Last Buffer']

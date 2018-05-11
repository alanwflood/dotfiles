set nocompatible              " be iMproved, required
filetype off                  " required

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

" Toggle between normal and relative numbering.
nnoremap <leader>r :call NumberToggle()<cr>

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:·,extends:>,precedes:<,nbsp:+
endif

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/


call plug#begin('~/.local/share/nvim/plugged')
Plug 'hecal3/vim-leader-guide'

" File management
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" Git management
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Vim helpers
Plug 'wellle/targets.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'

" Vim helpers
Plug 'conormcd/matchindent.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'easymotion/vim-easymotion'

" Additional Syntax
Plug 'sheerun/vim-polyglot'

call plug#end()

call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>





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







let g:lmap = {}

" open ranger as netrw in current dir
let g:ranger_map_keys = 0
let g:lmap.r = [':RangerWorkingDirectory', 'Open Ranger']
nnoremap - :Ranger<CR>
let g:ranger_replace_netrw = 1

" ==> Files
let g:lmap.f = { 'name' : 'Files' }
" Open fzf file menu
let g:lmap.f.o = [':FZF', 'Open FZF']
" find and replace word
let g:lmap.f.r = [':%s//g<Left><Left>', 'Find & Replace Word']
" find file
let g:lmap.f.f = [':Files', 'Find Files']
nnoremap <Leader>ff :Files<CR>
" find current
let g:lmap.f.c = [':FindCurrent', 'Find In Current']
" find fuzzy
let g:lmap.f.z = [':Find', 'Fuzzy Find']

" ==> Buffers
let g:lmap.b = { 'name' : 'Buffers' }
" find buffer
let g:lmap.b.b = [':Buffers', 'Buffer Search']
let g:lmap.b.d = [':Bclose', 'Close Buffer']

" last buffer
let g:lmap.b.l = ['<tab> :e #', 'Last Buffer']
nnoremap <Leader><tab> :e #<CR>

let g:lmap.t = { 'name' : 'Tabs' }
let g:lmap.t.c = [':tabe', 'Create Tab']
let g:lmap.t.p = [':tabp', 'Previous Tab']
let g:lmap.t.n = [':tabn', 'Next Tab']

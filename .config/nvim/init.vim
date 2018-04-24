" Map the leader key to SPACE
let mapleader="\<SPACE>"
set syntax=on
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=2           " Render TABs using this many spaces.
set shiftwidth=2        " Indentation amount for < and > commands.
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
nnoremap <leader>n :call NumberToggle()<cr>

call plug#begin('~/.local/share/nvim/plugged')
Plug 'hecal3/vim-leader-guide'





" ============================== PLUGINS INSTALL

" File management
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" Git management
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Vim helpers
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'conormcd/matchindent.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'easymotion/vim-easymotion'

Plug 'vim-airline/vim-airline'

" Language Server Protocol management
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

" Linting
Plug 'w0rp/ale'
" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Snippets management
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Additional Syntax
Plug 'sheerun/vim-polyglot'

call plug#end()






" ============================== PLUGINS CONFIGURATION

" Enable Deoplete
let g:deoplete#enable_at_startup = 1

" UltiSnips config
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-n>"
let g:UltiSnipsJumpBackwardTrigger="<C-p>"

" Configure Language Server
set hidden
let g:LanguageClient_serverCommands = { 'javascript': ['javascript-typescript-stdio'] }
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Let ale use prettier in javascript
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1

let g:airline_powerline_fonts = 1





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






" ============================== MAPPINGS

" Vim leader mapped to space
call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

nnoremap ; :    " Use ; for commands.
nnoremap Q @q   " Use Q to execute default register.

let g:lmap = {}

" Toggle Ale
let g:lmap.s = { 'name' : 'Syntax Checking' }
map <leader>st :ALEToggle<CR>

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

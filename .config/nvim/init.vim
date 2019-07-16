
" ============================== General Settings

" === Internal Vim
" Map the leader key to spacebar
let mapleader="\<SPACE>"
filetype plugin indent on
set hidden              " Hide Buffers instead of closing them
set visualbell          " No beeps.
set noerrorbells        " No boops.

" === Searching/Commands
set hlsearch            " highlight search terms
set incsearch           " show search matches as you type
set showcmd             " Show (partial) command in status line.
set showmatch           " Highlight matching brackets.
set inccommand=split    " Shows results of command in a preview window
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set magic               " Use 'magic' patterns (extended regular expressions).

" === Interface/Syntax Highlighting
set syntax=on           " Syntax Highlighting
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
set modeline            " Enable modeline.
set background=dark     " Makes colors brighter to match dark background
set list                " Show problematic characters.

" Change numbers column color to blue
highlight LineNr ctermfg=blue
" Have SignColumn be transparent
highlight clear SignColumn

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines.
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

" === Autocomplete
set shortmess+=c        " don't give |ins-completion-menu| messages.

" === Tabs/Space
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.

" === Controls/Basic Keybinds
set mouse=a             " I can haz mouse scroll?
set nostartofline       " Do not jump to first character with page commands.

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Caps Y copys a whole line
nnoremap Y y$

" Move to new horiz splits when opened
nnoremap <C-w>v <C-w>v<C-w>w

" Disable line numbers when using :term
augroup TerminalStuff
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END
" Remap the escape key in terminal to actually escape terminal input
au TermOpen * tnoremap <Esc> <c-\><c-n> 

" Netrw Remapping
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

" Netrw sane remaps 
function! NetrwMapping()
    map <buffer> l <Enter>
    map <buffer> <Right> <Enter>
    map <buffer> h -
    map <buffer> <Left> -
endfunction
" Remove files with trash so I don't do stupid things
let g:netrw_localrmdir='trash -r'



" === Backups

" Create backups directory
if !isdirectory($HOME . "/.config/nvim/backups")
  call mkdir($HOME . "/.config/nvim/backups", "p")
endif
set backupdir=$HOME/.config/nvim/backups// " Set directory for backups

" Create swapfiles directory
if !isdirectory($HOME . "/.config/nvim/swapfiles")
  call mkdir($HOME . "/.config/nvim/swapfiles", "p")
endif
set directory=$HOME/.config/nvim/swapfiles// " Set directory for swapfiles

" Allows infinite undos in file, deletes undos after 90 days
set undofile
" Create undos directory
if !isdirectory($HOME . "/.config/nvim/undos")
  call mkdir($HOME . "/.config/nvim/undos", "p")
endif
set undodir=$HOME/.config/nvim/undos
let s:undos = split(globpath(&undodir, '*'), "\n")
call filter(s:undos, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
call map(s:undos, 'delete(v:val)')

" Deletes comment characters when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif




" ============================== PLUGINS INSTALL - 37 Total
call plug#begin('~/.local/share/nvim/plugged')

" File management
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers.
Plug 'junegunn/vim-peekaboo'

" Muh file explorer
Plug 'tpope/vim-vinegar'

" Git management
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Time management
Plug 'wakatime/vim-wakatime'

" Vim helpers
" ============
" provides a bunch of shortcut mappings
Plug 'tpope/vim-unimpaired'
" Help build up good habbits not use HJKL the whole time
Plug 'takac/vim-hardtime'
" Comment Plugin
Plug 'tyru/caw.vim'
" Get context from fieltypes for comment plugin
Plug 'Shougo/context_filetype.vim'
" Allows . commands for non standard actions
Plug 'kana/vim-repeat'
" Wrapping plugin
Plug 'machakann/vim-sandwich'
" Figure out indentation based on filetype
Plug 'tpope/vim-sleuth'
" Colorful matching parens
Plug 'junegunn/rainbow_parentheses.vim'
" Move around files easier
Plug 'unblevable/quick-scope'
" Resize Window automagically
Plug 'roman/golden-ratio'
" Show indents
Plug 'Yggdroot/indentLine'
" Case Sensitive search and replace with :S
Plug 'tpope/vim-abolish'
" Status Bar
Plug 'vim-airline/vim-airline'

" Linting
Plug 'w0rp/ale'

"Autocomplete
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Snippets management
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'alanwflood/vim-react-snippets'


" Additional Syntax
" -- Js
Plug 'heavenshell/vim-jsdoc'
Plug 'neoclide/vim-jsx-improve'
Plug 'HerringtonDarkholme/yats.vim'
" -- Vue
Plug 'posva/vim-vue'
" -- Reason
Plug 'reasonml-editor/vim-reason-plus'
" -- Elm
Plug 'ElmCast/elm-vim'
" -- Everything else
Plug 'sheerun/vim-polyglot'

" Emacs style which key menu
Plug 'liuchengxu/vim-which-key'
call plug#end()





" ============================== PLUGINS CONFIGURATION

" God help me
" let g:hardtime_default_on = 1
let g:list_of_normal_keys = ["h", "j", "k", "l", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []

"Set indent character
let g:indentLine_char = '┆'

" Don't load golden_radio automagically
let g:golden_ratio_autocommand = 0

" Enable Rainbow parens
au VimEnter * RainbowParenthes
" Blacklist black and dark gray parens
let g:rainbow#blacklist = range(16, 255)

" Let ale autofix code on save
let g:ale_fixers = {
\ 'c': ['clang-format'],
\ 'cpp': ['clang-format'],
\ 'css': ['prettier'],
\ 'javascript': ['prettier', 'eslint'],
\ 'python': ['autopep8'],
\ 'reason':['refmt'],
\ 'rust':['rustfmt'],
\ 'typescript': ['prettier'],
\ 'vue':['prettier'],
\ }
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1

" Error and warning signs for Ale.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Enable ale integration with airline.
let g:airline#extensions#ale#enabled = 1
" Make airline use some l33t fonts
let g:airline_powerline_fonts = 1

" Prefer using feature rich syntax plugins for specific languages
let g:polyglot_disabled = ['vue', 'javascript',  'typescript',  'jsx', 'elm']

" Allows JsDoc to figure out ES6 function syntax
let g:jsdoc_enable_es6 = 1

" Text Highlighting for Quickscope Plugin
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline




" ============================== FZF/RIPGREP

" ========== files
" Make FZF Use ripgrep
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
" Use ripgrep for vims grep util
set grepprg=rg\ --vimgrep
" Due to the ESC remap in terminal, ESC does not close FZF, this restores that
au FileType fzf tunmap <Esc>

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
\ fzf#vim#with_preview('right:50%:wrap', '?')
\ )

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
\ fzf#vim#with_preview('right:50%:wrap', '?')
\ )

" ========== most recently used files
command! MRU call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\ 'down': '40%'}
\ )





" ============================== Bindings

" Map FZF file finder to Ctrl-p
noremap <C-p> :Files<CR>
" Map FZF Buffer list to  Ctrl-b
nnoremap <C-b> :Buffers<CR>
" Map FZF Buffer list to  Ctrl-b
nnoremap <C-s> :Snippets<CR>
" Use Q to execute default register.
nnoremap Q @q

" Use C-l to expand snippets
let g:UltiSnipsExpandTrigger = "<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" Use tab for completion window
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" ========= Vim Leader Guide
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}

function! FixOnSaveToggle()
    if g:ale_fix_on_save
      let g:ale_fix_on_save = 0
    else
      let g:ale_fix_on_save = 1
    endif
endfunction

" ==> Toggles
let g:which_key_map.t =  {
      \ 'name' : '+toggles',
      \ 'f' : [ ':call FixOnSaveToggle()', 'Fix On Save' ],
      \ 's' : [ ':ALEToggle',               'Linter'],
      \ 'g' : [ ':GoldenRatioToggle',       'Golden Ratio'],
      \ 'i' : [ ':IndentLinesToggle',       'Auto Indentation'],
      \ 'q' : [ ':QuickScopeToggle', 'QuickScope Highlighting'],
      \ 'r' : [ ':RainbowParentheses!!',    'Rainbow Parens'],
      \ }

" ==> Files
let g:which_key_map.f =  {
      \ 'name' : '+files',
      \ 'o' : [':FZF',               'Fuzzy Find File'],
      \ 'r' : [':%s//g<Left><Left>', 'Find & Replace'],
      \ 'R' : [':MRU',               'Recently Used File'],
      \ 'z' : [':Files',             'Find File'],
      \ 'c' : [':FindCurrent',       'Search Current File'],
      \ 'f' : [':Find',              'Fuzzy Find Word'],
      \ 'l' : [':Lines',             'Find Line'],
      \ }

" ==> Search
let g:which_key_map.s = {
      \ 'name' : '+search',
      \ 'h': [':history',  'History'],
      \ 'm': [':marks',    'Marks'],
      \ 'w': [':windows',  'Windows'],
      \ 's': [':Snippets', 'Snippets'],
      \ }

" ==> Help
let g:which_key_map.h = {
      \ 'name' : '+help',
      \ 'c': [':Commands',                  'Commands'],
      \ 'h': [':Helptags',                  'Help Tags'],
      \ 'e': [':e ~/.config/nvim/init.vim', 'Edit init.vim'],
      \ }

" ==> Buffers
let g:which_key_map.b = {
      \ 'name' : '+buffers',
      \ 'l' : [":e #",     "Switch To Last"],
      \ 's' : [":Buffers", "Search"],
      \ 'd' : [":Bclose",  "Close Buffer"],
      \}

" ==> Git Fugitive Bindings
let g:which_key_map.g = {
      \ 'name' : '+git',
      \ 'b' : [':Gblame',   'Blame'],
      \ 'B' : [':Gbrowser', 'Open in Browser'],
      \ 'd' : [':Gdiff',    'Diff'],
      \ 'e' : [':Gedit',    'Edit'],
      \ 'f' : [':GFiles',   'View Files'],
      \ 'F' : [':GFiles?',  'View File Status'],
      \ 's' : [':Gstatus',  'Status'],
      \ 'p' : [':Gpull',    'Pull'],
      \ 'P' : [':Gpush',    'Push'],
      \ 'r' : [':Gread',    'Read'],
      \ 'w' : [':Gwrite',   'Add File'],
      \ 'q' : [':Gwq',      'Add File and Quit'],
      \ 'Q' : [':Gwq!',     'Add File and Quit!'],
      \ 'c' : {
        \'name' : '+commits',
        \ 's' : [':Commits',  'View Commits'],
        \ 'c' : [':Gcommit',  'Create Commit']
        \ },
      \ }

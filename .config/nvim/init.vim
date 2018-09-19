" Map the leader key to SPAC s e
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
set inccommand=split    " Shows results of command in a preview window
set mouse=a             " I can haz mouse?
set nostartofline       " Do not jump to first character with page commands.
set noerrorbells        " No beeps.
set modeline            " Enable modeline.
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set magic               " Use 'magic' patterns (extended regular expressions).
set background=dark
set noswapfile
set list                " Show problematic characters.

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

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Caps Y copys a whole line
nnoremap Y y$

" Move to new horiz splits when opened
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
" extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers.
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
" provides additional text objects
Plug 'wellle/targets.vim'
" provides a bunch of shortcut mappings
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
Plug 'tpope/vim-sleuth'
" Colorful matching parens
Plug 'junegunn/rainbow_parentheses.vim'
" Move around files easier
Plug 'easymotion/vim-easymotion'
Plug 'roman/golden-ratio'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'

" Status Bar
Plug 'vim-airline/vim-airline'

" Language Server Protocol management
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

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
Plug 'neoclide/vim-jsx-improve'
Plug 'jparise/vim-graphql'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'posva/vim-vue'
Plug 'sheerun/vim-polyglot'

" Emacs style which key menu
Plug 'liuchengxu/vim-which-key'
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
\ 'reason': ['~/.config/reason-language-server/reason-language-server.exe'],
\ 'vue': ['vls'],
\ 'dart': ['dart_language_server'],
\ 'rust': ['rustup', 'run', 'stable', 'rls']
\ }

" Let ale autofix code as it's typed
let g:ale_fixers = {
\ 'javascript': ['prettier', 'eslint'],
\ 'typescript': ['prettier'],
\ 'css': ['prettier'],
\ 'vue':['prettier'],
\ 'reason':['refmt'],
\ 'rust':['rustfmt']
\ }
let g:ale_fix_on_save = 0
let g:ale_javascript_prettier_use_local_config = 1

" Error and warning signs for Ale.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Prefer using syntax plugins for certain languages
let g:polyglot_disabled = ['vue', 'graphql', 'javascript', 'jsx']

" Enable ale integration with airline.
let g:airline#extensions#ale#enabled = 1
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
nnoremap ; :Buffers<CR>
" Use Q to execute default register.
nnoremap Q @q


" open ranger as netrw in current dir
let g:ranger_map_keys = 0
nnoremap - :Ranger<CR>
let g:ranger_replace_netrw = 1

" ========= Vim Leader Guide
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}

" ==> Toggles
let g:which_key_map.t =  {
      \ 'name' : '+toggles',
      \ 's' : [ ':ALEToggle',               'Linter'],
      \ 'g' : [ ':GoldenRatioToggle',       'Golden Ratio'],
      \ 'i' : [ ':IndentLinesToggle',       'Auto Indentation'],
      \ 'p' : [ ':AutoPairsShortcutToggle', 'Auto Insert Parens'],
      \ 'r' : [ ':RainbowParentheses!!',    'Rainbow Parens'],
      \ }

" ==> Easy Motion Bindings
let g:EasyMotion_do_mapping = 0
let g:which_key_map.e =  {
      \ 'name' : '+easymotion'
      \ }
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

" ==> Lsp
let g:which_key_map.l = {
      \ 'name' : '+lsp',
      \ 'f' : ['LanguageClient#textDocument_formatting()',     'Formatting'],
      \ 'h' : ['LanguageClient#textDocument_hover()',          'Hover'],
      \ 'r' : ['LanguageClient#textDocument_references()',     'References'],
      \ 'R' : ['LanguageClient#textDocument_rename()',         'Rename'],
      \ 's' : ['LanguageClient#textDocument_documentSymbol()', 'Document-Symbol'],
      \ 'S' : ['LanguageClient#workspace_symbol()',            'Workspace-Symbol'],
      \ 'g' : {
        \ 'name': '+goto',
        \ 'd' : ['LanguageClient#textDocument_definition()',     'Definition'],
        \ 't' : ['LanguageClient#textDocument_typeDefinition()', 'Type-Definition'],
        \ 'i' : ['LanguageClient#textDocument_implementation()', 'Implementation'],
        \ },
      \ }

" ==> Search
let g:which_key_map.s = {
      \ 'name' : '+search',
      \ 'h': [':history',  'History'],
      \ 'm': [':marks',    'Marks'],
      \ 'w': [':windows',  'Windows'],
      \ 's': [':snippets', 'Snippets'],
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
      \ 'f' : [':GFiles',  'View Files'],
      \ 'F' : [':GFiles?', 'View File Status'],
      \ 's' : [':Gstatus', 'Status'],
      \ 'd' : [':Gdiff',   'Diff'],
      \ 'b' : [':Gblame',  'Blame'],
      \ 'e' : [':Gedit',   'Edit'],
      \ 'r' : [':Gread',   'Read'],
      \ 'w' : [':Gwrite',  'Write'],
      \ 'q' : [':Gwq',     'Write and Quit'],
      \ 'Q' : [':Gwq!',    'Write and Quit!'],
      \ 'c' : {
        \'name' : '+commits',
        \ 's' : [':Commits',  'View Commits'],
        \ 'x' : [':Commits',  'View Buffers Commits'],
        \ 'c' : [':Gcommit',  'Create Commit']
        \ },
      \ }

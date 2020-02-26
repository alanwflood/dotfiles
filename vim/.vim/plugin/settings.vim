" ===> File Encoding
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set termencoding=utf-8


" ===> Terminal Bells
set visualbell          " No beeps.
set noerrorbells        " No boops.


" ===> Setting spaces instead of tabs
set tabstop=2           " spaces per tab
set softtabstop=2
set shiftwidth=2        " spaces per tab (when shifting)
set expandtab           " always use spaces instead of tabs


" ===> Searching
set hlsearch             " highlight search terms
set incsearch            " show search matches as you type
set showcmd              " Show (partial) command in status line.
set showmatch            " Highlight matching brackets.
set inccommand=split     " Shows results of command in a preview window
set ic smartcase

" ===> Autoreload files
set autoread

" ===> Tab Completion
" show a navigable menu for tab completion
set wildmode=longest:full,list,full
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.pyc
set wildignore+=*.swp,*~,*/.DS_Store
set tagcase=followscs


" ===> Line Highlighting
augroup LineCommands
  autocmd!
  " autocmd BufWinEnter,BufEnter ?* call utils#setOverLength()
  " autocmd OptionSet textwidth call utils#setOverLength()
  autocmd BufWinEnter,BufEnter * match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'  " highlight VCS conflict markers
augroup END


" ===> Splitting
" Adds more natural splitting
set splitbelow
set splitright


" ===> GUI
" The VIM Gui
if has('windows')
  set fillchars=diff:⣿  " BOX DRAWINGS
  set fillchars+=vert:┃ " HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  set fillchars+=fold:─
endif
" Linebreaks
if has('linebreak')
  let &showbreak='↳  '  " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
endif
set modeline            " Enable modeline.
set background=dark     " Makes colors brighter to match dark background
" Enable true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme gruvbox

set t_ut=
set hidden
set mouse=a


" ===> Syntax
set title
set showmatch           " highlight matching [{()}]
set number              " Show the line numbers on the left side.
" Change numbers column color to blue
highlight LineNr ctermfg=blue
" Have SignColumn be transparent
highlight clear SignColumn

" ===> Macros
set lazyredraw          " don't bother updating screen during macro playback


" ===> Indentation and Joining
if !has('nvim') && (v:version > 703 || v:version == 703 && has('patch541'))
  set formatoptions+=j                " remove comment leader when joining comment lines
endif
set formatoptions+=n                  " smart auto-indenting inside numbered lists
set formatoptions+=r1

" Reveal trailing whitespace
set list
set listchars=nbsp:░,tab:▷\ ,extends:»,precedes:«,trail:•
set nojoinspaces
set concealcursor=n

" Reveal Tabs
" highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/


" ===> Vim Messages
set shortmess+=A   " ignore annoying swapfile messages
set shortmess+=I   " no splash screen
set shortmess+=O   " file-read message overwrites previous
set shortmess+=T   " truncate non-file messages in middle
set shortmess+=W   " don't echo "[w]"/"[written]" when writing
set shortmess+=a   " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o   " overwrite file-written messages
set shortmess+=t   " truncate file messages at start


" ===> TMP Files
" Backups
if exists('$SUDO_USER')
  set nobackup                        " don't create root-owned files
  set nowritebackup                   " don't create root-owned files
else
  let &backupdir=utils#create_dir($VIMHOME.'/tmp/backup') " keep backup files out of the way
endif

" Swapfiles
if exists('$SUDO_USER')
  set noswapfile                      " don't create root-owned files
else
  let &directory=utils#create_dir($VIMHOME.'/tmp/swap') " keep swap files out of the way
endif

if exists('&swapsync')
  set swapsync=                       " let OS sync swapfiles lazily
endif

set updatecount=80                    " update swapfiles every 80 typed chars

" Undos
if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                    " don't create root-owned files
  else
    let &undodir=utils#create_dir($VIMHOME.'/tmp/undo') " keep undo files out of the way
    " actually use undo files
    set undofile
    " Purge unused undos after 90 days
    let s:undos = split(globpath(&undodir, '*'), "\n")
    call filter(s:undos, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
    call map(s:undos, 'delete(v:val)')
  endif
endif


if exists('&guioptions')
  " cursor behavior:
  "   - no blinking in normal/visual mode
  "   - blinking in insert-mode
  set guicursor+=n-v-c:blinkon0,i-ci:ver25-Cursor/lCursor-blinkwait30-blinkoff100-blinkon100
endif

if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

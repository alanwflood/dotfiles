" Caps Y copys a whole line
nnoremap Y y$

" Netrw Remapping
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

" Netrw sane remaps
function! NetrwMapping()
    map <buffer> l <Enter>
    " map <buffer> <Right> <Enter>
    map <buffer> h -
    " map <buffer> <Left> -
endfunction

" For neovim terminal :term
if has('nvim')
  " nnoremap <leader>t  :vsplit +terminal<cr>
  tnoremap <expr> <esc> &filetype == 'fzf' ? "\<esc>" : "\<c-\>\<c-n>"
  tnoremap <M-h> <c-\><c-n><c-w>h
  tnoremap <M-j> <c-\><c-n><c-w>j
  tnoremap <M-k> <c-\><c-n><c-w>k
  tnoremap <M-l> <c-\><c-n><c-w>l
  augroup MyTerm
    autocmd!
    autocmd TermOpen * setl nonumber norelativenumber
    autocmd TermOpen term://* startinsert
    autocmd TermClose term://* stopinsert
  augroup END
endif

" Clear current search
imap <leader><C-l> :noh

" Disable arrow keys
imap <up>    <nop>
imap <down>  <nop>
imap <left>  <nop>
imap <right> <nop>

" Make arrowkey do something usefull, resize the viewports accordingly
nnoremap <silent><Right> :vertical resize -2<CR>
nnoremap <silent><Left> :vertical resize +2<CR>
nnoremap <silent><Down> :resize -2<CR>
nnoremap <silent><Up> :resize +2<CR>

" https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
xnoremap <  <gv
xnoremap >  >gv

" highlight last inserted text
nnoremap gV `[v`]

" Allows you to visually select a section and then hit @ to run a macro on all lines
" https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db#.3dcn9prw6
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo '@'.getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

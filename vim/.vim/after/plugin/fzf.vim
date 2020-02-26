imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" ========== files
" Make FZF Use ripgrep
let $FZF_DEFAULT_COMMAND = 'rg --files'
" Use ripgrep for vims grep util
set grepprg=rg\ --vimgrep

" ========== words
command! -bang -nargs=* Find call fzf#vim#grep(
\ 'rg --column
\     --line-number
\     --no-heading
\     --ignore-case
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

let g:fzf_layout = { 'window': utils#fzf_window() }

" ============================== Bindings

noremap <C-p> :Files<CR>
noremap <C-f> :Find<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-s> :Snippets<CR>

if !exists(':FZF')
  finish
endif

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

let g:fzf_layout = { 'window': utils#fzf_window() }

" ============================== Bindings

noremap <C-p> :Files<CR>
noremap <C-f> :Rg<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-s> :Snippets<CR>

let g:nnn#set_default_mappings = 0
let g:nnn#replace_netrw = 1

" optional args:
"  -e      text in $VISUAL/$EDITOR/vi
"  -o      open files only on Enter
"  -H      show hidden files

" Start nnn in the current file's directory
" Also throws a wildcard error on fish shell so silent shuts it up
nnoremap <silent> - :silent! NnnPicker -H -o -e '%:p:h'<CR>

" Floating window (neovim)
function! s:layout()
  let buf = nvim_create_buf(v:false, v:true)

  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': height * 0.3,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

if utils#has_floating_window()
  let g:nnn#layout =  'call ' . string(function('<SID>layout')) . '()'
endif

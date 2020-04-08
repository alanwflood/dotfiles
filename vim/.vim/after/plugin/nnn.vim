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

  let height = &lines - (float2nr(&lines / 2))
  let width = float2nr(&columns - (&columns * 1 / 2))

  let opts = {
        \ 'relative': 'editor',
        \ 'row': 2,
        \ 'col': 8,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

if utils#has_floating_window()
  let g:nnn#layout =  'call ' . string(function('<SID>layout')) . '()'
endif

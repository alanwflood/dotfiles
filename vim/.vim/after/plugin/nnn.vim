let g:nnn#set_default_mappings = 0
" let g:nnn#replace_netrw = 1

" optional args:
"  -e      text in $VISUAL/$EDITOR/vi
"  -o      open files only on Enter
"  -H      show hidden files

" Start nnn in the current file's directory
" Also throws a wildcard error on fish shell so silent shuts it up
nnoremap <silent> <leader>- :silent! NnnPicker -H -o -e '%:p:h'<CR>

" if utils#has_floating_window()
"   let g:nnn#layout =  'call utils#CreateCenteredFloatingWindow()'
" endif

highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline,bold
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline,bold

" Text Highlighting for Quickscope Plugin
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#ff1493' gui=underline,bold ctermfg=155 cterm=underline,bold
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline,bold ctermfg=40 cterm=underline,bold

  " Disable for certain filetypes
  autocmd FileType preview,qf,fzf,netrw,help,diff,gitcommit let b:qs_local_disable=1
augroup END

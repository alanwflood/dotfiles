" Text Highlighting for Quickscope Plugin
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

  " Disable for certain filetypes
  autocmd FileType preview,qf,fzf,netrw,help,diff,gitcommit let b:qs_local_disable=1
augroup END

augroup MyAutoCmds
  autocmd!
  " Automatically make splits equal in size
  autocmd VimResized * wincmd =

  " Close preview buffer with q
  autocmd FileType * if utils#should_quit_on_q() | nmap <buffer> <silent> <expr>  q &diff ? ':qa!<cr>' : ':q<cr>' | endif
  " Disable QuickScope too
  autocmd FileType preview,qf,fzf | let b:qs_local_disable=1 | endif

  " taken from
  " https://github.com/jeffkreeftmeijer/vim-numbertoggle/blob/cfaecb9e22b45373bb4940010ce63a89073f6d8b/plugin/number_toggle.vim
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif

  " See https://github.com/neovim/neovim/issues/7994
  autocmd InsertLeave * set nopaste

  autocmd FileType gitcommit,gina-status,todo,qf setlocal cursorline
augroup END

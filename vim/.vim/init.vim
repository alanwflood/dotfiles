" ============================== General Settings
let g:VIMHOME = exists('*stdpath') ? stdpath('config') : expand(exists('$XDG_CONFIG_HOME') ? $XDG_CONFIG_HOME.'/nvim' : $HOME.'/.config/nvim')
let g:VIMDATA = exists('*stdpath') ? stdpath('data')   : expand(exists('$XDG_DATA_HOME')   ? $XDG_DATA_HOME.'/nvim'   : $HOME.'/.local/share/nvim')



" === Internal Vim
" Map the leader key to spacebar
let mapleader="\<SPACE>"
let maplocalleader=','


call plugins#init()
call utils#setupCompletion()


" After this file is sourced, plug-in code will be evaluated.
" See ~/.vim/after for files evaluated after that.
" See `:scriptnames` for a list of all scripts, in evaluation order.
" Launch Vim with `vim --startuptime vim.log` for profiling info.
"
" To see all leader mappings, including those from plug-ins:
"
"   vim -c 'set t_te=' -c 'set t_ti=' -c 'map <space>' -c q | sort

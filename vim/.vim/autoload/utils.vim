function! utils#setupCompletion() abort
  let g:UltiSnipsExpandTrigger='<c-u>'
  let g:UltiSnipsJumpForwardTrigger='<c-j>'
  let g:UltiSnipsJumpBackwardTrigger='<c-k>'

  let g:coc_snippet_next='<c-j>'
  let g:coc_snippet_prev='<c-k>'

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  inoremap <silent><expr> <c-space> coc#refresh()

  " imap <silent> <C-x><C-o> <Plug>(coc-complete-custom)
  imap <silent> <C-x><C-u> <Plug>(coc-complete-custom)
  " Use `[c` and `]c` for navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  " nmap <silent> gd <Plug>(coc-definition)
  " nmap <silent> gy <Plug>(coc-type-definition)
  " nmap <silent> gi <Plug>(coc-implementation)
  " nmap <silent> gr <Plug>(coc-references)

  nmap <leader>rn <Plug>(coc-rename)

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Use K for show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  " Show signature help while editing
  augroup MY_COC
    autocmd!
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end
endfunction

function! utils#has_floating_window() abort
  " MenuPopupChanged was renamed to CompleteChanged -> https://github.com/neovim/neovim/pull/9819
  return (exists('##MenuPopupChanged') || exists('##CompleteChanged')) && exists('*nvim_open_win')
endfunction

function! utils#create_dir(dir) abort
  if !isdirectory(a:dir)
      call mkdir(a:dir, "p")
  endif
  return a:dir
endfunction

function! utils#open() abort
  " Linux/BSD
  if executable('xdg-open')
    return 'xdg-open'
  endif
  " MacOS
  if executable('open')
    return 'open'
  endif
  " Windows
  return 'explorer'
endfunction

let g:FileTypeQuitOnQ = ['preview', 'qf', 'fzf', 'netrw', 'help', 'taskedit', 'diff']
function! utils#should_quit_on_q() abort
  return &diff || index(g:FileTypeQuitOnQ, &filetype) >= 0
endfunction
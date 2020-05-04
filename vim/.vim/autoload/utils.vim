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

function! utils#fzf_window() abort
  return utils#has_floating_window() ? 'call utils#CreateCenteredFloatingWindow()' : 'enew'
endfunction

function! utils#CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

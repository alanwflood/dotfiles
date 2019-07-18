scriptencoding utf-8

if !exists(':ALEInfo')
  finish
endif

let g:ale_set_signs = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_delay = 0

let g:ale_fix_on_save = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_list_window_size = 5

" Use local prettier config
let g:ale_javascript_prettier_use_local_config = 1

" Let ale autofix code on save
let g:ale_fixers = {
      \   '*'         : ['remove_trailing_lines', 'trim_whitespace'],
      \   'markdown'  : ['prettier'],
      \   'javascript': ['prettier'],
      \   'typescript': ['prettier'],
      \   'vue'       : ['prettier'],
      \   'css'       : ['prettier'],
      \   'json'      : ['prettier'],
      \   'scss'      : ['prettier'],
      \   'yaml'      : ['prettier'],
      \   'graphql'   : ['prettier'],
      \   'html'      : ['prettier'],
      \   'c'         : ['clang-format'],
      \   'cpp'       : ['clang-format'],
      \   'reason'    : ['refmt'],
      \   'python'    : ['black'],
      \   'sh'        : ['shfmt'],
      \   'bash'      : ['shfmt'],
      \   'rust'      : ['rustfmt'],
\ }

" Error and warning signs for Ale.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'


" Enable ale integration with airline.
let g:airline#extensions#ale#enabled = 1
" Make airline use some l33t fonts
let g:airline_powerline_fonts = 1

" Don't auto auto-format files inside `node_modules` or minified files
let g:ale_pattern_options_enabled = 1
let g:ale_pattern_options = {
      \   '\.min\.(js\|css)$': {
      \       'ale_linters': [],
      \       'ale_fixers': ['remove_trailing_lines', 'trim_whitespace']
      \   },
      \   'node_modules/.*': {
      \       'ale_linters': [],
      \       'ale_fixers': []
      \   },
      \   'package.json': {
      \       'ale_fixers': ['remove_trailing_lines', 'trim_whitespace']
      \   },
      \}

function! FixOnSaveToggle()
    if g:ale_fix_on_save
      let g:ale_fix_on_save = 0
    else
      let g:ale_fix_on_save = 1
    endif
endfunction


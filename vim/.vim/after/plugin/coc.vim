scriptencoding utf-8

if !exists('g:did_coc_loaded')
  finish
endif

let g:coc_node_path=exepath('node')

let s:LSP_CONFIG = [
      \ ['ccls', {
      \   'command': exepath('ccls'),
      \   'filetypes': ['c', 'cpp', 'cuda', 'objc', 'objcpp'],
      \   'rootPatterns': ['.ccls', 'compile_commands.json', '.vim/', '.git/', '.hg/'],
      \   'initializationOptions': {
      \     'cache': {
      \       'directory': '.ccls-cache'
      \     }
      \   },
      \ }],
      \ ['reason', {
      \   'command': '/Users/al952368/.config/reason-language-server/reason-language-server',
      \   'filetypes': ['reason'],
      \ }]
      \ ]

call coc#config('coc.preferences', {
      \ 'colorSupport': 0,
      \ 'hoverTarget': utils#has_floating_window() ? 'float' : 'echo',
      \ })

call coc#config('suggest', {
      \ 'autoTrigger': 'always',
      \ 'noselect': 0,
      \ 'echodocSupport': 1,
      \ 'floatEnable': utils#has_floating_window(),
      \ })

call coc#config('signature', {
      \ 'target': utils#has_floating_window() ? 'float' : 'echo',
      \ })

call coc#config('diagnostic', {
      \ 'errorSign': '×',
      \ 'warningSign': '●',
      \ 'infoSign': '!',
      \ 'hintSign': '?',
      \ 'messageTarget': utils#has_floating_window() ? 'float' : 'echo',
      \ 'displayByAle': utils#has_floating_window() ? 0 : 1,
      \ 'refreshOnInsertMode': 1
      \ })

call coc#config('coc.github', {
      \ 'filetypes': ['gitcommit', 'markdown.ghpull']
      \ })

let s:languageservers = {}
for [lsp, config] in s:LSP_CONFIG
  " COC chokes on emptykcommands https://github.com/neoclide/coc.nvim/issues/418#issuecomment-462106680"
  let s:not_empty_cmd = !empty(get(config, 'command'))
  if s:not_empty_cmd | let s:languageservers[lsp] = config | endif
endfor

if !empty(s:languageservers)
  call coc#config('languageserver', s:languageservers)
endif

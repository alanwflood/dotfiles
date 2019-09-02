" Enable Rainbow parens
augroup rainbow_parens
  autocmd!
  autocmd FileType * RainbowParentheses
augroup END

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" Blacklist black and dark gray parens
let g:rainbow#blacklist = range(16, 255)

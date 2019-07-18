call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}

" ==> Toggles
let g:which_key_map.t =  {
      \ 'name' : '+toggles',
      \ 'f' : [ ':call FixOnSaveToggle()', 'Fix On Save' ],
      \ 's' : [ ':ALEToggle',               'Linter'],
      \ 'i' : [ ':IndentLinesToggle',       'Auto Indentation'],
      \ 'q' : [ ':QuickScopeToggle', 'QuickScope Highlighting'],
      \ 'r' : [ ':RainbowParentheses!!',    'Rainbow Parens'],
      \ }

" ==> Tests
let g:which_key_map['T'] =  {
      \ 'name' : '+test',
      \ 'n' : [ ':TestNearest', 'Test Under Cursor' ],
      \ 'f' : [ ':TestFile',    'Test Current File'],
      \ 's' : [ ':TestSuite',   'Run Test Suite'],
      \ 'l' : [ ':TestLast',    'Run Last Test'],
      \ 'g' : [ ':TestVisit',   'Goto Last Test'],
      \ }

" ==> Files
let g:which_key_map.f =  {
      \ 'name' : '+files',
      \ 'o' : [':FZF',               'Fuzzy Find File'],
      \ 'r' : [':%s//g<Left><Left>', 'Find & Replace'],
      \ 'R' : [':History',           'Recently Used File'],
      \ 'z' : [':Files',             'Find File'],
      \ 'c' : [':FindCurrent',       'Search Current File'],
      \ 'f' : [':Find',              'Fuzzy Find Word'],
      \ 'l' : [':Lines',             'Find Line'],
      \ }

" ==> Search
let g:which_key_map.s = {
      \ 'name' : '+search',
      \ 'h': [':history',  'History'],
      \ 'm': [':marks',    'Marks'],
      \ 'w': [':windows',  'Windows'],
      \ 's': [':Snippets', 'Snippets'],
      \ }

" ==> Help
let g:which_key_map.h = {
      \ 'name' : '+help',
      \ 'c': [':Commands',                  'Commands'],
      \ 'h': [':Helptags',                  'Help Tags'],
      \ 'e': [':e ~/.config/nvim/init.vim', 'Edit init.vim'],
      \ }

" ==> Buffers
let g:which_key_map.b = {
      \ 'name' : '+buffers',
      \ 'l' : [":e #",     "Switch To Last"],
      \ 's' : [":Buffers", "Search"],
      \ 'd' : [":Bclose",  "Close Buffer"],
      \}

" ==> Git Fugitive Bindings
let g:which_key_map.g = {
      \ 'name' : '+git',
      \ 'b' : [':Gblame',   'Blame'],
      \ 'B' : [':Gbrowser', 'Open in Browser'],
      \ 'd' : [':Gdiff',    'Diff'],
      \ 'e' : [':Gedit',    'Edit'],
      \ 'f' : [':GFiles',   'View Files'],
      \ 'F' : [':GFiles?',  'View File Status'],
      \ 's' : [':Gstatus',  'Status'],
      \ 'p' : [':Gpull',    'Pull'],
      \ 'P' : [':Gpush',    'Push'],
      \ 'r' : [':Gread',    'Read'],
      \ 'w' : [':Gwrite',   'Add File'],
      \ 'q' : [':Gwq',      'Add File and Quit'],
      \ 'Q' : [':Gwq!',     'Add File and Quit!'],
      \ 'c' : {
        \'name' : '+commits',
        \ 's' : [':Commits',  'View Commits'],
        \ 'c' : [':Gcommit',  'Create Commit']
        \ },
      \ }

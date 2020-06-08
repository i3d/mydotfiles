" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100
" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0
" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function
" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler
" Single mappings
let g:which_key_map['1'] = [ '<C-W>s'                     , '2 stacks' ]
let g:which_key_map['2'] = [ '<C-W>v'                     , '2 columns' ]
let g:which_key_map['/'] = [ ':CocList grep'              , 'coc grep' ]
let g:which_key_map['C'] = [ ':CocList colors'            , 'all themes' ]
let g:which_key_map['.'] = [ ':CocList files'             , 'open files' ]
let g:which_key_map[','] = [ ':CocList words'             , 'search words' ]
let g:which_key_map[';'] = [ ':CocList outline'           , 'search words' ]
let g:which_key_map['V'] = [ ':Commands'                  , 'commands' ]
let g:which_key_map['='] = [ '<C-W>='                     , 'balance windows' ]
" not yet
"let g:which_key_map['c'] = [ ':Codi!!'                    , 'virtual repl']
let g:which_key_map['d'] = [ ':bd'                        , 'delete buffer']
let g:which_key_map['e'] = [ ':CocCommand explorer'       , 'explorer' ]
let g:which_key_map['f'] = [ ':Files'                     , 'search files' ]
let g:which_key_map['r'] = [ ':RnvimrToggle'              , 'ranger' ]
let g:which_key_map['S'] = [ ':SSave'                     , 'save session' ]
let g:which_key_map['T'] = [ ':Rg'                        , 'search text' ]
let g:which_key_map['v'] = [ '<C-W>v'                     , 'split right']
let g:which_key_map['z'] = [ 'Goyo'                       , 'zen' ]
let g:which_key_map['?'] = [ ':CocList maps'              , 'maps' ]
let g:which_key_map['B'] = [ ':!xxd -g1 %'                , 'show hex' ]
let g:which_key_map['x'] = [ 'copen'                      , 'show quickfix' ]
let g:which_key_map["'"] = [ 'FloatermToggle'             , 'shell' ]
let g:which_key_map['h'] = [ 'FloatermHide'               , 'kill shell' ]
let g:which_key_map['q'] = [ ':q!'                        , 'quit']
let g:which_key_map['n'] = [ ':bnext'                     , 'cycle buffers' ]
" action
let g:which_key_map.a = {
      \ 'name' : '+actions' ,
      \ 'c' : [':ColorizerToggle'        , 'colorizer'],
      \ 'e' : [':CocCommand explorer'    , 'explorer'],
      \ 'n' : [':set nonumber!'          , 'line-numbers'],
      \ 'r' : [':set norelativenumber!'  , 'relative line nums'],
      \ 's' : [':let @/ = ""'            , 'remove search highlight'],
      \ 't' : [':FloatermToggle'         , 'terminal'],
      \ 'h' : [':FloatermHide'           , 'terminal hide'],
      \ 'v' : [':Vista!!'                , 'tag viewer'],
      \ }
" buffer
let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '1' : ['b1'                       , 'buffer 1'],
      \ '2' : ['b2'                       , 'buffer 2'],
      \ 'd' : ['bd'                       , 'delete-buffer'],
      \ 'f' : ['bfirst'                   , 'first-buffer'],
      \ 'h' : ['Startify'                 , 'home-buffer'],
      \ 'l' : ['blast'                    , 'last-buffer'],
      \ 'n' : ['bnext'                    , 'next-buffer'],
      \ 'p' : ['bprevious'                , 'previous-buffer'],
      \ '?' : ['Buffers'                  , 'fzf-buffer'],
      \ 'b' : [':CocList buffers'         , 'buffers'],
      \ 'm' : [':CocList marks'           , 'marks'],
      \ }
" code
let g:which_key_map.c = {
      \ 'name' : '+code' ,
      \ }
" git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'a' : [':Git add .'                        , 'add all'],
      \ 'A' : [':Git add %'                        , 'add current'],
      \ 'b' : [':Git blame'                        , 'blame'],
      \ 'B' : [':GBrowse'                          , 'browse'],
      \ 'c' : [':Git commit'                       , 'commit'],
      \ 'd' : [':Git diff'                         , 'diff'],
      \ 'D' : [':Gdiffsplit'                       , 'diff split'],
      \ 'g' : [':GGrep'                            , 'git grep'],
      \ 'G' : [':Gstatus'                          , 'status'],
      \ 'h' : [':GitGutterLineHighlightsToggle'    , 'highlight hunks'],
      \ 'H' : ['<Plug>(GitGutterPreviewHunk)'      , 'preview hunk'],
      \ 'j' : ['<Plug>(GitGutterNextHunk)'         , 'next hunk'],
      \ 'k' : ['<Plug>(GitGutterPrevHunk)'         , 'prev hunk'],
      \ 'l' : [':Git log'                          , 'log'],
      \ 'p' : [':Git push'                         , 'push'],
      \ 'P' : [':Git pull'                         , 'pull'],
      \ 'r' : [':GRemove'                          , 'remove'],
      \ 's' : ['<Plug>(GitGutterStageHunk)'        , 'stage hunk'],
      \ 't' : [':GitGutterSignsToggle'             , 'toggle signs'],
      \ 'u' : ['<Plug>(GitGutterUndoHunk)'         , 'undo hunk'],
      \ 'v' : [':GV'                               , 'view commits'],
      \ 'V' : [':GV!'                              , 'view buffer commits'],
      \ }
" lsp
let g:which_key_map.l = {
      \ 'name' : '+lsp' ,
      \ '.' : [':CocConfig'                          , 'config'],
      \ ';' : ['<Plug>(coc-refactor)'                , 'refactor'],
      \ 'a' : ['<Plug>(coc-codeaction)'              , 'line action'],
      \ 'A' : ['<Plug>(coc-codeaction-selected)'     , 'selected action'],
      \ 'b' : [':CocNext'                            , 'next action'],
      \ 'B' : [':CocPrev'                            , 'prev action'],
      \ 'c' : [':CocList commands'                   , 'commands'],
      \ 'd' : ['<Plug>(coc-definition)'              , 'definition'],
      \ 'D' : ['<Plug>(coc-declaration)'             , 'declaration'],
      \ 'e' : [':CocList extensions'                 , 'extensions'],
      \ 'f' : ['<Plug>(coc-format-selected)'         , 'format selected'],
      \ 'F' : ['<Plug>(coc-format)'                  , 'format'],
      \ 'h' : ['<Plug>(coc-float-hide)'              , 'hide'],
      \ 'i' : ['<Plug>(coc-implementation)'          , 'implementation'],
      \ 'I' : [':CocList diagnostics'                , 'diagnostics'],
      \ 'j' : ['<Plug>(coc-float-jump)'              , 'float jump'],
      \ 'l' : ['<Plug>(coc-codelens-action)'         , 'code lens'],
      \ 'n' : ['<Plug>(coc-diagnostic-next)'         , 'next diagnostic'],
      \ 'N' : ['<Plug>(coc-diagnostic-next-error)'   , 'next error'],
      \ 'o' : ['<Plug>(coc-openlink)'                , 'open link'],
      \ 'O' : [':CocList outline'                    , 'outline'],
      \ 'p' : ['<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'],
      \ 'P' : ['<Plug>(coc-diagnostic-prev-error)'   , 'prev error'],
      \ 'q' : ['<Plug>(coc-fix-current)'             , 'quickfix'],
      \ 'r' : ['<Plug>(coc-rename)'                  , 'rename'],
      \ 'R' : ['<Plug>(coc-references)'              , 'references'],
      \ 's' : [':CocList -I symbols'                 , 'references'],
      \ 'S' : [':CocList snippets'                   , 'snippets'],
      \ 't' : ['<Plug>(coc-type-definition)'         , 'type definition'],
      \ 'u' : [':CocListResume'                      , 'resume list'],
      \ 'U' : [':CocUpdate'                          , 'update CoC'],
      \ 'v' : [':Vista!!'                            , 'tag viewer'],
      \ 'z' : [':CocDisable'                         , 'disable CoC'],
      \ 'Z' : [':CocEnable'                          , 'enable CoC'],
      \ }
" open
let g:which_key_map.o = {
      \ 'name' : '+open',
      \ '1' : [':e ~/.vimrc'                                     , 'vimrc'],
      \ '2' : [':e ~/.vimrc.bundles'                             , 'vimrc bundle'],
      \ 'i' : [':e ~/.config/nvim/init.vim'                            , 'open init'],
      \ 'k' : [':e ~/.config/nvim/keys/which-key.vim'                  , 'which keys'],
      \ 'p' : [':e ~/.config/nvim/vim-plug/plugins.vim'                , 'vim-plug'],
      \ }
" project
let g:which_key_map.p = {
      \ 'name' : '+project' ,
      \ 'h' : [':Startify'                          , 'Home' ],
      \ 'e' : [':e ~/.vimrc'                  , 'edit init' ],
      \ 'b' : [':e ~/.vimrc.bundles'          , 'edit bundles' ],
      \ 'R' : [':so ~/.vimrc'                       , 'reload all!'],
      \ 'q' : [':qa!'                               , 'kill!'],
      \ 's' : [':wqa!'                              , 'save&quit all!'],
      \ 'S' : [':SSave'                                     , 'save session'],
      \ }
" search
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'              , 'history'],
      \ ';' : [':Commands'              , 'commands'],
      \ 'a' : [':Ag'                    , 'text Ag'],
      \ 'b' : [':BLines'                , 'current buffer'],
      \ 'B' : [':Buffers'               , 'open buffers'],
      \ 'c' : [':Commits'               , 'commits'],
      \ 'C' : [':BCommits'              , 'buffer commits'],
      \ 'f' : [':Files'                 , 'files'],
      \ 'g' : [':GFiles'                , 'git files'],
      \ 'G' : [':GFiles?'               , 'modified git files'],
      \ 'h' : [':History'               , 'file history'],
      \ 'H' : [':History:'              , 'command history'],
      \ 'l' : [':Lines'                 , 'lines'] ,
      \ 'm' : [':Marks'                 , 'marks'] ,
      \ 'M' : [':Maps'                  , 'normal maps'] ,
      \ 'p' : [':Helptags'              , 'help tags'] ,
      \ 'P' : [':Tags'                  , 'project tags'],
      \ 's' : [':CocList snippets'      , 'snippets'],
      \ 'S' : [':Colors'                , 'color schemes'],
      \ 't' : [':Rg'                    , 'text Rg'],
      \ 'T' : [':BTags'                 , 'buffer tags'],
      \ 'w' : [':Windows'               , 'search windows'],
      \ 'y' : [':Filetypes'             , 'file types'],
      \ 'z' : [':FZF'                   , 'FZF'],
      \ '?' : [':FZF'                   , 'FZF'],
      \ }
" terminal
let g:which_key_map.t = {
      \ 'name' : '+terminal' ,
      \ ';' : [':FloatermNew --wintype=popup --height=6'        , 'terminal'],
      \ 'f' : [':FloatermNew fzf'                               , 'fzf'],
      \ 'g' : [':FloatermNew lazygit'                           , 'git'],
      \ 'd' : [':FloatermNew lazydocker'                        , 'docker'],
      \ 'n' : [':FloatermNew node'                              , 'node'],
      \ 'N' : [':FloatermNew nnn'                               , 'nnn'],
      \ 'p' : [':FloatermNew python'                            , 'python'],
      \ 'r' : [':FloatermNew ranger'                            , 'ranger'],
      \ 't' : [':FloatermToggle'                                , 'toggle'],
      \ 'h' : [':FloatermHide'                                  , 'hide'],
      \ 'y' : [':FloatermNew ytop'                              , 'ytop'],
      \ 's' : [':FloatermNew ncdu'                              , 'ncdu'],
      \ }
" window management
let g:which_key_map.w = {
      \ 'name' : '+windows' ,
      \ 'a' : [':CocList windows'                               , 'list windows'],
      \ 'w' : ['<C-W>w'                                         , 'other window'],
      \ 's' : ['<C-W>s'                                         , 'split window'],
      \ '_' : ['<C-W>s'                                         , 'split below'],
      \ 'v' : ['<C-W>v'                                         , 'split right'],
      \ '2' : ['<C-W>v'                                         , '2 columns'],
      \ 'j' : ['<C-W>j'                                         , 'window down'],
      \ 'k' : ['<C-W>k'                                         , 'window up'],
      \ 'h' : ['<C-W>h'                                         , 'window left'],
      \ 'l' : ['<C-W>h'                                         , 'window right'],
      \ 'd' : ['<C-W>q'                                         , 'window kill'],
      \ 'D' : ['<C-W>c'                                         , 'window clean'],
      \ 'm' : [':call MaximizeToggle()'                         , 'window max'],
      \ 'T' : [':TabVifm'                                       , 'Tab vifm'],
      \ 'V' : [':VsplitVifm'                                    , 'VTab vifm'],
      \ '?' : ['Windows'                                        , 'fzf windows'],
      \ }
" Global
" <Plug>VimwikiIndex
" <Plug>VimwikiTabIndex
" <Plug>VimwikiUISelect
" <Plug>VimwikiDiaryIndex
" <Plug>VimwikiMakeDiaryNote
" <Plug>VimwikiTabMakeDiaryNote
" <Plug>VimwikiMakeYesterdayDiaryNote
" <Plug>VimwikiMakeTomorrowDiaryNote
"
" " Local
" <Plug>Vimwiki2HTML
" <Plug>Vimwiki2HTMLBrowse
" <Plug>VimwikiDiaryGenerateLinks
" <Plug>VimwikiFollowLink
" <Plug>VimwikiSplitLink
" <Plug>VimwikiVSplitLink
" <Plug>VimwikiTabnewLink
" <Plug>VimwikiGoBackLink
" <Plug>VimwikiNextLink
" <Plug>VimwikiPrevLink
" <Plug>VimwikiGoto
" <Plug>VimwikiDeleteLink
" <Plug>VimwikiRenameLink
" <Plug>VimwikiAddHeaderLevel

" Register which key map
call which_key#register('<Space>', "g:which_key_map")

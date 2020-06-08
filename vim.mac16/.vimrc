source ~/.vimrc.bundles

set rtp+=~/homebrew/opt/vim
set rtp+=/Users/i3dmaster/homebrew/opt/fzf
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nno <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vno <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
nno <silent> <localleader> :silent <c-u> :silent WhichKey ','<CR>
" ================ functions and commands ======================
""" <space>k to bring up help
com! -nargs=* Google execute 'silent !google <args>'
com! -nargs=+ Greph execute 'silent grep! <args> *.h' | cwindow
com! -nargs=+ Grepcc execute 'silent grep! <args> *.cc' | cwindow
com! -nargs=+ Grepgo execute 'silent grep! <args> *.go' | cwindow
" ================ functions and commands ======================
" ================ themes ======================
"colorscheme mustang
"colorscheme molokai
"color jellybeans
"color hybrid
"color gotham
"color lucius
"color molokai_dark
"color bubblegum-256-dark
"color holokai
"color hemisu
"color cabin
"color hybrid_material
"color darkburn
"color alduin
"color kolor
"color badwolf
"color onedark
"color colorsbox-material
"color gruvbox
"color palenight
"let g:airline_theme='palenight'
""color onedark
""let g:airline_theme='onedark'
"color atlas
"let g:airline_theme='atlas'
"color nord
"let g:airline_theme='nord'
"color hybrid_material
"let g:airline_theme='hybrid'
""color hydrangea
"let g:airline_theme='hybrid'
"color monokai-chris
"let g:airline_theme='hybrid'
"color mustang
"let g:airline_theme='hybrid'
"color material
"color hybrid
"let g:airline_theme='hybrid'
""color ayu
""let g:airline_theme='ayu'
"color spacegray
"let g:airline_theme='spacegray'
"set termguicolors
"color afterglow
"let g:airline_theme='minimalist'
"let g:afterglow_blackout=1
"let g:afterglow_italic_comments=1
"let g:afterglow_inherit_background=1
"set termguicolors
"color ayu
"let g:airline_theme='ayu_mirage'
"color apprentice
"let g:airline_theme='minimalist'
"set background=dark
"set termguicolors
"colorscheme deep-space
"let g:deepspace_italics=1
"let g:airline_theme='deep_space'
"color alduin
"let g:alduin_Shout_Fire_Breath = 1
"let g:alduin_Shout_Become_Ethereal = 1
"let g:alduin_Shout_Dragon_Aspect = 1

"color minimalist
"let g:airline_theme='minimalist'

"color lucius
"let g:airline_theme='minimalist'
"color paramount
"let g:airline_theme='minimalist'
"set background=dark
"set termguicolors
"color pink-moon
"let g:airline_theme='minimalist'
"let g:two_firewatch_italics=1
"set termguicolors
"colo absent
"let g:airline_theme='twofirewatch'
"set termguicolors
"colo allure
"let g:airline_theme='twofirewatch'

"set background=dark
"set termguicolors
"color two-firewatch 
"let g:airline_theme='twofirewatch'
"let g:two_firewatch_italics=1

"set background=dark
"set notermguicolors
"color oncedark
"let g:airline_theme='onedark'

set background=dark
set termguicolors
color one
let g:airline_theme='one'
set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum
" ##########################################
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" ============== themes ====================
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
if !has("nvim")
    set term=xterm-256color
endif
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  "let g:airline_symbols.branch = 'ᚠ'
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif
"https://github.com/ryanoasis/powerline-extra-symbols
" blocks
"let g:airline_left_sep = "\ue0c4"
"let g:airline_left_alt_sep = "\ue0c6"
"let g:airline_right_sep = "\uE0c5"
"let g:airline_right_alt_sep = "\uE0c7"
" triangle
let g:airline_left_sep = "\ue0b8"
let g:airline_left_alt_sep = '\ue0b9'
let g:airline_right_sep = "\ue0ba"
let g:airline_righ_alt_sep = "\ue0bb"
" round
"let g:airline_left_sep = "\ue0b4"
"let g:airline_left_alt_sep = '\ue0b5'
"let g:airline_right_sep = "\ue0b6"
"let g:airline_righ_alt_sep = "\ue0b7"
" sticks
"let g:airline_left_sep = "\ue0c8"
"let g:airline_right_sep = "\ue0ca"
" flame
"let g:airline_left_sep = "\ue0c0"
"let g:airline_right_sep = "\ue0c2"
" blocks
"let g:airline_left_sep = "\ue0d2"
"let g:airline_right_sep = "\ue0d4"
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.notexists = '∄'
let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
let g:airline#extensions#readonly#symbol   = '☯'
let g:airline#extensions#linecolumn#prefix = '¶'
let g:airline#extensions#paste#symbol      = 'ρ'
let g:airline_symbols.paste     = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'Location'
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#overwrite_variables = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let airline#extensions#syntastic#error_symbol = 'E:'
let airline#extensions#syntastic#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#syntastic#warning_symbol = 'W:'
let airline#extensions#syntastic#stl_format_err = '%W{[%w(#%fw)]}'
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 0
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
let g:airline#extensions#ctrlp#color_template = 'insert'
let g:airline#extensions#ctrlp#color_template = 'normal'
let g:airline#extensions#ctrlp#color_template = 'visual'
let g:airline#extensions#ctrlp#color_template = 'replace'
let g:airline#extensions#ctrlp#show_adjacent_modes = 1
let g:airline#extensions#ctrlspace#enabled = 1
let g:CtrlSpaceStatuslineFunction = "airline#extensions#ctrlspace#statusline()"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#buffers_label = 'b'
let g:airline#extensions#tabline#tabs_label = 't'
let g:airline#extensions#tmuxline#enabled = 0
let airline#extensions#tmuxline#color_template = 'normal'
let airline#extensions#tmuxline#color_template = 'insert'
let airline#extensions#tmuxline#color_template = 'visual'
let airline#extensions#tmuxline#color_template = 'replace'
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#ycm#error_symbol = 'E:'
let g:airline#extensions#ycm#warning_symbol = 'W:'
let g:airline#extensions#vimtex#enabled = 1
let g:airline#extensions#vimtex#left = "{"
let g:airline#extensions#vimtex#right = "}"
"let g:airline_theme='gotham'
"let g:airline_theme='term'
"let g:airline_theme='hybridline'
"let g:airline_theme='kalisi'
"let g:airline_theme='powerlineish'
" https://github.com/vim-airline/vim-airline/wiki/Screenshots
"let g:airline_theme='jellybeans'
"let g:airline_theme='lucius'
"let g:airline_theme='wombat'
"let g:airline_theme='night_owl'
"let g:airline_theme='understated'
"let g:airline_theme='ubaryd'
"let g:airline_theme='papercolor'
"let g:airline_theme='murmur'
"let g:airline_theme='luna'
"let g:airline_theme='kolor'
"let g:airline_theme='badwolf'
"let g:airline_theme='angr'
"let g:airline_theme='distinguished'
"let g:airline_theme='base16'
"let g:airline_theme='tomorrow'
"let g:airline_theme='archery'
"let g:airline_theme='solarized'
"let g:airline_theme='solarized'
"let g:airline_solarized_bg='dark'
"let g:tmuxline_preset = 'nightly_fox'
let g:rnvimr_ex_enable = 1
let g:rnvimr_draw_border = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_bw_enable = 1
let g:rnvimr_ranger_cmd = 'ranger --cmd="set column_ratios 1,1"'
            " \ --cmd="set draw_borders separators"'
" let g:rnvimr_layout = { 'relative': 'editor',
"             \ 'width': float2nr(round(0.6 * &columns)),
"             \ 'height': float2nr(round(0.6 * &lines)),
"             \ 'col': float2nr(round(0.2 * &columns)),
"             \ 'row': float2nr(round(0.2 * &lines)),
"             \ 'style': 'minimal' }
let g:rnvimr_presets = [
            \ {'width': 0.800, 'height': 0.800}]
let g:ranger_replace_netrw = 1 "// open ranger when vim open a directory
let g:NERDTreeHijackNetrw = 0 "// add this line if you use NERDTree
let g:ranger_map_keys = 0
if executable('rg')
  set grepprg=rg\ -C1\ -S\ --column\ -H\ --vimgrep\ --color=never
endif
" ================ themes ======================
"
" ================ key maps ======================
" select last paste in visual mode
" Map leader to which_key
"split"
nno - <C-W>-
nno = <C-W>+
"vsplit"
nno < <C-W><
nno > <C-W>>
vno J :m '>+1<cr>gv=gv
vno K :m '<-2<cr>gv=gv
" sync with cider -- myciderkeys on mac
nor <silent> go <c-o>
nor <silent> gi <c-i>
nno <silent> cp :copen<cr>
nno ; :
"ino jk <esc>
ino vv <esc>
nno <silent> <tab> <c-w>w
cno w!! w !sudo tee % >/dev/null
nno <F12> "%phr_I#ifndef __<Esc>gUwyypldwidefine <Esc>yypldwiendif //<Esc>O<Esc>
nno <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'
",ig"
nno <silent> <localleader>sf :SignifyToggleHighlight<cr>
ino <silent> <localleader>w <esc>:w!<cr>
nno <silent> <localleader>iv :e ~/.vimrc<CR>
nno <silent> <localleader>iR :so ~/.vimrc<CR>"
nno <silent> <localleader>gj <plug>(signify-next-hunk)
nno <silent> <localleader>gk <plug>(signify-prev-hunk)
nno <silent> <localleader>oi :e ~/.config/nvim/init.vim<cr>
nno <silent> <localleader>ok :e ~/.config/nvim/keys/which-key.vim<cr>
nno <silent> <localleader>op :e ~/.config/nvim/vim-plug/plugins.vim<cr>
nno <silent> <localleader>sh :History<cr>
nno <silent> <localleader>sH :History:<cr>
nno <silent> <localleader>s/ :CocList grep<cr>
nno <silent> <localleader>sa :Ag<cr>
nno <silent> <localleader>s. :CocList files<cr>
nno <silent> <localleader>s, :CocList words<cr>
nno <silent> <localleader>s? :CocList commands<cr>
nno <silent> <localleader>sb :Buffers<cr>
nno <silent> <localleader>sB :BLines<cr>
nno <silent> <localleader>sm :Marks<cr>
nno <silent> <localleader>sM :Maps<cr>
nno <silent> <localleader>sp :Helptags<cr>
nno <silent> <localleader>sP :Tags<cr>
nno <silent> <localleader>st :Rg<cr>
nno <silent> <localleader>sT :BTags<cr>
nno <silent> <localleader>sw :Windows<cr>
nno <silent> <localleader>sz :FZF<cr>
nno <silent> <localleader>sr :RnvimrToggle<cr>
nno <silent> <localleader>ph :Startify<cr>
nno <silent> <localleader>pq :qa!<cr>
nno <silent> <localleader>pw :wqa!<cr>
nno <silent> <localleader>pR :so $MYVIMRC<cr>
nno <silent> <localleader>pS :SSave<cr>
nno <silent> <localleader>pE :e ~/.vimrc<cr>
nno <silent> <localleader>pB :e ~/.vimrc.bundles<cr>
nno <silent> <localleader>B :!xxd -g1 %<cr>
nno <silent> <localleader>bb :CocList buffers<cr>
nno <silent> <localleader>bn :bn<cr>
nno <silent> <localleader>bp :bp<cr>
nno <silent> <localleader>bm :CocList marks<cr>
nno <silent> <localleader>bf :Buffers<cr>
nno <silent> <localleader>bd :bd<cr>
nmap <localleader>vt :TabVifm<cr>
nmap <localleader>vs :VsplitVifm<cr>
nmap <localleader>vd :DiffVifm<cr>
nno <silent> <localleader>T :colo<cr>
nno <silent> <localleader>S :split<cr>
nno <silent> <localleader>V :vsplit<cr>
nno <silent> <localleader>x :copen<cr>
nno <silent> <localleader>l :clist<cr>
nno <silent> <localleader>to :NERDTreeTabsOpen<cr>
nno <silent> <localleader>tf :NERDTreeTabsFind<cr>
nno <silent> <localleader>tg :NERDTreeTabsToggle<cr>
nno <silent> <localleader>te :NERDTreeFind<cr>
nno <silent> <localleader>tt :NERDTreeToggle<cr>
nno <silent> <localleader>tv :FloatermToggle<cr>
nno <silent> <localleader>th :FloatermHide<cr>
nno <silent> <localleader>T :CocList colors<cr>
"NERDTree"
nno <localleader>to :NERDTreeTabsOpen<cr>
nno <localleader>tf :NERDTreeTabsFind<cr>
nno <localleader>tg :NERDTreeTabsToggle<cr>
"vifm mapping
nno <localleader>vt :TabVifm<cr>
nno <localleader>vs :VsplitVifm<cr>
nno <localleader>vd :DiffVifm<cr>
" ==================== space macs simulation layer ========
" ==================== space macs simulation layer ========
source $HOME/.config/nvim/plug-config/coc.vim
" ==================== space macs simulation layer ========
" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '➥'
set timeoutlen=100
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
" Group mappings
" a is for actions
let g:which_key_map.a = {
      \ 'name' : '+actions' ,
      \ 'c' : [':ColorizerToggle'        , 'colorizer'],
      \ 'e' : [':CocCommand explorer'    , 'explorer'],
      \ 'n' : [':set nonumber!'          , 'line-numbers'],
      \ 'r' : [':set norelativenumber!'  , 'relative line nums'],
      \ 's' : [':let @/ = ""'            , 'remove search highlight'],
      \ 't' : [':FloatermToggle'         , 'terminal'],
      \ 'v' : [':Vista!!'                , 'tag viewer'],
      \ }
" b is for buffer
let g:which_key_map.b = {
      \ 'name' : '+buffer',
      \ '1' : ['b1'                                         , 'buffer 1']        ,
      \ '2' : ['b2'                                         , 'buffer 2']        ,
      \ 'd' : ['bd'                                         , 'delete-buffer']   ,
      \ 'f' : ['bfirst'                                     , 'first-buffer']    ,
      \ 'h' : ['Startify'                                   , 'home-buffer']     ,
      \ 'l' : ['blast'                                      , 'last-buffer']     ,
      \ 'n' : ['bnext'                                      , 'next-buffer']     ,
      \ 'p' : ['bprevious'                                  , 'previous-buffer'] ,
      \ '?' : ['Buffers'                                    , 'fzf-buffer']      ,
      \ 'b' : [ 'CocList marks'                             , 'all marks'],
      \ }
" code
let g:which_key_map.c = {
      \ 'name' : '+code' ,
      \ }
" g is for git
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
" l is for language server protocol
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
      \ 'name' : '+projects' ,
      \ 'q' : [':qa!'                                       , 'quit all'],
      \ 's' : [':wqa!'                                      , 'save&quit all'],
      \ 'S' : [':SSave'                                     , 'save session'],
      \ 'e' : [':e ~/.vimrc'                          , 'open init' ],
      \ 'b' : [':e ~/.vimrc.bundles'                  , 'open bundles' ],
      \ 'h' : ['Startify'                                   , 'home' ],
      \ }
" s is for search
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
      \ 's' : [':CocList grep'          , 'search'],
      \ 'S' : [':Colors'                , 'color schemes'],
      \ 't' : [':Rg'                    , 'text Rg'],
      \ 'T' : [':BTags'                 , 'buffer tags'],
      \ 'w' : [':Windows'               , 'search windows'],
      \ 'y' : [':Filetypes'             , 'file types'],
      \ 'z' : [':FZF'                   , 'FZF'],
      \ '?' : [':FZF'                   , 'FZF'],
      \ }
      " \ 's' : [':Snippets'     , 'snippets'],
" t is for terminal
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
      \ 'y' : [':FloatermNew ytop'                              , 'ytop'],
      \ 's' : [':FloatermNew ncdu'                              , 'ncdu'],
      \ }
" windows
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
" Register which key map
call which_key#register('<Space>', "g:which_key_map")
" ================ key maps ======================
"
" ================ settings ======================
set path+=**
set wildmenu
set copyindent   "make the autoindent copying the existing indentation"
set shiftround   "round the shift to multiple shiftwidth"
set smarttab     "use shiftwidth when insert tab"
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o
set title
set visualbell
set noerrorbells
set nobackup
set noswapfile
vmap Q gq
nmap Q gqap"
cmap w!! w !sudo tee % >/dev/null
autocmd filetype html,xml set listchars-=tab:>.
if &term == 'xterm' || &term == 'screen' || !&term
    set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
endif
"Go lang mapping"
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
"disable ruby warning.
let g:LustyJugglerSuppressRubyWarning = 1
"supertab
"let g:SuperTabDefaultCompletionType = "context"
"autocmd FileType *
"    \ if &omnifunc != '' |
"    \   call SuperTabChain(&omnifunc, "<c-p>") |
"    \ endif
"NERDTree auto open. ctrl-e does the same toggle. disable for now.
"autocmd VimEnter * execute 'NERDTree' | wincmd p
"autocmd BufWinEnter * NERDTreeMirror
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeShowFiles=1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeQuitOnOpen=0
let g:NERDTreeMarkBookmarks=1
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeShowHidden=1
let g:NERDTreeStatusline = "%{exists('b:NERDTreeRoot')?b:NERDTreeRoot.path._strForUI():''}"
let g:NERDTreeWinSize=27
let g:NERDTreeChDirMode=2
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
"fish
au BufNewFile,BufRead fish_funced set ft=fish
"from makc => My New Terminal: Alaritty 19:05
" allow alaritty to have a transparent background."
hi! Normal ctermbg=None guibg=None
hi! NonText ctermbg=None guibg=None guifg=None ctermfg=None
syntax on
set shiftround
set ignorecase
set smartcase
set incsearch
set ws  " wrap search"
set wb  "writebackup"
" always has to be the end.
filetype plugin indent on
set nu rnu
set nospell
" ================ settings ======================

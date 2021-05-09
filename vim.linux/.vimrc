source ~/.vimrc.plug

" for italic
set t_ZH=[3m
set t_ZR=[23m

let g:asyncrun_open = 10
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg', '.projectile']

set rtp+=/home/linuxbrew/.linuxbrew/opt/nvim
" install fzf from github head.
set rtp+=/home/jimxu/.fzf
set rtp+=/home/jimxu/.vim/lua

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nno <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vno <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
nno <silent> <localleader> :silent <c-u> :silent WhichKey ','<CR>
" ================ functions and commands ======================
" window management                                                               
function! MaximizeToggle() abort                                                  
  if exists("s:maximize_session")                                                 
    exec "source " . s:maximize_session                                           
    call delete(s:maximize_session)                                               
    unlet s:maximize_session                                                      
    let &hidden=s:maximize_hidden_save                                            
    unlet s:maximize_hidden_save                                                  
  else                                                                            
    let s:maximize_hidden_save = &hidden                                          
    let s:maximize_session = tempname()                                           
    set hidden                                                                    
    exec "mksession! " . s:maximize_session                                       
    only                                                                          
  endif                                                                           
endfunction

function! s:AsyncRustBuild() abort
	"open cwindow manually.
  let l:aro = g:asyncrun_open
  let g:asyncrun_open = 0
  let l:target = expand('%')
  call setqflist([]) | copen 30
  " don't use !, so we scrolling the output.
  call asyncrun#run("", {"rows": 30}, 'rustc '.l:target)
  let g:asyncrun_open = l:aro
endfunction

function! s:AsyncRustRun() abort
	"open cwindow manually.
  let l:aro = g:asyncrun_open
  let g:asyncrun_open = 0
  let l:target = expand('%')
  let l:runtarget = expand('%:r')
  call setqflist([]) | copen 30
  " don't use !, so we scrolling the output.
  call asyncrun#run("", {"rows": 30}, 'rustc '.l:target.' && ./'.l:runtarget)
  let g:asyncrun_open = l:aro
endfunction

function! s:AsyncCargoBuild() abort
	"open cwindow manually.
  let l:aro = g:asyncrun_open
  let g:asyncrun_open = 0
  call setqflist([]) | copen 30
  " don't use !, so we scrolling the output.
  call asyncrun#run("", {"rows": 30}, 'cargo build')
  let g:asyncrun_open = l:aro
endfunction

function! s:AsyncCargoTest() abort
	"open cwindow manually.
  let l:aro = g:asyncrun_open
  let g:asyncrun_open = 0
  call setqflist([]) | copen 30
  " don't use !, so we scrolling the output.
  call asyncrun#run("", {"rows": 30}, 'cargo test')
  let g:asyncrun_open = l:aro
endfunction

function! s:AsyncCargoRun() abort
	"open cwindow manually.
  let l:aro = g:asyncrun_open
  let g:asyncrun_open = 0
  call setqflist([]) | copen 30
  " don't use !, so we scrolling the output.
  call asyncrun#run("", {"rows": 30}, 'cargo run')
  let g:asyncrun_open = l:aro
endfunction

" NERDTrees File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

function! NextHunk(size) abort
  if a:size > 1
    execute "normal " . a:size . "\<plug>(signify-next-hunk)"
  else
    execute "normal \<plug>(signify-next-hunk)"
  endif
endfunction

function! PrevHunk(size) abort
  if a:size > 1
    execute "normal " . a:size . "\<plug>(signify-prev-hunk)"
  else
    execute "normal \<plug>(signify-prev-hunk)"
  endif
endfunction

""" <space>k to bring up help
com! -nargs=+ Moma execute 'silent !moma <args>'
com! -nargs=+ Who execute 'silent !who <args>'
com! -nargs=* Changelist execute 'silent !cl <args>'
com! -nargs=* Buganizer execute 'silent !bug <args>'
com! -nargs=* Cider execute 'silent !cider <args>'
com! -nargs=* Stuff execute 'silent !stuff <args>'
com! -nargs=* CiderKeys execute 'silent !myciderkeys'
com! -nargs=* Google execute 'silent !google <args>'
com! -nargs=+ Greph execute 'silent grep! <args> *.h' | cwindow
com! -nargs=+ Grepcc execute 'silent grep! <args> *.cc' | cwindow
com! -nargs=+ Grepgo execute 'silent grep! <args> *.go' | cwindow
com! -nargs=* AsyncRustBuild :call <SID>AsyncRustBuild()
com! -nargs=* AsyncRustRun :call <SID>AsyncRustRun()
com! -nargs=* AsyncCargoBuild :call <SID>AsyncCargoBuild()
com! -nargs=* AsyncCargoRun :call <SID>AsyncCargoRun()
com! -nargs=* AsyncCargoTest :call <SID>AsyncCargoTest()
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

"set background=dark
"set termguicolors
"color one
"let g:airline_theme='one'
"set t_8b=^[[48;2;%lu;%lu;%lum
"
"set background=dark
"set termguicolors
"colorscheme rigel
"let g:rigel_airline = 1
"let g:airline_theme = 'rigel'
"
"
"set background=dark
"set termguicolors
"colorscheme spacegray
"let g:airline_theme = 'minimalist'
"let g:spacegray_underline_search = 1
"let g:spacegray_use_italics = 1
"let g:spacegray_low_contrast = 1

"set background=dark
"set termguicolors
"colorscheme pinkmare
"let g:airline_theme = 'minimalist'

"set background=dark
"set termguicolors
"colorscheme elly
"let g:airline_theme = 'elly'
"
"set background=dark
"set termguicolors
"colorscheme cold
"let g:airline_theme = 'minimalist'
"
"set background=dark
"set termguicolors
"colorscheme cody
"let g:airline_theme = 'minimalist'

"set background=dark
"if exists('+termguicolors')
"      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"      set termguicolors
"endif
"colorscheme spaceduck
"let g:airline_theme = 'spaceduck'

"set background=dark
"set termguicolors
"colorscheme topology
"let g:airline_theme = 'minimalist'
"
"let g:tokyonight_style = "storm"
"let g:tokyonight_style = "night"
"let g:tokyonight_italic_comments = 1
"let g:tokyonight_hide_inactive_statusline = 1
"set background=dark
"set termguicolors
"colorscheme tokyonight
"let g:airline_theme = 'elly'

"set background=dark
"set termguicolors
"colorscheme breakingbad
"let g:airline_theme = 'minimalist'

"set background=dark
"set termguicolors
"colorscheme batman
"let g:airline_theme = 'minimalist'

"set background=dark
"set termguicolors
"colorscheme ironman_dark
"let g:airline_theme = 'minimalist'

"set background=dark
"set termguicolors
"colorscheme neonhive
"let g:airline_theme = 'minimalist'

"set background=dark
"set termguicolors
"colorscheme matrix
"let g:airline_theme = 'onedark'

"set background=dark
"set termguicolors
"colorscheme duotone-darkforest
"let g:airline_theme = 'forest-night'
"
"set background=dark
"set termguicolors
"colorscheme superman
"let g:airline_theme = 'minimalist'

"set background=dark
"set termguicolors
"colorscheme nordic-aurora
"let g:airline_theme = 'nord'

set background=dark
set termguicolors
colorscheme serenade
let g:serenade_enable_italic = 1
let g:serenade_disable_italic_comment = 0
let g:serenade_transparent_background = 0
let g:serenade_diagnostic_text_highlight = 1
let g:serenade_diagnostic_line_highlight = 0
let g:airline_theme = 'serenade'

"set background=dark
"set termguicolors
"let g:material_style = 'palenight'
"let g:material_style = 'darker'
"let g:material_style = 'oceanic'
"let g:material_style = 'deep ocean'
"let g:material_italic_comments = 1
"let g:material_italic_keywords = 1
"let g:material_italic_functions = 1
"let g:material_italic_variables = 1
"let g:material_contrast = 1
"let g:material_borders = 0
"let g:material_disable_background = 0
"colorscheme material
"let g:airline_theme = 'hybrid'

"set background=dark
"set termguicolors
"colorscheme lighthaus
"let g:airline_theme = 'lighthaus'


" ##########################################
let g:javascript_plugin_flow = 1
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

" Prettier configuration
" https://github.com/prettier/vim-prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
" may try this if slow?
let g:prettier#exec_cmd_async = 0
" don't use <leader>p
nno zcp <Plug>(Prettier)
" now maps to it's real usage.
nno <silent> <leader>cp :Prettier<cr>

" ================== prettier on every keystroke =========
" ============ Not doing it now. =========================
" when running at every change you may want to disable quickfix
" let g:prettier#quickfix_enabled = 0
" autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
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
nno <silent> gs :G4DifGFilesf<cr>
nno <silent> ge :G4Edit<cr>
nno <silent> gz :G4Revert<cr>
nno <silent> ga :G4Add<cr>
nno <silent> gl :Blame<cr>
nno <silent> gf :GFiles<cr>
nno <silent> cp :copen<cr>

" !!! important !!! don't map to gj/gk, unfortunately they aren't reliable.
nno <silent> gj :call NextHunk(1)<cr>
nno <silent> gk :call PrevHunk(1)<cr>
nno <silent> gl :call NextHunk(9999)<cr>
nno <silent> gh :call PrevHunk(9999)<cr>
" !!! important !!! don't map to gj/gk, unfortunately they aren't reliable.
"
"nno <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'
"nno ; :   == ; is used in line search.
"ino jk <esc>
ino vv <esc>
nno <silent> <tab> <c-w>w
cno w!! w !sudo tee % >/dev/null
nno <F12> "%phr_I#ifndef __<Esc>gUwyypldwidefine <Esc>yypldwiendif //<Esc>O<Esc>
",ig"
nno <silent> <localleader>sf :SignifyToggleHighlight<cr>
ino <silent> <localleader>w <esc>:w!<cr>
ino <silent> <localleader>ww <esc>:wa!<cr>
nno <silent> <localleader>qq :q!<cr>
nno <silent> <localleader>qa :qa!<cr>
nno <silent> <localleader>qs :wqa!<cr>
nno <silent> <localleader>iv :e ~/.vimrc<CR>
nno <silent> <localleader>iR :so ~/.vimrc<CR>"
nno <silent> <localleader>gw :GoogleOutlineWindow<CR>
nno <silent> <localleader>oh :O h<cr>
nno <silent> <localleader>ot :O t<cr>
nno <silent> <localleader>ob :O b<cr>
nno <silent> <localleader>oc :O cc<cr>
nno <silent> <localleader>og :O go<cr>
nno <silent> <localleader>ol :OpenCL<cr>
nno <silent> <localleader>oi :e ~/.config/nvim/init.vim<cr>
nno <silent> <localleader>ok :e ~/.config/nvim/keys/which-key.vim<cr>
nno <silent> <localleader>op :e ~/.config/nvim/vim-plug/plugins.vim<cr>
nno <silent> <localleader>sh :History<cr>
nno <silent> <localleader>sH :History:<cr>
nno <silent> <localleader>s/ :CocList grep<cr>
nno <silent> <localleader>sa :Ag<cr>
nno <silent> <localleader>s. :CocList files<cr>
nno <silent> <localleader>s, :CocList words<cr>
nno <silent> <localleader>se :call InterestingWords('n')<cr>
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
nno <silent> <localleader>ps :!p4 diff<cr>
nno <silent> <localleader>pe :exe ':!p4 edit '.bufname('%')<cr>
nno <silent> <localleader>pz :!p4 revert<cr>
nno <silent> <localleader>pa :!p4 add<cr>
nno <silent> <localleader>pA :!p4 addto -c<space>
nno <silent> <localleader>pl :!p4 blame<cr>
nno <silent> <localleader>pp :Ppending<cr>
nno <silent> <localleader>pu :!p4 sync<cr>
nno <silent> <localleader>ph :Startify<cr>
nno <silent> <localleader>pq :qa!<cr>
nno <silent> <localleader>pw :wqa!<cr>
nno <silent> <localleader>pR :so $MYVIMRC<cr>
nno <silent> <localleader>pS :SSave<cr>
nno <silent> <localleader>pE :e ~/.vimrc<cr>
nno <silent> <localleader>pB :e ~/.vimrc.plug<cr>
nno <silent> <localleader>pf :Prettier<cr>
nno <silent> <localleader>Gb :!blaze build<cr>
nno <silent> <localleader>GB :BlazeBuild<cr>
nno <silent> <localleader>Gt :!blaze test<cr>
nno <silent> <localleader>GT :BlazeTest<cr>
"nno <silent> <localleader>Gr :call blaze#TestCurrentMethod()<cr>
"nno <silent> <localleader>Gv :BlazeViewCommandLog<cr>
"nno <silent> <localleader>GE :BlazeLoadErrors<cr>
"nno <silent> <localleader>GU :BlazeDepsUpdate<cr>
"nno <silent> <localleader>Gn :G4Lint<cr>
"nno <silent> <localleader>GP :PiperChangeDirectory<space>
nno <silent> <localleader>Gh :Greph<space>
nno <silent> <localleader>Gc :Grepcc<space>
nno <silent> <localleader>Gg :Grepgo<space>
"nor <silent> <localleader>Gf :let g:clang_include_fixer_query_mode=0<cr>:py3f /usr/lib/clang-include-fixer/clang-include-fixer.py<cr>:w<cr>:BlazeDepsUpdate<cr>
"nno <silent> <localleader>GF :let g:clang_include_fixer_query_mode=1<cr>:py3f /usr/lib/clang-include-fixer/clang-include-fixer.py<cr>:w<cr>:BlazeDepsUpdate<cr>
"nno <silent> <localleader>GCc :CritiqueComments<cr>
"nno <silent> <localleader>GCp :CritiquePreviousComments<cr>
"nno <silent> <localleader>GCn :CritiqueNextComments<cr>
"nno <silent> <localleader>GCu :CritiqueUnresolvedComments<cr>
nno <silent> <localleader>B :!xxd -g1 %<cr>
nno <silent> <localleader>bb :CocList buffers<cr>
nno <silent> <localleader>bn :bn<cr>
nno <silent> <localleader>bp :bp<cr>
nno <silent> <localleader>bm :CocList marks<cr>
nno <silent> <localleader>bf :Buffers<cr>
nno <silent> <localleader>bd :bd<cr>
"nno <silent> <localleader>cs :CSearch<space>
"nno <silent> <localleader>cw :CSearch <C-r><C-w><CR>
"nno <silent> <localleader>c. :exe 'CSearch ' . expand('%')<CR>
"nno <silent> <localleader>cb :!~/bin/build_cleaner<cr>
nmap <localleader>vt :TabVifm<cr>
nmap <localleader>vs :VsplitVifm<cr>
nmap <localleader>vd :DiffVifm<cr>
nno <silent> <localleader>T :colo<cr>
nno <silent> <localleader>S :split<cr>
nno <silent> <localleader>V :vsplit<cr>
nno <silent> <localleader>x :copen<cr>
nno <silent> <localleader>l :clist<cr>
"nor <silent> <localleader>r :RelatedFilesWindow<CR>
nno <silent> <localleader>to :NERDTreeTabsOpen<cr>
nno <silent> <localleader>tf :NERDTreeTabsFind<cr>
nno <silent> <localleader>tg :NERDTreeTabsToggle<cr>
nno <silent> <localleader>te :NERDTreeFind<cr>
nno <silent> <localleader>t= :NERDTreeToggle<cr>
nno <silent> <localleader>t; :FloatermToggle<cr>
nno <silent> <localleader>th :FloatermHide<cr>
nno <silent> <localleader>tk :FloatermKill<cr>
nno <silent> <localleader>tn :FloatermNext<cr>
nno <silent> <localleader>tp :FloatermPrev<cr>
nno <silent> <localleader>tt :FloatermNew --width=50 --height=60<cr>
nno <silent> <localleader>t. :lua require('FTerm').toggle()<cr>
"au VimEnter * nno <silent> gd :LspDefinition<CR>
"au VimEnter * nno <silent> gD :LspReferences<CR>
"au VimEnter * nno <silent> gp :LspPeekDefinition<CR>
nno <silent> <localleader>T :CocList colors<cr>
"NERDTree"
nno <localleader>to :NERDTreeTabsOpen<cr>
nno <localleader>tf :NERDTreeTabsFind<cr>
nno <localleader>tg :NERDTreeTabsToggle<cr>
"vifm mapping
nno <localleader>vt :TabVifm<cr>
nno <localleader>vs :VsplitVifm<cr>
nno <localleader>vd :DiffVifm<cr>

" au BufWrite *.rs :RustFmt
let g:rustfmt_autosave = 1

" ==================== space macs simulation layer ========
" ==================== space macs simulation layer ========
" source $HOME/.config/nvim_back/plug-config/coc.vim
" source $HOME/.vim/plugged/coc.nvim/plugin/coc.vim
" ==================== space macs simulation layer ========
" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
" let g:which_key_sep = '➥'
let g:which_key_sep = '✑'
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
let g:which_key_map['0'] = [ ':Restart'                   , 'Restart Nvim' ]
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
let g:which_key_map["'"] = [ 'FloatermNew --width=50 --height=60' , 'shell' ]
let g:which_key_map['h'] = [ 'FloatermKill'               , 'kill shell' ]
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
      \ 't' : [':FloatermNew --width=50 --height=60' , 'terminal'],
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
      \ 'b' : [ 'CocList buffers'                           , 'all buffers'],
      \ 'm' : [ 'CocList marks'                             , 'all marks'],
      \ }
" code
let g:which_key_map.c = {
      \ 'name' : '+code' ,
      \ 'h' : [':Greph'                                         , 'search .h'],
      \ 'c' : [':Grephcc'                                       , 'search .cc'],
      \ 'g' : [':Grephgo'                                       , 'search .go'],
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
" google
let g:which_key_map.G = {
      \ 'name' : '+Google',
      \ 'r' : [ ':RelatedFilesWindow'                     , 'Related files'],
      \ 'l' : [ ':GoogleOutlineWindow'                    , 'GoogleOutlineWindow'],
      \ 'H' : [ ':SignifyToggleHighlight'                 , 'toggle highlight'],
      \ 'v' : [ ':BlazeViewCommandLog'                    , 'Blaze View Log'],
      \ 'e' : [ ':BlazeLoadErrors'                        , 'Blaze Errors'],
      \ 'S' : [ ':BlazeGoToSponge'                        , 'Blaze Sponge'],
      \ 'U' : [ ':BlazeDepsUpdate'                        , 'Blaze DepUpdate'],
      \ 'c' : [ ':CritiqueComments'                       , 'CL comments'],
      \ 'p' : [ ':CritiquePreviousComments'               , 'CL previous comments'],
      \ 'n' : [ ':CritiqueNextComments'                   , 'CL next comments'],
      \ 'u' : [ ':CritiqueUnresolvedComments'             , 'CL unresolved comments'],
      \ 'B' : [ 'BlazeBuild'                              , 'Async Build'],
      \ 'T' : [ 'BlazeTest'                               , 'Async Test'],
      \ }
" Rust 
let g:which_key_map.R = {
      \ 'name' : '+Rust',
      \ 'r' : [ ':AsyncRustRun'                  , 'Run file'],
      \ 'b' : [ ':AsyncRustBuild'                , 'Compile file'],
      \ 'c' : [ ':AsyncCargoBuild'               , 'Compile cargo'],
      \ 'x' : [ ':AsyncCargoRun'                 , 'Run cargo bin'],
      \ 't' : [ ':AsyncCargoTest'                , 'Test cargo'],
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
      \ '1' : [':e ~/.vimrc'                                           , 'vimrc'],
      \ '2' : [':e ~/.vimrc.plug'                                      , 'vimrc plug'],
      \ '3' : [':e ~/.zshrc'                                           , 'zshrc'],
      \ 'i' : [':e ~/.config/nvim/init.vim'                            , 'open init'],
      \ 'k' : [':e ~/.config/nvim/keys/which-key.vim'                  , 'which keys'],
      \ 'p' : [':e ~/.config/nvim/vim-plug/plugins.vim'                , 'vim-plug'],
      \ 'h' : [':O h'                                                  , 'open .h'],
      \ 'c' : [':O cc'                                                 , 'open .cc'],
      \ 'b' : [':O b'                                                  , 'open BUILD'],
      \ 't' : [':O t'                                                  , 'open test'],
      \ 'g' : [':O go'                                                 , 'open .go'],
      \ 'l' : [':OpenCL'                                               , 'open CL'],
      \ }
" Piper
let g:which_key_map.P = {
      \ 'name' : '+Piper',
      \ 's' : [ ':G4Diff'                               , 'g4 diff'],
      \ 'e' : [ ':G4Edit'                               , 'g4 edit'],
      \ 'z' : [ ':G4Revert'                             , 'g4 revert'],
      \ 'a' : [ ':G4Add'                                , 'g4 add'],
      \ 'A' : [ ':G4AddTo'                              , 'g4 addto'],
      \ 'l' : [ ':Blame'                                , 'g4 blame'],
      \ 'p' : [ ':Ppending'                             , 'g4 pending'],
      \ 'u' : [ ':!p4 sync'                             , 'p4 sync'],
      \ }
" project
let g:which_key_map.p = {
      \ 'name' : '+projects' ,
      \ 'q' : [':qa!'                                       , 'quit all'],
      \ 's' : [':wqa!'                                      , 'save&quit all'],
      \ 'w' : [':w!'                                        , 'save!'],
      \ 'S' : [':SSave'                                     , 'save session'],
      \ 'e' : [':e ~/.vimrc'                          	    , 'open init' ],
      \ 'b' : [':e ~/.vimrc.plug'                        , 'open plug' ],
      \ 'h' : ['Startify'                                   , 'home' ],
      \ 'f' : [':Prettier'                                  , 'Pretties' ],
      \ }
" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'              , 'history'],
      \ ';' : [':Commands'              , 'commands'],
      \ 'a' : [':Ag'                    , 'text Ag'],
      \ 'B' : [':BLines'                , 'current buffer'],
      \ 'b' : [':Buffers'               , 'open buffers'],
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
      \ 'e' : [":call InterestingWords('n')"          , 'search words'],
      \ }
      " \ 's' : [':Snippets'     , 'snippets'],
" t is for terminal
let g:which_key_map.t = {
      \ 'name' : '+terminal' ,
      \ 't' : [':FloatermNew --wintype=popup --width=50 --height=60'   , 'terminal'],
      \ '.' : [':FloatermNew --wintype=popup --width=60 --height=25'   , 'small terminal'],
      \ '1' : [':FloatermFirst'                                        , 'first terminal'],
      \ '0' : [':FloatermLast'                                         , 'last terminal'],
      \ 'n' : [':FloatermNext'                                         , 'next terminal'],
      \ 'p' : [':FloatermPrev'                                         , 'prev terminal'],
      \ 'k' : [':FloatermKill'                                         , 'kill terminal'],
      \ 'h' : [':FloatermHide'                                         , 'hide terminal'],
      \ 'f' : [':FloatermNew fzf'                               , 'fzf'],
      \ 'g' : [':FloatermNew lazygit'                           , 'git'],
      \ 'i' : [':FloatermNew ipython'                           , 'ipython'],
      \ 'r' : [':FloatermNew ranger'                            , 'ranger'],
      \ ';' : [':FloatermToggle'                                , 'toggle'],
      \ 'y' : [':FloatermNew gotop -sbpa'                       , 'gotop'],
      \ 'm' : [':FloatermNew --width=50 --height=8 playm'       , 'play music'],
      \ 'v' : [':FloatermNew --width=50 --height=8 playv'       , 'play video'],
      \ 'c' : [':FloatermNew --width=50 --height=8 termv'       , 'play tv'],
      \ 'T' : [':FloatermNew --width=70 --height=15 ttyper'     , 'Rust typer'],
      \ 'Z' : [':FloatermNew --width=70 --height=15 typer'      , 'Go typer'],
      \ }
" Diagnose
let g:which_key_map.x = {
      \ 'name' : '+Diagnose' ,
      \ 'q' : [ 'copen'                                         , 'show quickfix' ],
      \ 'x' : [ ':LspTroubleToggle'                             , 'toggle lsp trouble' ],
      \ 'w' : [ ':LspTroubleToggle lsp_workspace_diagnostics'   , 'lsp workspace' ],
      \ 'd' : [ ':LspTroubleToggle lsp_document_diagnostics'    , 'lsp document' ],
      \ 'c' : [ ':LspTroubleToggle quickfix'                    , 'lsp quickfix' ],
      \ 'l' : [ ':LspTroubleToggle loclist'                     , 'lsp loclist' ],
      \ 'r' : [ ':LspTroubleToggle lsp_references'              , 'lsp refs' ],
      \}
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
set wildmode=longest,list,full
set wildmenu
" tab completion.
ino <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
ino <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
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
autocmd VimEnter * call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('h', 'Red', 'none', '#ffa500', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('cc', 'cyan', 'none', 'cyan', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('c', 'cyan', 'none', 'cyan', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('go', 'Magenta', 'none', '#ff00ff', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('rs', 'Gray', 'none', '#686868', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
autocmd VimEnter * call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')
" NERDTrees File highlighting only the glyph/icon
" test highlight just the glyph (icons) in nerdtree:
autocmd filetype nerdtree highlight haskell_icon ctermbg=none ctermfg=Red guifg=#ffa500
autocmd filetype nerdtree highlight html_icon ctermbg=none ctermfg=Red guifg=#ffa500
autocmd filetype nerdtree highlight go_icon ctermbg=none ctermfg=Red guifg=#ffa500

autocmd filetype nerdtree syn match haskell_icon ## containedin=NERDTreeFlags
" if you are using another syn highlight for a given line (e.g.
" NERDTreeHighlightFile) need to give that name in the 'containedin' for this
" other highlight to work with it
autocmd filetype nerdtree syn match html_icon ## containedin=NERDTreeFlags,html
autocmd filetype nerdtree syn match go_icon ## containedin=NERDTreeFlags
"fish
au BufNewFile,BufRead fish_funced set ft=fish
"from makc => My New Terminal: Alaritty 19:05
" allow alaritty to have a transparent background."
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
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
set guifont=FiraCode\ Nerd\ Font\ Mono:h24

"" neovide configs"
set mouse=nicr
set mouse=a
let g:neovide_transparency=0.95
let g:neovide_cursor_antialiasing=v:true
" also sonicboom, wireframe 
let g:neovide_cursor_vfx_mode="torpedo"
set guioptions-=m "remove menu bar"
set guioptions-=T "remove toolbar"
set guioptions-=r "remove right-hand scroll bar"
set guioptions-=L "remove left-hand scroll bar"
" ================ settings ======================

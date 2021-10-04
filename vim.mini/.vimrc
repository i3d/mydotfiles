set nocompatible cul
set rtp+=~/homebrew/opt/vim
set rtp+=~/homebrew/opt/fzf
set rtp+=~/.vim
source ~/.vimrc.plug
let g:LustyJugglerSuppressRubyWarning = 1
" for italic
set t_ZH=[3m
set t_ZR=[23m
let g:asyncrun_open = 10
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg', '.projectile']
augroup nongo_indent
au!
au VimEnter *.virc,*.lua,*.rs,*.sh,*.vim*,*.bash*,*.zsh*,*.h,*.cc,*.html,*.toml,*.py set ts=2 sw=2 sts tw=0 expandtab
augroup END
" intend + manual folding
"augroup folding
"  au!
"  au! BufReadPre * setlocal foldmethod=indent
"  au! BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"augroup END
augroup vista_sidebar
au!
au VimEnter *.go,*.rs nested :Vista!!
" this will keep vista not able to jump window."
au BufLeave,BufWinLeave,BufDelete,BufHidden,BufUnload,WinLeave,VimLeave <buffer> ++once :Vista!
augroup END
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nno <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vno <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
nno <silent> <localleader> :silent <c-u> :silent WhichKey ','<CR>
" ============================ GOOGLE3 =========================="
if fnamemodify(resolve(expand('%:p')), ':h') =~ 'google3'
  highlight SignifySignAdd    cterm=bold ctermbg=0  ctermfg=2
  highlight SignifySignDelete cterm=bold ctermbg=0  ctermfg=4
  highlight SignifySignChange cterm=bold ctermbg=0  ctermfg=3
  " update signify whenever we get focus, not just on save
  let g:signify_update_on_focusgained = 1
  let g:signify_realtime = 1
  let g:signify_cursorhold_insert = 0
  let g:signify_cursorhold_normal = 0
  let g:signify_vcs_list = [ 'perforce', 'hg' ]
  let g:signify_vcs_cmds = {
        \ 'perforce': 'DIFF=%d" -U0" citcdiff.bin %f || [[ $? == 1 ]]',
        \ 'hg': 'hg diff -r p4head --color never --config defaults.diff= --nodates -U0 -- %f',
        \ }
  let g:signify_vcs_cmds_diffmode = { 'perforce': 'citcdiff.bin -b %f || true' }
  let g:signify_skip_filename_pattern = ['\.pipertmp.*']
  let g:signify_line_highlight = 0
  let g:blazevim_quickfix_autoopen = 1
  let g:blazevim_execution='background'
  let s:ignore_warnings = 0
  " Cider
  " Send async completion requests.
  let g:lsp_async_completion = 1
  let g:lsp_signs_enabled = 1           " enable diagnostics signs in the gutter
  let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
  let g:lsp_highlight_references_enabled = 1
  let g:lsp_signature_help_enabled = 1
  let g:asyncomplete_auto_popup = 1
  "let g:asyncomplete_smart_completion = 1
  if has('nvim')
    let g:lsp_preview_float = 1
  endif
  au User lsp_setup call lsp#register_server({
        \ 'name': 'CiderLSP',
        \ 'cmd': {server_info->[
        \   '~/bin/ciderlsp',
        \   '--tooltag=vim-lsp',
        \   '--noforward_sync_responses',
        \   '--hub_addr=blade:languageservices',
        \ ]},
        \ 'whitelist': ['c', 'cpp', 'java', 'proto', 'python', 'textproto', 'go', 'swift', 'BUILD'],
        \})
  augroup corp_programming
    au!
    au FileType bzl,cpp,go,java,proto,python nno <silent> gd :vert LspDefinition<CR>
    au FileType bzl,cpp,go,java,proto,python nno <silent> gm :LspRename<CR>
    au FileType bzl,cpp,go,java,proto,python nno <silent> gr :LspReferences<CR>
    au FileType bzl,cpp,go,java,proto,python nno <silent> gp :LspPeekDefinition<CR>
    au FileType bzl,cpp,go,java,proto,python nno <silent> g. :LspDocumentSymbol<CR>
    au FileType bzl,cpp,go,java,proto,python nno <silent> g= :LspDocumentFormat<CR>
    au FileType bzl,cpp,go,java,proto,python nno <silent> ] :LspNextDiagnostic<CR>
    au FileType bzl,cpp,go,java,proto,python nno <silent> [ :LspPreviousDiagnostic<CR>
    au FileType bzl,cpp,go,java,proto,python nno <silent> g/ :LspDocumentSymbolSearch<CR>
    au FileType bzl,cpp,go,java,proto,python nno <silent> g\ :LspCodeAction<CR>
    au FileType bzl,cpp,go,java,proto,python nno <silent> H :LspHover<CR>
    " :setfiletype <c-d>
    au FileType
          \ bzl,cpp,go,java,proto,python,
          \textproto,yaml,typescript,javascript,
          \gslb,html,json,ncl,p4-spec,pbtxt,piccolo,
          \gcl,sdl,sh,sql,text,textpb,tf,tpl,tpp,xml,zsh
          \ nno <silent> K <cmd>lua require"plugins.blame".desc()<CR>
  augroup END
endif
" ============================ GOOGLE3 =========================="
" ================ functions and commands ======================
" window management
function! ResCur() abort
  if line("'\"") <= line("$")
    silent! normal! g`"
    return 1
  endif
endfunction
augroup resCur
  au!
  au BufWinEnter * call ResCur()
augroup END
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
function! s:AsyncGoRunThis() abort
  call s:AsyncGoRunFile(expand('%'))
endfunction
function! s:AsyncGoRunFile(file) abort
	"open cwindow manually.
  let l:aro = g:asyncrun_open
  let g:asyncrun_open = 0
  call setqflist([]) | copen 30
  " don't use !, so we scrolling the output.
  call asyncrun#run("", {"rows": 30}, 'go run '.a:file)
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
com! -nargs=* AsyncGoRunThis :call <SID>AsyncGoRunThis()
" ================ functions and commands ======================
" ================ themes ======================
set background=dark
if $NOTRUECOLOR
	set notermguicolors
else
	set termguicolors
endif
colorscheme darkmatrix 
""" perfect fit for matrix!!
" ##########################################
let g:javascript_plugin_flow = 1
" ================ themes ======================
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
if !has("nvim")
    set term=xterm-256color
endif
"https://github.com/ryanoasis/powerline-extra-symbols
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
" select the whole line.
nno Z :set nonu nornu mouse=<cr>
nno X :set nu rnu mouse=nvicar<cr>
nno C :set mouse=<cr>
"nno vd :v/\S/d<cr>
"nno vb :v/\S/,/\S/-j<cr>
nno vd :g/^\s*$/d<cr>
nno vb :%s/\n\{3,}/\r\r/e<cr>
nno Y y$
nno n nzzzv
nno N Nzzzv
nno J mzJ`z
nno <c-j> :cnext<cr>zzzv
nno <leader><tab> <c-^>
nno cn *``cgn
nno cN *``cgN
" fp => paste whatever yanked to the end of cursor line.
" ap => paste whatever yanked to the beginning of the cursor line.
" ep => copy the line above and paste to the end of cursor line.
" xp => copy the line below and paste to the end of cursor line.
" sp => copy the line below and paste to the beginning of the curso line.
" ep => copy the line above and paste to the beginning of the curso line.
" key layouts on keyboard indicates the directions:
"    e
" a s d f
"    x
" s => mimic "j", go down; d => mimic "k", go up.
nno vl $v^y
nno fp A<space><esc>p
nno ap ^Pa<space><esc>
nno ep k$v^yjA<space><esc>p
nno xp j$v^ykA<space><esc>p
nno sp j$v^yk^Pa<space><esc>
nno dp k$v^yj^Pa<space><esc>
vno v; :'<,'>normal! A;<cr>
vno v0 :'<,'>normal! A)<cr>
vno v9 :'<,'>normal! A}<cr>
vno v] :'<,'>normal! A]<cr>
vno v, :'<,'>normal! A,<cr>
vno v. :'<,'>normal! A.<cr>
" most langs.
"vno v/ :'<,'>normal! I// <cr>
vno v/ :s/^/\/\/ /g<cr>
vno r/ :s/^\/\/ //g<cr>
" for scripts.
"vno v\ :'<,'>normal! I# <cr>
vno v\ :s/^/# /g<cr>
vno r\ :s/^# //g<cr>
" for vim.
"vno v' :'<,'>normal! I" <cr>
vno v' :s/^/" /g<cr>
vno r' :s/^" //g<cr>
" for lua.
"vno v- :'<,'>normal! I-- <cr>
vno v- :s/^/-- /g<cr>
vno r- :s/^-- //g<cr>
" remove trailing spaces.
vno v= :s/\v\s+$//g<cr>
vno < <gv
vno > >gv
nno e, yiw
nno e. yiW
nno w, yaw
nno w. yaW
nno o o<esc>
nno O O<esc>
" jump break, this is super.
ino , ,<c-g>u
ino ; ;<c-g>u
ino ' '<c-g>u
ino " "<c-g>u
ino . .<c-g>u
ino ! !<c-g>u
ino ? ?<c-g>u
ino : :<c-g>u
ino [ [<c-g>u
ino ] ]<c-g>u
ino { {<c-g>u
ino } }<c-g>u
ino ( (<c-g>u
ino ) )<c-g>u
ino / /<c-g>u
ino = =<c-g>u
ino + +<c-g>u
ino - -<c-g>u
ino _ _<c-g>u
ino @ @<c-g>u
ino $ $<c-g>u
ino % %<c-g>u
ino ^ ^<c-g>u
ino & &<c-g>u
ino * *<c-g>u
" jumplist
nno <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nno <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
" select last paste in visual mode
" Map leader to which_key
"split"
nno - <C-W>-
nno = <C-W>+
"vsplit"
nno < 100<C-W><
nno > 100<C-W>>
vno J :m '>+1<cr>gv=gv
vno K :m '<-2<cr>gv=gv
vno C :CommentToggle<cr>
nno <c-c> :CommentToggle<cr>
ino <c-j> <esc>:m .+1<cr>==
ino <c-k> <esc>:m .-2<cr>==
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
ino jk <esc>
ino <capslock> <esc>
"ino vv <esc>
nno <silent> <tab> <c-w>w
cno w!! w !sudo tee % >/dev/null
nno <F12> "%phr_I#ifndef __<Esc>gUwyypldwidefine <Esc>yypldwiendif //<Esc>O<Esc>
",ig"
nno <localleader>da <cmd>lua require('vimway-lsp-diag').open_all_diagnostics()<cr>
nno <localleader>d0 <cmd>lua require('vimway-lsp-diag').open_buffer_diagnostics()<cr>
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
nno <silent> <localleader>oo :SessionOpen<cr>
nno <silent> <localleader>ss :SessionSave
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
nno <silent> <localleader>Gh :Greph<space>
nno <silent> <localleader>Gc :Grepcc<space>
nno <silent> <localleader>Gg :Grepgo<space>
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
nno <silent> <localleader>oe :clist<cr>
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
nno <silent> <localleader>T :CocList colors<cr>
nno <silent> <localleader>ct :CommentToggle<cr>
"NERDTree"
nno <localleader>to :NERDTreeTabsOpen<cr>
nno <localleader>tf :NERDTreeTabsFind<cr>
nno <localleader>tg :NERDTreeTabsToggle<cr>
"vifm mapping
nno <localleader>vt :TabVifm<cr>
nno <localleader>vs :VsplitVifm<cr>
nno <localleader>vd :DiffVifm<cr>
" == surround ==
" S<sign to surround> for virtual mode.
nno <localleader>lq :norm yss'<cr>
nno <localleader>lQ :norm yss"<cr>
nno <localleader>l* :norm yss*<cr>
nno <localleader>l[ :norm yss[<cr>
nno <localleader>l] :norm yss]<cr>
nno <localleader>l{ :norm yss{<cr>
nno <localleader>l} :norm yss}<cr>
nno <localleader>l( :norm yss(<cr>
nno <localleader>l) :norm yss)<cr>
nno <localleader>wq :norm ysiw'<cr>
nno <localleader>wQ :norm ysiw"<cr>
nno <localleader>Wq :norm ysaW'<cr>
nno <localleader>WQ :norm ysaW"<cr>
nno <localleader>w) :norm ysiw)<cr>
nno <localleader>w( :norm ysiw(<cr>
nno <localleader>W) :norm ysaW)<cr>
nno <localleader>W( :norm ysaW(<cr>
nno <localleader>w* :norm ysiw*<cr>
nno <localleader>W* :norm ysaW*<cr>
nno <localleader>w] :norm ysiw]<cr>
nno <localleader>w[ :norm ysiw[<cr>
nno <localleader>W] :norm ysaW]<cr>
nno <localleader>W[ :norm ysaW[<cr>
nno <localleader>w} :norm ysiw{<cr>
nno <localleader>w{ :norm ysiw}<cr>
nno <localleader>W} :norm ysaW{<cr>
nno <localleader>W{ :norm ysaW}<cr>
nno <localleader>p} :norm ysip}<cr>
nno <localleader>p{ :norm ysip{<cr>
" ds and cs works.
" == surround == "
" au BufWrite *.rs :RustFmt
let g:rustfmt_autosave = 1
" ==================== space macs simulation layer ========
" ==================== space macs simulation layer ========
" source $HOME/.config/nvim_back/plug-config/coc.vim
" source $HOME/.vim/plugged/coc.nvim/plugin/coc.vim
" https://github.com/neoclide/coc.nvim/blob/master/doc/coc.txt
let g:coc_user_config = {}
let g:coc_user_config['coc.preferences.jumpCommand'] = 'vsplit'
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
"let g:which_key_map['c'] = [ ':Codi!!'                   , 'virtual repl']
let g:which_key_map['d'] = [ ':bd'                        , 'delete buffer']
let g:which_key_map['e'] = [ ':CocCommand explorer'       , 'explorer' ]
" use <leader>sf
let g:which_key_map['F'] = [ ':Files'                     , 'FZF Files' ]
let g:which_key_map['f'] = [':Telescope find_files find_command=rg,-.,-i,--files'  	  , 'Tele Files']
"let g:which_key_map['f'] = [':Telescope file_browser'  , 'files']
let g:which_key_map['r'] = [ ':RnvimrToggle'              ,'ranger' ]
let g:which_key_map['S'] = [ ':SessionSave '              , 'save session' ]
let g:which_key_map['L'] = [ ':SessionOpen'               , 'open session' ]
let g:which_key_map['v'] = [ ':<C-W>v'                    , 'split right']
"let g:which_key_map['z'] = [ ':ZenMode'                  , 'zen' ]
let g:which_key_map['z'] = [ ':Twilight'                  , 'zen' ]
let g:which_key_map['m'] = [ ':TZFocus'                   , 'Max/UnMax' ]
let g:which_key_map['?'] = [ ':CocList maps'              , 'maps' ]
let g:which_key_map['B'] = [ ':Vista'                     , 'Tags' ]
let g:which_key_map["'"] = [ ':FloatermNew --width=50 --height=60' , 'shell' ]
let g:which_key_map['h'] = [ ':FloatermKill'              , 'kill shell' ]
let g:which_key_map['q'] = [ ':q!'                        , 'quit']
let g:which_key_map['n'] = [ ':bnext'                     , 'cycle buffers' ]
let g:which_key_map['`'] = [ ':TSHighlightCapturesUnderCursor' , 'TSInfo' ]
let g:which_key_map['u'] = [ ':e #'                       , 'ropen' ]
let g:which_key_map['\'] = [ ':TSPlaygroundToggle'        , 'TS' ]
" Group mappings
" a is for actions
let g:which_key_map.a = {
      \ 'name' : '+actions' ,
      \ 'c' : [':ColorizerToggle'        , 'colorizer'],
      \ 'e' : [':CocCommand explorer'    , 'explorer'],
      \ 'r' : [':luafile %'              , 'lua run %'],
      \ 's' : [':let @/ = ""'            , 'remove search highlight'],
      \ 'v' : [':Vista!!'                , 'tag viewer'],
      \ }
" b is for buffer
let g:which_key_map.b = {
      \ 'name' : '+buffer',
      \ '1' : [':b1'                                         , 'buffer 1']        ,
      \ '2' : [':b2'                                         , 'buffer 2']        ,
      \ 'd' : [':bd'                                         , 'delete-buffer']   ,
      \ 'f' : [':bfirst'                                     , 'first-buffer']    ,
      \ 'h' : [':Startify'                                   , 'home-buffer']     ,
      \ 'l' : [':blast'                                      , 'last-buffer']     ,
      \ 'n' : [':bnext'                                      , 'next-buffer']     ,
      \ 'p' : [':bprevious'                                  , 'previous-buffer'] ,
      \ '?' : [':Buffers'                                    , 'fzf-buffer']      ,
      \ 'b' : [':CocList buffers'                           , 'all buffers'],
      \ 'm' : [':CocList marks'                             , 'all marks'],
      \ }
" code
let g:which_key_map.c = {
      \ 'name' : '+code' ,
      \ 'h' : [':Greph'                                         , 'search .h'],
      \ 'c' : [':Grephcc'                                       , 'search .cc'],
      \ 'g' : [':Grephgo'                                       , 'search .go'],
      \ 't' : [':Twilight'                                      , 'Twilight coding'],
      \ 'z' : [':ZenMode'                                       , 'ZenMode coding'],
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
      \ 'B' : [ ':BlazeBuild'                              , 'Async Build'],
      \ 'T' : [ ':BlazeTest'                               , 'Async Test'],
      \ }
" Rust & Go
let g:which_key_map.R = {
      \ 'name' : '+Rust',
      \ 'r' : [ ':AsyncRustRun'                  , 'Run file'],
      \ 'b' : [ ':AsyncRustBuild'                , 'Compile file'],
      \ 'c' : [ ':AsyncCargoBuild'               , 'Compile cargo'],
      \ 'x' : [ ':AsyncCargoRun'                 , 'Run cargo bin'],
      \ 't' : [ ':AsyncCargoTest'                , 'Test cargo'],
      \ 'g' : [ ':AsyncGoRunThis'                , 'go run this'],
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
      \ 'o' : [':SessionOpen'             			  , 'open session'],
      \ '1' : [':vsp ~/.vimrc'                                    , 'vimrc'],
      \ '2' : [':vsp ~/.vimrc.plug'                               , 'vimrc plug'],
      \ '3' : [':vsp ~/.vim/init.lua'                             , 'vimrc init.lua'],
      \ '4' : [':vsp ~/.zshrc'                                    , 'zshrc'],
      \ '5' : [':vsp ~/.zshrc.pre-oh-my-zsh'                      , 'zshrc pre-omz'],
      \ '6' : [':vsp ~/.zshenv'                                   , 'zshenv'],
      \ '7' : [':vsp ~/bin/cheat'                                 , 'cheatsheet'],
      \ 'i' : [':vsp ~/.config/nvim/init.vim'                     , 'open init'],
      \ 'k' : [':vsp ~/.config/nvim/keys/which-key.vim'           , 'which keys'],
      \ 'p' : [':vsp ~/.config/nvim/vim-plug/plugins.vim'         , 'vim-plug'],
      \ 'h' : [':O h'                                             , 'open .h'],
      \ 'c' : [':O cc'                                            , 'open .cc'],
      \ 'b' : [':O b'                                             , 'open BUILD'],
      \ 't' : [':O t'                                             , 'open test'],
      \ 'g' : [':O go'                                            , 'open .go'],
      \ 'l' : [':OpenCL'                                          , 'open CL'],
      \ 'w' : [':!vieb "<cWORD>"'                                 , 'open link'],
      \ 's' : [':!vieb "google.com/search?q=<cword>"'             , 'search web'],
      \ 'v' : [':vsp /tmp/foo.go'                  		  , 'vsp file'],
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
      \ 'a' : [':qa!'                                       , 'quit all'],
      \ 's' : [':wqa!'                                      , 'save&quit all'],
      \ 'w' : [':w!'                                        , 'save!'],
      \ 'S' : [':SessionSave '                              , 'save session'],
      \ 'e' : [':e ~/.vimrc'                          	    , 'open init' ],
      \ 'b' : [':e ~/.vimrc.plug'                           , 'open plug' ],
      \ 'h' : ['Startify'                                   , 'home' ],
      \ 'f' : [':Prettier'                                  , 'Pretties' ],
      \ }
" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '.' : [':Vista finder'          , 'Tags'],
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
      \ '?' : [':FloatermNew --wintype=popup --width=90 --height=50 w3m https://quickref.me/vim'   , 'vim quickref'],
      \ '.' : [':FloatermNew --wintype=popup --width=60 --height=25'   , 'small terminal'],
      \ '1' : [':FloatermFirst'                                        , 'first terminal'],
      \ '0' : [':FloatermLast'                                         , 'last terminal'],
      \ 'j' : [':FloatermNext'                                         , 'next terminal'],
      \ 'k' : [':FloatermPrev'                                         , 'prev terminal'],
      \ 'q' : [':FloatermKill'                                         , 'kill terminal'],
      \ 'h' : [':FloatermHide'                                         , 'hide terminal'],
      \ 'f' : [':FloatermNew fzf'                               , 'fzf'],
      \ 'g' : [':FloatermNew lazygit'                           , 'git'],
      \ 'i' : [':FloatermNew ipython'                           , 'ipython'],
      \ 'r' : [':FloatermNew ranger'                            , 'ranger'],
      \ ';' : [':FloatermToggle'                                , 'toggle'],
      \ 's' : [':FloatermNew gotop -sbpa'                       , 'gotop'],
      \ 'm' : [':FloatermNew --width=50 --height=8 playm'       , 'play music'],
      \ 'v' : [':FloatermNew --width=50 --height=8 playv'       , 'play video'],
      \ 'c' : [':FloatermNew --width=50 --height=8 termv'       , 'play tv'],
      \ 'T' : [':FloatermNew --width=70 --height=15 ttyper'     , 'Rust typer'],
      \ 'Z' : [':FloatermNew --width=70 --height=15 typer'      , 'Go typer'],
      \ 'n' : [':FloatermNew --width=90 --height=30 nb'         , 'newsboat'],
      \ 'o' : [':FloatermNew --width=90 --height=30 tor'        , 'the old reader'],
      \ 'y' : [':FloatermNew --width=110 --height=8 ytfzf -fm'   , 'ytfzf music'],
      \ '/' : [':FloatermNew --width=110 --height=8 ytfzf -f'      , 'ytfzf video'],
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
" Telescope                                                                            
let g:which_key_map.T = {                                                         
        \ 'name' : '+Telescope' ,                                                   
        \ 'A' : [':Telescope autocommands'                         , 'Telescope autocommands'],
        \ 'B' : [':Telescope builtin'                              , 'Telescope builtin'],
        \ 'C' : [':Telescope commands'                             , 'Telescope vim commands'],
        \ 'K' : [':Telescope keymaps'                              , 'Telescope keymaps'],
        \ 'O' : [':Telescope vim_options'                          , 'Telescope vim options'],
        \ 'R' : [':Telescope registers'                            , 'Telescope registers'],
        \ 'H' : [':Telescope search_history'                       , 'Telescope search history'],
        \ 'M' : [':Telescope man_pages'                            , 'Telescope man page'],
        \ 'L' : [':Telescope loclist'                              , 'Telescope loclist'],
        \ 'Q' : [':Telescope quickfix'                             , 'Telescope quickfix'],
        \ '/' : [':Telescope current_buffer_fuzzy_find'            , 'Telescope curbuf search'],
        \ '.' : [':Telescope file_browser'      , 'Telescope browser'],
        \ 'b' : [':Telescope buffers'                              , 'Telescope buffers'],
        \ 'f' : [':Telescope find_files find_command=rg,--hidden,-i,--files,-l'       , 'Telescope find files'],
        \ 'g' : [':Telescope live_grep'                            , 'Telescope grep'],
        \ 'h' : [':Telescope help_tags'                            , 'Telescope vim help'],
        \ 'm' : [':Telescope marks'                                , 'Telescope marks'],
        \ 'c' : [':Telescope command_history'                      , 'Telescope q:'],
        \ 's' : [':Telescope oldfiles'                             , 'Telescope switch files'],
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
" c-x/c-a +- num/alpha.
set nrformats+=alpha
set wildmenu
set wildmode=longest:full,full
" https://sharksforarms.dev/posts/neovim-rust/
" tab completion
ino <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
ino <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)
" https://sharksforarms.dev/posts/neovim-rust/
" COQ config
let g:coq_settings = {}
autocmd VimEnter *.rs execute 'COQnow'
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
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_auto_type_info = 1
" autocomplete for Go using omnifunc. <TAB> doesn't work for some reason.
" maybe related to the rust setup, need investigate.
" https://tpaschalis.github.io/vim-go-setup/
" another one with coc: https://octetz.com/docs/2019/2019-04-24-vim-as-a-go-ide/
au filetype go inoremap <buffer> . .<C-x><C-o>
"disable ruby warning.
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
" !!!! These two lines have side effect of the new neovim syntax
" highlight loading change. 
" https://github.com/neovim/neovim/pull/14771
" The theme after enable these doesn't look too bad but it's still unexpected.
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
" !!!! These two lines have side effect of the new neovim syntax
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
set guifont=FiraCode\ Nerd\ Font\ Mono:h22
"" neovide configs"
set mouse=nvicar
"set mouse=a
let g:neovide_transparency=0.97
let g:neovide_cursor_antialiasing=v:true
" also sonicboom, wireframe 
let g:neovide_cursor_vfx_mode="torpedo"
set guioptions-=m "remove menu bar"
set guioptions-=T "remove toolbar"
set guioptions-=r "remove right-hand scroll bar"
set guioptions-=L "remove left-hand scroll bar"
set completeopt=menuone,noinsert,noselect
set shortmess+=c
" ============================== nvim native lsp usage
" https://sharksforarms.dev/posts/neovim-rust/
" " Code navigation shortcuts
"nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nno <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nno <silent> gD    <cmd>lua vim.lsp.buf.references()<CR>
nno <silent> H     <cmd>lua vim.lsp.buf.hover()<CR>
nno <silent> g.    <cmd>lua vim.lsp.buf.code_action()<CR>
" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=3000
" Show diagnostic popup on cursor hold, this is pretty annoying, 
" we changed to use vimway diagnose.
" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
" Goto previous/next diagnostic warning/error
nno <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nno <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
set signcolumn=yes " fix jitter
" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
"nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
"nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
"nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
"nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" spell
imap <c-l> <c-g>u<Esc>[s1z=`]a<c-g>u
nmap <c-l> [s1z=`]a<c-g>u
set spell
""""""""""""""""""""""""""""""""""""""""""""""
" wilder setup
" need to run :UpdateRemotePlugins
call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\Tab><"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
call wilder#set_option('modes', ['/', '?', ':'])
call wilder#set_option('pipeline', [
	      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \       'sorter': wilder#python_difflib_sorter(),
      \     }),
      \     wilder#python_search_pipeline({
      \       'pattern': 'fuzzy',
      \     }),
      \   ),
      \ ])
let s:highlighters = [
	        \ wilder#pcre2_highlighter(),
        \ wilder#basic_highlighter(),
        \ ]
call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': wilder#popupmenu_renderer({
      \   'highlighter': s:highlighters,
      \   'left': [
      	      \     wilder#popupmenu_devicons(),
      \   ],
      \   'right': [
      	      \     ' ',
      \     wilder#popupmenu_scrollbar(),
      \   ],
      \ }),
      \ '/': wilder#wildmenu_renderer({
      \   'highlighter': s:highlighters,
      \ }),
      \ }))
""""""""""""""""""""""""""""""""""""""""""""""
"function! CustomFold()
"  return printf('   %6d%s', v:foldend - v:foldstart + 1, getline(v:foldstart))
"endfunction
"set fillchars=fold:\ | set foldtext=CustomFold()
" ================ settings ======================

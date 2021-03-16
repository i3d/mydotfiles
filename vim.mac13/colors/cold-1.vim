
"""
" Name: cold.vim
"""

set background=dark
hi clear

if exists('syntax on')
    syntax reset
endif

let g:colors_name='cold'
set t_Co=256


" javascript

hi javaScriptLineComment      guisp=NONE guifg=#4b6363 guibg=#1c1c1c ctermfg=240 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptCommentSkip      guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptComment          guisp=NONE guifg=#338282 guibg=#1c1c1c ctermfg=66  ctermbg=234 gui=NONE cterm=NONE
hi javaScriptSpecial          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptStringD          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptStringS          guisp=NONE guifg=#00ffaf guibg=#1c1c1c ctermfg=49  ctermbg=234 gui=NONE cterm=NONE
hi javaScriptStringT          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptEmbed            guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptSpecialCharacter guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptNumber           guisp=NONE guifg=#00d700 guibg=#1c1c1c ctermfg=40  ctermbg=234 gui=NONE cterm=NONE
hi javaScriptRegexpString     guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptFunction         guisp=NONE guifg=#0087d7 guibg=#1c1c1c ctermfg=32  ctermbg=234 gui=NONE cterm=NONE
hi javaScriptFunctionFold     guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptBraces           guisp=NONE guifg=#8ebdbd guibg=#1c1c1c ctermfg=109 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptParens           guisp=NONE guifg=#8ebdbd guibg=#1c1c1c ctermfg=109 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptCommentTodo      guisp=NONE guifg=#e34d84 guibg=#1c1c1c ctermfg=168 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptCharacter        guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptConditional      guisp=NONE guifg=#0087d7 guibg=#1c1c1c ctermfg=32  ctermbg=234 gui=NONE cterm=NONE
hi javaScriptRepeat           guisp=NONE guifg=#0087d7 guibg=#1c1c1c ctermfg=32  ctermbg=234 gui=NONE cterm=NONE
hi javaScriptBranch           guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptOperator         guisp=NONE guifg=#ff5f00 guibg=#1c1c1c ctermfg=202 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptType             guisp=NONE guifg=#dec11d guibg=#1c1c1c ctermfg=178 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptStatement        guisp=NONE guifg=#0087d7 guibg=#1c1c1c ctermfg=32  ctermbg=234 gui=NONE cterm=NONE
hi javaScriptError            guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScrParenError          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptNull             guisp=NONE guifg=#d75f5f guibg=#1c1c1c ctermfg=167 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptBoolean          guisp=NONE guifg=#87d7af guibg=#1c1c1c ctermfg=115 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptIdentifier       guisp=NONE guifg=#dec11d guibg=#1c1c1c ctermfg=178 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptLabel            guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptException        guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptMessage          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptGlobal           guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptMember           guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptDeprecated       guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptReserved         guisp=NONE guifg=#d4d47d guibg=#1c1c1c ctermfg=186 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptDebug            guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi javaScriptConstant         guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE

" misc

hi ColorColumn      guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi Conceal          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi Cursor           guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi lCursor          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi CursorIM         guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi CursorColumn     guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi CursorLine       guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi Directory        guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi DiffAdd          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi DiffChange       guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi DiffDelete       guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi DiffText         guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi EndOfBuffer      guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi ErrorMsg         guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi VertSplit        guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi Folded           guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi FoldColumn       guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi SignColumn       guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi IncSearch        guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi LineNr           guisp=NONE guifg=#4e4e4e guibg=21282C  ctermfg=239 ctermbg=235 gui=NONE cterm=NONE
hi LineNrAbove      guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi LineNrBelow      guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi CursorLineNr     guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi MatchParen       guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi ModeMsg          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi MoreMsg          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi NonText          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi Pmenu            guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi PmenuSel         guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi PmenuSbar        guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi PmenuThumb       guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi Question         guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi QuickFixLine     guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi Search           guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi SpecialKey       guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi SpellBad         guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi SpellCap         guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi SpellLocal       guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi SpellRare        guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi StatusLine       guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi StatusLineNC     guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi StatusLineTerm   guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi StatusLineTermNC guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi TabLine          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi TabLineFill      guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi TabLineSel       guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi Terminal         guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi Title            guisp=NONE guifg=#ffd700 guibg=#1c1c1c ctermfg=220 ctermbg=234 gui=NONE cterm=NONE
hi Visual           guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi VisualNOS        guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi WarningMsg       guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi WildMenu         guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE

" major

hi Normal     guisp=NONE guifg=#b3b5a7 guibg=21282C  ctermfg=145 ctermbg=235  gui=NONE   cterm=NONE
hi Comment    guisp=NONE guifg=#384545 guibg=NONE    ctermfg=238 ctermbg=NONE gui=italic cterm=italic
hi Constant   guisp=NONE guifg=#e6d15a guibg=NONE    ctermfg=185 ctermbg=NONE gui=NONE   cterm=NONE
hi Identifier guisp=NONE guifg=#a3a360 guibg=NONE    ctermfg=143 ctermbg=NONE gui=NONE   cterm=NONE
hi Statement  guisp=NONE guifg=#3b8766 guibg=NONE    ctermfg=65  ctermbg=NONE gui=NONE   cterm=NONE
hi PreProc    guisp=NONE guifg=#67692f guibg=NONE    ctermfg=240 ctermbg=NONE gui=NONE   cterm=NONE
hi Type       guisp=NONE guifg=#f2bd52 guibg=NONE    ctermfg=215 ctermbg=NONE gui=NONE   cterm=NONE
hi Special    guisp=NONE guifg=#b86c6c guibg=NONE    ctermfg=131 ctermbg=NONE gui=NONE   cterm=NONE
hi Underlined guisp=NONE guifg=#5fff87 guibg=NONE    ctermfg=84  ctermbg=NONE gui=NONE   cterm=NONE
hi Ignore     guisp=NONE guifg=#ffffff guibg=NONE    ctermfg=231 ctermbg=NONE gui=NONE   cterm=NONE
hi Error      guisp=NONE guifg=#b54f33 guibg=#1c1c1c ctermfg=131 ctermbg=234  gui=NONE   cterm=NONE
hi Todo       guisp=NONE guifg=#e34d84 guibg=NONE    ctermfg=168 ctermbg=NONE gui=NONE   cterm=NONE

" minor

hi String         guisp=NONE guifg=#997a48 guibg=NONE    ctermfg=101 ctermbg=NONE gui=NONE cterm=NONE
hi Character      guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234  gui=NONE cterm=NONE
hi Number         guisp=NONE guifg=#86f7a2 guibg=NONE    ctermfg=121 ctermbg=NONE gui=NONE cterm=NONE
hi Boolean        guisp=NONE guifg=#afd75f guibg=#1c1c1c ctermfg=149 ctermbg=234  gui=NONE cterm=NONE
hi Float          guisp=NONE guifg=#0087d7 guibg=1F2225  ctermfg=32  ctermbg=235  gui=NONE cterm=NONE
hi Function       guisp=NONE guifg=#8ebdbd guibg=#1c1c1c ctermfg=109 ctermbg=234  gui=NONE cterm=NONE
hi Conditional    guisp=NONE guifg=#4490bd guibg=#1c1c1c ctermfg=67  ctermbg=234  gui=NONE cterm=NONE
hi Repeat         guisp=NONE guifg=#0087d7 guibg=#1c1c1c ctermfg=32  ctermbg=234  gui=NONE cterm=NONE
hi Label          guisp=NONE guifg=#489eab guibg=#1c1c1c ctermfg=73  ctermbg=234  gui=NONE cterm=NONE
hi Operator       guisp=NONE guifg=#87d7d7 guibg=#1c1c1c ctermfg=116 ctermbg=234  gui=NONE cterm=NONE
hi Keyword        guisp=NONE guifg=#3e8eb3 guibg=NONE    ctermfg=67  ctermbg=NONE gui=NONE cterm=NONE
hi Exception      guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234  gui=NONE cterm=NONE
hi Include        guisp=NONE guifg=#698f63 guibg=#1c1c1c ctermfg=65  ctermbg=234  gui=NONE cterm=NONE
hi Define         guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234  gui=NONE cterm=NONE
hi Macro          guisp=NONE guifg=#618c61 guibg=#1c1c1c ctermfg=65  ctermbg=234  gui=NONE cterm=NONE
hi PreCondit      guisp=NONE guifg=#87d7d7 guibg=#1c1c1c ctermfg=116 ctermbg=234  gui=NONE cterm=NONE
hi StorageClass   guisp=NONE guifg=#8767a8 guibg=#1c1c1c ctermfg=97  ctermbg=234  gui=NONE cterm=NONE
hi Structure      guisp=NONE guifg=#68c4c4 guibg=#1c1c1c ctermfg=80  ctermbg=234  gui=NONE cterm=NONE
hi Typedef        guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234  gui=NONE cterm=NONE
hi SpecialChar    guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234  gui=NONE cterm=NONE
hi Tag            guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234  gui=NONE cterm=NONE
hi Delimiter      guisp=NONE guifg=#ffd700 guibg=#1c1c1c ctermfg=220 ctermbg=234  gui=NONE cterm=NONE
hi SpecialComment guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234  gui=NONE cterm=NONE
hi Debug          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234  gui=NONE cterm=NONE


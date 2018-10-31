" Options {{{
setlocal textwidth=80
" }}}
" Abbrevations {{{
" Shortcuts for loops and other structures (class...)
iabbrev <buffer> iff if:<esc>i
iabbrev <buffer> forr for:<esc>i
iabbrev <buffer> eliff elif:<esc>i
iabbrev <buffer> elsee else:<esc>o
iabbrev <buffer> deff def:<esc>i
iabbrev <buffer> rtn return
iabbrev <buffer> classs class:<esc>i
" }}}
" Mappings {{{
" comment line
nnoremap <buffer> <localleader>c I# <esc>
" uncomment line
nnoremap <buffer> <localleader>C 0vld
" automatically close {[(
inoremap <buffer> [ []<esc>i
inoremap <buffer> ( ()<esc>i
inoremap <buffer> { {}<esc>i
" automatically close '"
inoremap <buffer> " ""<esc>i
inoremap <buffer> ' ''<esc>i
" }}}
" Misc {{{
" highlight trailing spaces on save 
autocmd BufWritePre * match Error /\v +$/
" temporary mappings and abbreviations to force usage of new bindings :)
" remove some non abbreviated stuff
iabbrev <buffer> return NOOOOO
iabbrev <buffer> def NOOOOO
iabbrev <buffer> class NOOOOO
" }}}


" Options {{{
setlocal textwidth=80
" replace tabs with spaces and set tab=2spaces
setlocal expandtab
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
" }}}
" Mappings {{{
" automatically close {[(
inoremap <buffer> [ []<esc>i
inoremap <buffer> ( ()<esc>i
inoremap <buffer> { {}<esc>i
" automatically close '"
inoremap <buffer> " ""<esc>i
inoremap <buffer> ' ''<esc>i
" insert \n
inoremap <buffer> <leader><CR> \n
" }}}
" Abbreviations {{{
iabbrev <buffer> #i #include
inoreabbrev <buffer> iff if<space>()<space>{<esc>o}<esc>kf(a
inoreabbrev <buffer> forr for<space>()<space>{<esc>o}<esc>kf(a
inoreabbrev <buffer> whilee while<space>()<space>{<esc>o}<esc>kf(a
" }}}

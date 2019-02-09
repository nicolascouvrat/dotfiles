" Mappings {{{
" automatically close {[(
inoremap <buffer> [ []<esc>i
inoremap <buffer> ( ()<esc>i
inoremap <buffer> { {}<esc>i
" automatically close '"
inoremap <buffer> " ""<esc>i
inoremap <buffer> ' ''<esc>i
" }}}
" Abbreviations {{{
iabbrev <buffer> #i #include
inoreabbrev <buffer> iff if<space>()<space>{<esc>o}<esc>kf(a
inoreabbrev <buffer> forr for<space>()<space>{<esc>o}<esc>kf(a
inoreabbrev <buffer> whilee while<space>()<space>{<esc>o}<esc>kf(a
" }}}

" Mappings {{{
" automatically close {[(
inoremap <buffer> [ []<esc>i
inoremap <buffer> ( ()<esc>i
inoremap <buffer> { {}<esc>i
" automatically close '"
inoremap <buffer> " ""<esc>i
" Not for single quote as it is annoying for lifetimes
" automatically close <
inoremap <buffer> < <><esc>i
" }}}
" Plugin related mappings {{{
let g:rustfmt_autosave = 1
" }}}

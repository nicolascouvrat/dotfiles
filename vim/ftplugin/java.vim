" Abbreviations {{{
iabbrev <buffer> iff if<space>()<space>{<esc>o}<esc>kf(a
iabbrev <buffer> forr for<space>()<space>{<esc>o}<esc>kf(a
" }}}
" Mappings {{{
" automatically close {[(
inoremap <buffer> [ []<esc>i
inoremap <buffer> ( ()<esc>i
inoremap <buffer> { {}<esc>i
" automatically close '"
inoremap <buffer> " ""<esc>i
inoremap <buffer> ' ''<esc>i
" automatically close <
inoremap <buffer> < <><esc>i
" }}}
" Autocommands {{{
augroup java
  " It is critical to specify buffer in the autocmd! too! See this link: https://vi.stackexchange.com/questions/8056/for-an-autocmd-in-a-ftplugin-should-i-use-pattern-matching-or-buffer
  autocmd! BufWritePost <buffer>
  autocmd BufWritePost <buffer> silent! call simpletags#UpdateTags()
  autocmd BufWritePost <buffer> call java#FormatFile()
augroup END
" }}}

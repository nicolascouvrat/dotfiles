" Abbreviations {{{
iabbrev <buffer> iff if<space>()<space>{<esc>o}<esc>kf(a
iabbrev <buffer> forr for<space>()<space>{<esc>o}<esc>kf(a
" }}}
" Misc {{{
autocmd BufWritePre * match Error /\v +$/
inoremap <buffer> <leader>E :!javac %
" }}}

setlocal spell
" compile
nnoremap <buffer> <leader>co :!latex %<cr>
" compile and open
nnoremap <buffer> <leader>ex :!latex % & evince %:r.dvi<cr>
" Plugin related mappings {{{
let g:vimtex_view_method = 'skim'
" }}}


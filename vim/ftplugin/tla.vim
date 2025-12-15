" Autocommands {{{
augroup tla
  " It is critical to specify buffer in the autocmd! too! See this link: https://vi.stackexchange.com/questions/8056/for-an-autocmd-in-a-ftplugin-should-i-use-pattern-matching-or-buffer
  autocmd! BufWritePost <buffer>
  autocmd BufWritePost <buffer> call tla#Parse()
augroup END
" }}}
" Commands {{{
" Initializes a module spec with the required header and footer
command! -nargs=1 TlaCreateModule call tla#CreateModule(<f-args>)
command! -nargs=0 TlaParse call tla#Parse()
command! -nargs=0 TlaCheck call tla#Check()
command! -nargs=0 TlaCreateConfig call tla#CreateConfig()
" }}}
" Settings {{{
" Display the rendered mathematical symbols
setlocal conceallevel=2
setlocal indentexpr=tla#GetIndent()
setlocal nosmartindent
" }}}
" Abbrevations {{{
iabbrev <buffer> and /\
iabbrev <buffer> or \/
iabbrev <buffer> in \in
iabbrev <buffer> all \A
iabbrev <buffer> exists \E
iabbrev <buffer> union \union
iabbrev <buffer> included \subseteq

iabbrev <buffer> andd and
iabbrev <buffer> orr or
iabbrev <buffer> inn in
iabbrev <buffer> alll all
iabbrev <buffer> existss exists
iabbrev <buffer> unionn union
iabbrev <buffer> includedd included
" }}}
" Mappings {{{
" automatically close {,[,( and <<
inoremap <buffer> [ []<esc>i
inoremap <buffer> ( ()<esc>i
inoremap <buffer> { {}<esc>i
inoremap <buffer> << <<>><esc>hi
" automatically close '"
inoremap <buffer> " ""<esc>i
" }}}

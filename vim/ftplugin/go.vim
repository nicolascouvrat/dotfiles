" Options {{{
setlocal textwidth=80
" replace tabs with spaces and set tab=2spaces
setlocal expandtab
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2

" avoid needing to manually write on go build
set autowrite
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
" Autocommands {{{
augroup go
  " It is critical to specify buffer in the autocmd! too! See this link: https://vi.stackexchange.com/questions/8056/for-an-autocmd-in-a-ftplugin-should-i-use-pattern-matching-or-buffer
  autocmd! BufWritePost <buffer>
  autocmd BufWritePost <buffer> call go#FormatFile()
augroup END
" }}}
" Abbreviations {{{
function! ExpandFunction(string)
  echom a:string
endfunction
iabbrev <buffer> rtn return
iabbrev <buffer> funcc ExpandFunction('test')<C-R>
" }}}
" Plugin related mappings {{{
nnoremap <buffer> <leader>b :GoBuild<CR>
nnoremap <buffer> <leader>r :GoRun<CR>
nnoremap <buffer> <leader>t :GoTest<CR>
nnoremap <buffer> <leader>c :GoCoverageToggle<CR>

let g:go_fmt_command = "gofmt"
" }}}


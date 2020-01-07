" Mappings {{{
" basic titles
" compile (with pandoc)
nnoremap <buffer> <leader>co :!pandoc -s -o %:r.pdf %<cr>
" compile and open
nnoremap <buffer> <leader>ex :!pandoc -s -o %:r.pdf % & evince %:r.pdf<cr>
" enable spellchecker
setlocal spell
" headers
nnoremap <buffer> <leader>H1 I#<space><esc>
nnoremap <buffer> <leader>H2 I##<space><esc>
" set to italic
nmap <silent> <leader>i :set opfunc=MdItalicOperator<cr>g@
vmap <silent> <leader>i :<c-u>call MdItalicOperator(visualmode(), 1)<cr>
" set to bold
nmap <silent> <leader>b :set opfunc=MdBoldOperator<cr>g@
vmap <silent> <leader>b :<c-u>call MdBoldOperator(visualmode(), 1)<cr>
" set to code
nmap <silent> <leader>c :set opfunc=MdCodeOperator<cr>g@
vmap <silent> <leader>c :<c-u>call MdCodeOperator(visualmode(), 1)<cr>
" fix orthograph
nnoremap <buffer> <leader>o ]sz=
" }}}
" Functions {{{
function! MdItalicOperator(type, ...)
    call MdEmphasisOperator('*', a:type, a:000)
endfunction

function! MdCodeOperator(type, ...)
    if a:type ==# 'char' || a:type ==# 'v'
        call MdEmphasisOperator('`', a:type, a:000)
    else
        " block mode
        execute "normal! `<O```\<esc>`>o```\<esc>"
    endif
endfunction

function! MdBoldOperator(type, ...)
    call MdEmphasisOperator('**', a:type, a:000)
endfunction

function! MdEmphasisOperator(token, type, ...)
    " Emphasis operator. Operates differently depeding on emphasis type
    " b = bold, i = italic
    " Have to compensate for the length of the token
    let compensation = repeat("l", len(a:token)) 
    if a:type !=# 'char' && a:type !=# 'v'
        return
    elseif a:type ==# 'char' 
        " prep selection in this case
        execute "normal `[v`]\<esc>"
    endif
    " operate on selection (not line nor block)
    execute "normal `<i" . a:token . "\<esc>`>" . l:compensation . "a" . a:token . "\<esc>"
endfunction

" Inserts a title with today's date formatted for journal
function! Today()
  let last = line('$')
  let today = strftime("%B %d, %Y (%A)")
  call append(last, "# " . today)
  " Insert two lines, and start writing!
  execute "normal! Go\<CR>"
  startinsert
endfunction
" }}}

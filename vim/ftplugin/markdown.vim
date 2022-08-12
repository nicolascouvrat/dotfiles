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

" helpers
nnoremap <buffer> <leader>todo :call Todo()<cr>
nnoremap <buffer> <leader>idid :call Idid()<cr>
nnoremap <buffer> <leader>done :call Done()<cr>


" }}}
" Folding {{{
setlocal foldenable
setlocal foldmethod=expr
setlocal foldexpr=FoldLevel(v:lnum)
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
  call append(last, ["", "# " . today, ""])
  " Insert two lines, and start writing!
  execute "normal! Go"
  startinsert
endfunction

" Inserts a title with today's date formatted for journal
function! Todo()
  let next = line('.')
  let now = strftime("%B %d, %Y (%T)")
  call append(next, "- TODO: " . now . ":  ")
  execute "normal! A"
  startinsert
endfunction

function! Done()
  let last = line('$')
  let now = strftime("%B %d, %Y (%T)")
  let pattern = '^- (.+): (.+): (.+)$'
  let cmd =  'substitute/\v' . pattern . '/- DONE: ' . now .': \3/'
  execute cmd
  execute "normal! ddGp"
endfunction

" Inserts a marker for a task
function! Idid()
  let last = line('$')
  call append(last, "- IDID:  ")
  execute "normal! GA"
  startinsert
endfunction

let s:inCodeBlock = 0

" Fold #, ## and codeblocks.
function! FoldLevel(lnum)
  if s:inCodeBlock == 1 
    " disable all folding, except if we are finishing a block
    if getline(a:lnum) ==# '```'
      let s:inCodeBlock = 0
      return "s1"
    endif

    return "="
  endif

  if getline(a:lnum) =~? '\v^# .*$'
    return ">1"
  endif

  if getline(a:lnum) =~? '\v^## .*$'
    return ">2"
  endif

  if getline(a:lnum) =~? '\v^### .*$'
    return ">3"
  endif

  if getline(a:lnum) =~? '\v^#### .*$'
    return ">4"
  endif

  if getline(a:lnum) =~? '\v^##### .*$'
    return ">5"
  endif

  " We enter a code block
  if getline(a:lnum) =~? '^```\a*$'
    let s:inCodeBlock = 1
    return "a1"
  endif

  return "="
endfunction
" }}}

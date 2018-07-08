nmap <silent> <leader>gg :set opfunc=GitGrep<cr>g@
vmap <silent> <leader>gg :<c-u>call GitGrep(visualmode(), 1)<cr>

function! GitGrep(type, ...)
    " get text
    if a:type ==# 'char'
        execute "normal! `[v`]y"
    elseif a:type ==# 'v'
        execute "normal! `<v`>y"
    else
        return
    endif
    " not forgetting the shell escape
    let original_grep = &grepprg
    " the -n is necessary for vim to correctly interpret matches
    let &grepprg = "git grep -n $*"
    execute "silent grep! '" . shellescape(@@) . "'"
    " restore display
    execute "normal! \<c-l>"
    " restore grep to its original value
    let &grepprg = original_grep
    " set a shortcut for the original file when navigating around the quickfix
    let g:GREP_ORIGINAL_FILE = @%
    " display quickfix list
    copen
endfunction

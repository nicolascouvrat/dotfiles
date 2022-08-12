" Movement operators
nmap <silent> <leader>gg :set opfunc=GitGrepOperator<cr>g@
vmap <silent> <leader>gg :<c-u>call GitGrepOperator(visualmode(), 1)<cr>

" Command
command! -nargs=+ GitGrep call GitGrepCommand(Sanitize('<args>'), 1)
command! -nargs=+ GitGrepNoTests call GitGrepCommand(Sanitize('<args>'), 0)
" Sets a binding to come back to the original file after moving around
" in the quickfix list. This will stay set to the same file until the
" next grep search. Default is NOOP.
nnoremap <silent> <leader>o :call GetBackToOriginalFile()<cr>

function! Sanitize(args)
    " Takes in the command arguments and returns a list
    " Also takes care of additional spaces (leading trailing are auto removed) spaces
    let args_string = substitute(a:args, '\v\ {2,}', ' ', 'g')
    return split(args_string, ' ')
endfunction

function! GitGrepCommand(args, include_java_test_files)
    " TODO for now this will bug if not simply inserting a keyword
    let grep_string = ""
    for arg in a:args
        let grep_string = grep_string . arg
    endfor
    call GitGrep(grep_string, a:include_java_test_files)
endfunction

function! GetBackToOriginalFile()
    if !exists("g:GREP_ORIGINAL_FILE")
        " Default to current file
        let g:GREP_ORIGINAL_FILE = @%
    endif
    echom g:GREP_ORIGINAL_FILE
    execute "edit " . g:GREP_ORIGINAL_FILE
endfunction

function! GitGrepOperator(type, ...)
    " get text
    if a:type ==# 'char'
        execute "normal! `[v`]y"
    elseif a:type ==# 'v'
        execute "normal! `<v`>y"
    else
        return
    endif
    call GitGrep(@@, 1)
endfunction

function! GitGrep(grep_string, include_java_test_files)
    if a:grep_string ==# ""
        return
    endif
    let original_grep = &grepprg
    " the -n is necessary for vim to correctly interpret matches
    let &grepprg = "git grep -n $*"
    let cmd = "silent grep! " . shellescape(a:grep_string)
    if !a:include_java_test_files
      let cmd = cmd . " --  ':!*Test.java'" 
    endif
    execute cmd
    " restore display
    execute "normal! \<c-l>"
    " restore grep to its original value
    let &grepprg = original_grep
    " set a shortcut for the original file when navigating around the quickfix
    let g:GREP_ORIGINAL_FILE = @%
    " display quickfix list
    copen
endfunction

function! SolveConflicts()
    " Go to top of file, search for first conflict
    normal! gg
    let n = search('<<<\+\ HEAD')
    while n > 0
        echom "Git conflict found at L" . n
        let choice = input("Keep HEAD? (y/n)")
        if choice != 'y' && choice != 'n'
            return
        endif
        if choice ==# 'y'
            normal! dd
            call search('===\+')
            " search for end of new branch section and delete selection
            execute "normal! V/>>>\\+\<cr>d"
        else
            " search for end of current branch section and delete
            execute "normal! V/===\\+\<cr>d"
            call search('>>>\+\ ')
            normal! dd
        endif
        " Search for next conflict
        let n = search('<<<\+\ HEAD')
    endwhile
endfunction

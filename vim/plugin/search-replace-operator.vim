nnoremap <leader>sr :set operatorfunc=SearchReplaceOperator<cr>g@
vnoremap <leader>sr :<c-u>call SearchReplaceOperator(visualmode())<cr>

" This operator performs a search and replace on the whole file, using the selection
" In the case of line or block selections, it defaults to a search and replace on the selection
" USING THE LAST YANKED PATTERN !
function! SearchReplaceOperator(type)
    " if visual selection or normal mode, get the text
    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
    " line or block, use last yanked pattern on current selection
        let r = input("Replace '" . @@ . "' (last yanked word) with? (on selection) ")
        execute "'<,'>substitute /" . @@ . "/" . l:r . "/g"
        return
    endif
    let r = input("Replace '" . @@ . "' with? ")
    execute "%substitute /" . @@ . "/" . l:r . "/g"

endfunction

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
        return
    endif
    let r = input("Replace '" . @@ . "' with? ") 
    execute "%substitute /" . @@ . "/" . l:r . "/g"

endfunction

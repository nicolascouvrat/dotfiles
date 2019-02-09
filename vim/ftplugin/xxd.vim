" test
" Set binary option
let &bin = 1
" Make the buffer readable
execute "%!xxd"
augroup Save
	autocmd!
	autocmd BufWritePre <buffer> %!xxd -r
augroup END
	

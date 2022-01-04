" Autocommands {{{
augroup typescript
  autocmd! BufWritePost <buffer>
  autocmd BufWritePost <buffer> call typescript#FormatFile()
augroup END
" }}}


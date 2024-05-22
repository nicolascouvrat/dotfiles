" Autocommands {{{
augroup bazel
  autocmd! BufWritePost <buffer>
  autocmd BufWritePost <buffer> call bzl#FormatFile()
augroup END
" }}}


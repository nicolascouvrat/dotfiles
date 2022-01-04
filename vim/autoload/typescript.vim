function! typescript#FormatFile()
  call utilities#RunOnCurrentFile("npx prettier --write")
endfunction


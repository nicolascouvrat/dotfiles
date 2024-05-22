function! python#FormatFile()
  call utilities#RunOnCurrentFile("black")
endfunction


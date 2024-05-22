function! rust#FormatFile()
  call utilities#RunOnCurrentFile("rustfmt")
endfunction


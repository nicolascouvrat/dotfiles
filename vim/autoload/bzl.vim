function! bzl#FormatFile() 
  call utilities#RunOnCurrentFile("buildifier -r")
endfunction


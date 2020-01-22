function! java#FormatFile()
  "TODO: make the location of the formatter modifiable
  let googleStyle = "~/google-java-format-1.7-all-deps.jar"
  call system("java -jar " . googleStyle . " --replace " . expand("%"))
  e
endfunction

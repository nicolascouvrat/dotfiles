let s:quickfixOpened = 0

function! java#FormatFile()
  "TODO: make the location of the formatter modifiable
  let googleStyle = "~/google-java-format-1.7-all-deps.jar"
  let ret = system("java -jar " . googleStyle . " --replace " . expand("%"))
  
  if v:shell_error
    let s:quickfixOpened = 1
    silent cexpr ret
    copen
    return
  endif

  if s:quickfixOpened
    silent cexpr []
    cclose
  endif

  e
endfunction

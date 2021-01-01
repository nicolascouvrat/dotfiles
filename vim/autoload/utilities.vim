function! utilities#Rename(new)
  let old_file = @%
  try
    silent execute "saveas " . a:new
  catch /.*/
    echom v:exception
    return
  endtry
  silent execute "!rm " . old_file
  " The previous buffer now point towards the one we removed
  bwipeout #
  redraw!
endfunction

let s:quickfixOpened = 0

function! utilities#RunOnCurrentFile(command)
  let ret = system(a:command . " " . expand("%"))

  if v:shell_error
    let s:quickfixOpened = 1
    silent cexpr ret
    copen
    return
  endif

  if s:quickfixOpened
    let s:quickfixOpened = 0
    silent cexpr []
    cclose
  endif

  e
endfunction


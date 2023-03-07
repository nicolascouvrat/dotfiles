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

function! utilities#CurrentFile()
  return expand("%")
endfunction

" Helper to open current file number in github
" Credits sami.tabet
function! utilities#OpenGithubLink()
    let remote = trim(system("git config --get remote.origin.url"))
    let remote_parts = split(remote, ":")
    if len(remote_parts) != 2
        echoerr "Couldn't parse github remote url: " . remote
        return
    endif

    let commit = trim(system("git rev-parse HEAD"))
    let repository = remote_parts[1]
    let absolute_path = expand("%")
    let filepath = trim(system("git ls-files --full-name " . absolute_path))
    let line = line(".")
    let url = "https://github.com/" . repository . "/blob/" . commit . "/" . filepath . "#L" . line
    " This does not work with tmux, nothing gets opened
    call system("open " . url)
endfunction

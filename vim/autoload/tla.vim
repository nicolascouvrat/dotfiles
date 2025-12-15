let s:TLA_CMD = "java -cp ~/tla2tools.jar"
let s:TLA_HEADER = "------------------------------ MODULE %s ------------------------------"
let s:TLA_FOOTER = "============================================================================="

function! tla#CreateModule(moduleName)
  let boilerPlate = [printf(s:TLA_HEADER,a:moduleName), s:TLA_FOOTER]
  call append(0, boilerPlate)
endfunction


function! tla#Check()
  let file = utilities#CurrentFile() 
  call s:tla2tool("tlc2.TLC", [file]) 
endfunction

function! tla#Parse()
  let file = utilities#CurrentFile() 
  call s:tla2tool("tla2sany.SANY", [file]) 
endfunction

function! tla#ToLatex()
  let file = utilities#CurrentFile() 
  call s:tla2tool("tla2tex.TLA", [file]) 
endfunction

" tla2tool calls the specified tool with the provided arguments
function! s:tla2tool(tool, args)
  let cmd = s:TLA_CMD . " " . a:tool . " " . join(a:args, " ")  
  echom cmd
  let ret = system(cmd)

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

let s:and_rx = '\/\\'
let s:or_rx = '\\\/'
let s:if_rx = 'IF'
let s:define_rx = '== *$'

let s:quickfixOpened = 0
function! tla#GetIndent()
  let prev_lnum = v:lnum - 1
  if prev_lnum == 0
    return 0
  endif
  let prev_line = getline(prev_lnum)

  " Align ands
  if prev_line =~ s:and_rx
    call cursor(prev_lnum, 1)
    if search(s:and_rx, 'W') != 0
      return virtcol('.') - 1
    else
      return shiftwidth()
    endif
  endif

  " Align ors
  if prev_line =~ s:or_rx
    call cursor(prev_lnum, 1)
    if search(s:or_rx, 'W') != 0
      return virtcol('.') - 1
    else
      return shiftwidth()
    endif
  endif

  " Align ors
  if prev_line =~ s:if_rx
    call cursor(prev_lnum, 1)
    if search(s:if_rx, 'W') != 0
      return virtcol('.') + 1
    else
      return shiftwidth()
    endif
  endif

  " Indent after ==
  if prev_line =~ s:define_rx
      return indent(prev_lnum) + shiftwidth()
  endif
  " TODO: can we make it so that instead of reseting to 0, we reset to the THEN ident?
  " For example
  " 0: IF a <= b
  " 1:   THEN /\ a' = 1
  " 2:
  " 3: <-- instead of resetting to 0 here, reset to the THEN indent
endfunction

function! tla#CreateConfig()
  let file = expand("%:r")
  execute "vnew " . file . ".cfg"
endfunction

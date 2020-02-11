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
    let s:quickfixOpened = 0
    silent cexpr []
    cclose
  endif

  e
endfunction

" These folders in succession indicate the root
let s:JAVA_ROOT = "src/main/java"

" PrependPackage adds the package name on top of the given file
"
" filename has to be a full path to a .java file
function! java#PrependPackage(filename)
  let rfPath = reverse(split(a:filename, "/"))
  let f = rfPath[0]
  let rPath = split(s:JAVA_ROOT, "/")
  let rRemaining = len(rPath) - 1
  let rpPath = []

  for folder in rfPath
    if rRemaining ==# -1
      break
    endif

    if folder ==# rPath[rRemaining]
      let rRemaining -= 1 
      continue
    endif

    call add(rpPath, folder)
  endfor

  if rRemaining !=# -1
    echo "ERROR: not in java root?!"
  endif

  " drop the file name
  let pPath = reverse(rpPath)[:-2]
  " . has to be ecaped
  let className = split(f, '\.')[0]
  " Do not worry about the formatting, google format should do it
  let boilerPlate = [printf("package %s;", join(pPath, ".")), printf("public class %s {", className), "}"]

  call append(0, boilerPlate)
endfunction

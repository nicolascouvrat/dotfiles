function! java#RenameFile(newName)
  echo s:javaClassName(utilities#CurrentFile())
endfunction

function! java#FormatFile()
  "TODO: make the location of the formatter modifiable
  " let formatter = "~/google-java-format-1.21.0-all-deps.jar"
  let formatter = "~/javaimports-1.5-SNAPSHOT-all-deps.jar --telemetry-enable"
  " let cmd = "~/javaimports-native-image-2 -Djava.home=$JAVA_HOME --replace --telemetry-enable"
  let cmd = "java -jar " . formatter . " --replace"
  call utilities#RunOnCurrentFile(cmd)
endfunction

" These folders in succession indicate the root
let s:JAVA_ROOT = "src/main/java"
let s:JAVA_TEST_ROOT = "src/test/java"

" hasInPath checks if filename contains fragment in its path, and returns a list of strings forming
" a reverse relative path from the fragment root
"
" for example, hasInPath('/home/user/folderA/folderB/folderC/file', 'folderA/folderB') should return
" ['file', 'folderC', 'folderB', 'folderA']
" FIXME: this returns [] if fragment is not found AND if fragment == filename
function! s:hasInPath(filename, fragment)
  let rfPath = reverse(split(a:filename, "/"))
  let rPath = split(a:fragment, "/")
  let rRemaining = len(rPath)
  let rpPath = []

  for folder in rfPath
    if rRemaining ==# 0
      break
    endif

    if folder ==# rPath[rRemaining - 1]
      let rRemaining -= 1 
      continue
    endif

    call add(rpPath, folder)
  endfor

  if rRemaining !=# 0
    return []
  endif

  return rpPath
endfunction

" javaClassName returns the class for a given java file
"
" for example, javaClassName('src/main/java/com/mycompany/myapp/MyClass.java') should return 'MyClass'
function! s:javaClassName(path)
  if a:path !~ "\\.java$"
    throw "Not a java file"
  endif

  let filename = split(a:path, "/")[-1]
  return split(filename, "\\.")[0]
endfunction

" javaPackageName returns the package for a given java file
"
" for example, javaPackageName('src/main/java/com/mycompany/myapp/MyClass.java') should return
" 'com.mycompany.myapp'
function! s:javaPackageName(path)
endfunction

" PrependPackage adds the package name on top of the given file
"
" filename has to be a full path to a .java file
" FIXME: should probably not let filename up to the caller to decide, as it might pass expand("%")
" when it needs expand("%:p")
function! java#PrependPackage(filename)
  let rpPath = s:hasInPath(a:filename, s:JAVA_ROOT)
  if len(rpPath) ==# 0
    let rpPath = s:hasInPath(a:filename, s:JAVA_TEST_ROOT)
  endif
  " drop the file name
  let pPath = reverse(rpPath)[:-2]
  " . has to be ecaped
  let className = split(rpPath[-1], '\.')[0]
  " Do not worry about the formatting, google format should do it
  let boilerPlate = [printf("package %s;", join(pPath, ".")), printf("public class %s {", className), "// by nikodoko.com", "}"]

  call append(0, boilerPlate)
endfunction

function! s:alternatePath(filename)
  let alternates = {'main': 'test', 'test': 'main'}
  let path = split(a:filename, '/')
  let alternatePath = []
  for frag in path[:-2]
    call add(alternatePath, get(alternates, frag, frag))
  endfor
  
  " . has to be ecaped
  let className = split(path[-1], '\.')[0]
  let alternateClassName = substitute(className, "Test", "", "") . ".java"
  if stridx(className, "Test") ==# -1
    let alternateClassName = className . "Test.java"
  endif

  call add(alternatePath, alternateClassName)

  " make the path absolute, as filename, which we used to create it, was absolute too
  return "/" . join(alternatePath, "/")
endfunction

function! java#Alternate(filename)
  let alternateFilename = s:alternatePath(a:filename)
  execute "edit " . alternateFilename
endfunction

function! java#CreateTestFile(filename)
  call java#Alternate(a:filename)
  call java#PrependPackage(expand("%"))
  execute "silent! !mkdir -p " . shellescape(expand("%:h"), 1)
  redraw!
  write
endfunction

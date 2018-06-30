" identify the function we're on
" try to find it in the file
" try to find the package from which it has been imported
" open it

" SUPPORTED PATTERNS
" 1. function defined in file DONE
" 2. function defined in class in file
" 3. function imported individually DONE
" 4. function in imported module
" 5. function in class imported individually
" 6. function in class of imported module

let PYTHON_FUNCTION_IDENTIFIER = "def "
let PYTHON_MODULE_IMPORT_PATTERN = '^import '
let PYTHON_FUNCTION_IMPORT_PATTERN = '^from .* import '
let IMPORT_PATTERNS = [PYTHON_MODULE_IMPORT_PATTERN, PYTHON_FUNCTION_IMPORT_PATTERN]

function! ParseFunctionPath()
    " select the full function path
    " TODO add security to ensure we're indeed on a function
    execute "normal! f(hvBy"
    let a = @@
    let l = split(a, '\.')
    return l
endfunction

function! FindFunctionDef(func_name)
    return search(g:PYTHON_FUNCTION_IDENTIFIER . a:func_name)
endfunction

function! TryToGetModulePath(param)
    " TODO support imports over several lines
    " Search for module import line
    for pattern in g:IMPORT_PATTERNS
        if search(pattern . a:param) > 0
            " At this point, should be at the beginning of line
            " Get the full package name
            execute "normal! wviWy"
            return @@
        endif
    endfor

    return ""
endfunction

function! ToFilePath(module_path)
    " convert python module path to file path
    return join(split(a:module_path, '\.'), '/') . ".py"
endfunction

function! DefinitionFinder()
    let details = ParseFunctionPath()
    if len(details) == 1
        " It can be a) defined in file or b) individually imported
        " First, try to find it in file
        let name = details[0]
        if FindFunctionDef(name) > 0
            return
        endif
        let module_path = TryToGetModulePath(name)
        if module_path != ""
            let file_path = ToFilePath(module_path)
            " TODO read it without showing it first in case it does not show
            " open file and try to find function in it
            execute "vsplit " . file_path
            if FindFunctionDef(name) > 0
                return
            endif
            echom "ERROR: function def not found!"
            return
        endif
    endif
endfunction

" Handle java 12 arrow style case statements
syn region  javaLabelRegion transparent matchgroup=javaLabel start="\<case\>" matchgroup=NONE end="\v(\-\>)|:" contains=javaNumber,javaCharacter,javaString
" As well as java 13 yields
syn keyword javaStatement yield
" And java 14 records
syn keyword javaClassDecl record


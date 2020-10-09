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

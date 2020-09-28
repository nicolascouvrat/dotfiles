function! utilities#Rename(new)
  let old_file = @%
  silent execute "saveas " . a:new
  silent execute "!rm " . old_file
  " The previous buffer now point towards the one we removed
  bwipeout #
  redraw!
endfunction

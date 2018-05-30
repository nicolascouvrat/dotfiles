" Colors {{{
colorscheme dracula
syntax enable " enable syntax processing
" create custom highlighting groups
augroup coloring
" for some reason ColorScheme does not trigger when you first open vim
" but will trigger on source vimrc
" (and this erases custom highlights due to color scheme)
" hence the double event
    autocmd!
    autocmd ColorScheme,VimEnter * hi User1 ctermbg=212 ctermfg=234
    autocmd ColorScheme,VimEnter * hi User2 ctermbg=141 ctermfg=234
    autocmd ColorScheme,VimEnter * hi User3 ctermbg=215 ctermfg=234
    autocmd ColorScheme,VimEnter * hi User4 ctermbg=84 ctermfg=234 
augroup END
" }}}
" Spaces & Tabs Options {{{
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set expandtab " replace tabs with spaces
set autoindent " auto indent
set textwidth=100 " max number of character on a line. NOTE: see `formatoptions`
set shiftwidth=4 " number of spaces for each indent step
set autoindent " enable auto indentation
" }}}
" UI Config Options{{{
set number " show line numbers
" set cursorline " highlight current line
set lazyredraw " avoid redraw in the middle of macros
set showmatch " highligh matching [{()}]
set matchtime=2 " number of ms the matching bracket should be highlighted
" }}}
" Searching Options {{{
set incsearch " search as characters are entered
set hlsearch " highlight matches
" }}}
" Folding Options {{{
set foldenable " show all folds
" }}}
" General Mappings {{{
let mapleader = " "
let maplocalleader = "-"
" replace the escape key with something more convenient
inoremap jk <esc>
" move line down
nnoremap <leader>- ddp
" move line up
nnoremap <leader>_ ddkP
" put word in caps in edit mode
inoremap <leader><c-u> <esc>viwUea
" quick access to vimrc
nnoremap <leader>ev :sp $MYVIMRC<cr>
" quick source from vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" surrounds in normal mode
nnoremap <leader>" bi"<esc>lea"<esc>
nnoremap <leader>' bi'<esc>lea'<esc>
" surronds in visual mode
vnoremap <leader>{ <esc>`<i{<esc>`>a}<esc>
vnoremap <leader>( <esc>`<i(<esc>`>a)<esc>
vnoremap <leader>[ <esc>`<i[<esc>`>a]<esc>
" move to end of line
nnoremap L $
vnoremap L $
" move to start of line
nnoremap H 0
vnoremap H 0
" move around splits
nnoremap <leader>h <c-w>h
nnoremap <leader>k <c-w>k
nnoremap <leader>j <c-w>j
nnoremap <leader>l <c-w>l
" duplicate line
nnoremap <leader>dl Vyp
" search and replace last yank in selection
nnoremap <leader>sr :%s/<c-r>0//g<left><left>
nnoremap <leader>src :%s/<c-r>0//gc<left><left><left>
" or in all file
vnoremap <leader>sr :s/<c-r>0//g<left><left>
vnoremap <leader>src :s/<c-r>0//gc<left><left><left>
" }}}
" Movement Mappings {{{
" In Next (
onoremap in( :<c-u>normal! f(vi(<cr>
" In Last (
onoremap il( :<c-u>normal! F)vi(<cr>
" In Next {
onoremap in{ :<c-u>normal! f{vi{<cr>
" In Last {
onoremap il{ :<c-u>normal! f}vi{<cr>
" In Next [
onoremap in[ :<c-u>normal! f[vi[<cr>
" In Last [
onoremap il[ :<c-u>normal! f]vi[<cr>
" In Next "
onoremap in" :<c-u>normal! f"vi"<cr>
" In Last "
onoremap il" :<c-u>normal! F"vi"<cr>
" In Next '
onoremap in' :<c-u>normal! f'vi'<cr>
" In Last '
onoremap il' :<c-u>normal! F'vi'<cr>

" function name
onoremap f :<c-u>normal! 0f(hviw<cr>
" variable name (assumes one space before the '=')
onoremap v :<c-u>normal! 0f=hhviw<cr>
" }}}
" General Autocommands {{{
" }}}
" Python Autocommands {{{
" Note above the below abbrev: change them to something more legit
" Once the left right escape key will have been reactivated
augroup py_abbrevs
    autocmd!
    autocmd FileType python iabbrev <buffer> iff if:<esc>i
    autocmd FileType python iabbrev <buffer> forr for:<esc>i
    autocmd FileType python iabbrev <buffer> eliff elif:<esc>i
    autocmd FileType python iabbrev <buffer> elsee else:<esc>o
    autocmd FileType python iabbrev <buffer> deff def:<esc>i
    autocmd FileType python iabbrev <buffer> rtn return
augroup END
augroup py_maps
    autocmd!
    " comment line
    autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
    " uncomment line
    autocmd FileType python nnoremap <buffer> <localleader>C 0vld
    " automatically close {[(
    autocmd FileType python inoremap <buffer> [ []<esc>i
    autocmd FileType python inoremap <buffer> ( ()<esc>i
    autocmd FileType python inoremap <buffer> { {}<esc>i
    " automatically close '"
    autocmd FileType python inoremap <buffer> " ""<esc>i
    autocmd FileType python inoremap <buffer> ' ''<esc>i
augroup END
augroup py_movements
    autocmd!
augroup END
" }}}
" Vimrc Autocommands {{{
augroup misc
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
" General Abbreviations {{{
iabbrev @@ nicolas.couvrat@datadoghq.com
" }}}
" Status Line {{{
set statusline=%1*\ " Space and start color
set statusline+=%m  " Modified flag
set statusline+=\ %* " Space and end color 
set statusline+=%2*\ " Space and start color 
set statusline+=*%f " Path to file 
set statusline+=%= " align right
set statusline+=\ %* " space and end color
set statusline+=%3*\ " space and start color 
set statusline+=Line:\ " description 
set statusline+=%-12(%l/%L%) " current line/total lines
set statusline+=\ %* " Space and end color
set statusline+=%4*\ " Space and start color 
set statusline+=%P " Percent of file 
set statusline+=\ %* " Space and end color

" }}}
" Misc {{{
" temporary mappings and abbreviations to force usage of new bindings :)
" remove arrow keys
inoremap OD <nop>
inoremap OC <nop>
inoremap OA <nop>
inoremap OB <nop>
" remove some non abbreviated stuff
augroup bad_habits
    autocmd!
    autocmd FileType python iabbrev <buffer> return NOOOOO
    autocmd FileType python iabbrev <buffer> def NOOOOO
augroup END
" }}}

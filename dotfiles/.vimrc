" execute pathogen#infect()
function FoldBrace()
	if getline(v:lnum+1)[0] == '{'
		return '>1'
	endif

	if getline(v:lnum)[0] == '}'
		return '<1'
	endif

	return foldlevel(v:lnum-1)
endfunction

" This must be first, because it changes other options as a side effect.
set nocompatible
set showmatch
set nonu
set nocp
set title

" From http://www.reddit.com/r/vim/comments/2as7uu/how_to_remove_all_vim_swap_files_from_a_project/ciyahw0N
set backup		" keep a backup file
set backupcopy=yes 
set backupdir=/home/chris/tmp/
set directory=/home/chris/tmp/

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

filetype indent on
filetype plugin indent on

set tags+=~/.vim/systags;../;../../;../../../;

" Check cscope for definition of a symbol before checking ctags: set to 1
" if you want the reverse search order.
set csto=1

if executable('cscope')
  " add any cscope database in current directory
  if filereadable("cscope.out")
    cs add cscope.out  
    " else add the database pointed to by environment variable 
  elseif filereadable("../cscope.out")
    cs add ../cscope.out  
  elseif filereadable("../../cscope.out")
    cs add ../../cscope.out  
  elseif filereadable("../../../cscope.out")
    cs add ../../../cscope.out  
  elseif filereadable("../../../../cscope.out")
    cs add ../../../../cscope.out  
  elseif filereadable("../../../../../cscope.out")
    cs add ../../../../../cscope.out  
  elseif filereadable("../../../../../../cscope.out")
    cs add ../../../../../../cscope.out  
  elseif filereadable("../../../../../../../cscope.out")
    cs add ../../../../../../../cscope.out  
  elseif filereadable("../../../../../../../../cscope.out")
    cs add ../../../../../../../../cscope.out
  elseif filereadable("../../../../../../../../../cscope.out")
    cs add ../../../../../../../../../cscope.out  
  elseif filereadable("../../../../../../../../../../cscope.out")
    cs add ../../../../../../../../../../cscope.out  
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif


  " Use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
  set cscopetag

  " Show msg when any other cscope db added
  set cscopeverbose  

endif

" Try to be aggressively 2 spaces.
" From
" http://stackoverflow.com/questions/3938596/vim-autoindent-not-working/4191625#4191625
set number
set tabstop=4
set shiftwidth=4
set expandtab
set foldexpr=FoldBrace()
set cmdheight=1

" No screen flash, no beep, no nothing.
set visualbell t_vb=

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
set history=250		
set ruler		    " show the cursor position all the time
set showcmd		  " display incomplete commands
set incsearch		" do incremental searching
set fdc=1
set foldlevel=10

" mouse level things ... 
" try to use the scroll wheel and mouse focus magically
" only when it makes sense.  This is a hard thing to get right.
"set ttymouse=xterm2
set mouse=a
"set scrolloff=2
"set scrolljump=1
set t_Co=256
set hlsearch
syntax on

" For remote editing (ssh://..) set a default view
let g:netrw_browse_split=3

""""""""""""" My cscope/vim key mappings
"
" The following maps all invoke one of the following cscope search types:
"
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cursor calls
"
" Below are three sets of the maps: one set that just jumps to your
" search result, one that splits the existing vim window horizontally and
" diplays your search result in the new window, and one that does the same
" thing, but does a vertical split instead (vim 6 only).
"
" I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
" unlikely that you need their default mappings (CTRL-\'s default use is
" as part of CTRL-\ CTRL-N typemap, which basically just does the same
" thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
" If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
" of these maps to use other keys.  One likely candidate is 'CTRL-_'
" (which also maps to CTRL-/, which is easier to type).  By default it is
" used to switch between Hebrew and English keyboard mode.
"
" All of the maps involving the <cfile> macro use '^<cfile>$': this is so
" that searches over '#include <time.h>" return only references to
" 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
" files that contain 'time.h' as part of their name).


" To do the first type of search, hit what is below, followed by one of the
" cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
" search will be displayed in the current window.  You can use CTRL-T to
" go back to where you were before the search.  
"

"		0 or s: Find this C symbol
"		1 or g: Find this definition
"		2 or d: Find functions called by this function
"		3 or c: Find functions calling this function
"		4 or t: Find this text string
"		6 or e: Find this egrep pattern
"		7 or f: Find this file
"		8 or i: Find files #including this file

" Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
" makes the vim window split horizontally, with search result displayed in
" the new window.
"
" (Note: earlier versions of vim may not have the :scs command, but it
" can be simulated roughly via:
"    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	

nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
nmap <F3> :scs find g <C-R>=expand("<cword>")<CR><CR>	
nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	


" Hitting CTRL-space *twice* before the search type does a vertical 
" split instead of a horizontal one (vim 6 and up only)
"
" (Note: you may wish to put a 'set splitright' in your .vimrc
" if you prefer the new window on the right instead of the left

nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

"inoremap <Tab> <C-R>=Mosh_Tab_Or_Complete()<CR>
map <C-F12> :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

" Pan through tabs with F11 and F12
nmap <F12> <ESC>:tabn<cr>
nmap <F11> <ESC>:tabp<cr>
imap <F12> <ESC>:tabn<cr>
imap <F11> <ESC>:tabp<cr>

" Short-wire writing and closing of buffers
nnoremap q :q<cr>
nnoremap w :w<cr>

" make comma and dot expand and collapse folds
nmap , zc
nmap . zO

" g:NERDTreeMapPreview
" Break out both for vimdiff
if v:progname =~? "vimdiff"
  " don't warn about existing files being open elsewhere
  " Found http://stackoverflow.com/questions/1098159/vim-stop-existing-swap-file-warnings
  set shortmess+=A
  nnoremap q :q<cr>:q<cr>

  " note the ordering, reverting the changes in a git diff
  " will override expansion
  map > :diffput<CR>
endif

" Have some jump keys for going around panes
nnoremap <C-Left> <C-W>h
nnoremap <C-Right> <C-W>l
nnoremap <C-Up> <C-W>k
nnoremap <C-Down> <C-W>j
nnoremap <M-Down> <C-W>+
nnoremap <M-Up> <C-W>-
nnoremap <M-Left> <C-W><
nnoremap <M-Right> <C-W>>

noremap <F4> :Ack '<cword>'<cr>
nmap <C-b> :tabnew <C-d>
imap <C-b> <ESC>:tabnew <C-d>

nmap <C-J> :cn <cr>
imap <C-J> <ESC>:cn <cr>
nmap <C-L> :syntax sync fromstart<cr>:redraw!<cr>

nmap <C-K> :cp <cr>
imap <C-K> <ESC>:cp <cr>

" Map some f keys for makefile style development
map <F6> :w<cr>:make <cr>
imap <F6> <ESC>:w<cr>make 

" Re-indent file with f4
" map <F4> mzgg=G`z<CR>

map <F2> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap <silent> <F8> :NERDTreeToggle<CR><C-w>h<C-w><C-w>h<C-w>h
nnoremap <silent> <F7> :TagbarToggle<CR><C-w>h<C-w><C-w>h<C-w>h

map <RightMouse> :set scrolloff=20<cr>
map <RightDrag> <LeftMouse>
map <RightRelease> :set scrolloff=1<cr>

" Make the freakin scroll wheel work
map <MouseDown> <C-Y>
map <S-MouseDown> <C-U>
map <MouseUp> <C-E>
map <S-MouseUp> <C-D>

map <Home> <C-W><C-K>
map <End> <C-W><C-J>
map <S-Home> <C-W><C-L>
map <S-End> <C-H><C-H>

" Auto comment for asterisks
set formatoptions+=r

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
au!

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

augroup END

colorscheme koehler

"au FileType ruby,eruby set omnifunc=rubycomplete#Complete
au FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

let g:closetag_html_style=1 
au Filetype html,xml,xsl source ~/.vim/autoload/closetag.vim 

" 
" What annoys me, is that if I :wq, vim remains active, it only closes the
" documents' split-screen. I end up with a fullscreen NERDTree. I would like
" NERDTree to close too, on closing the last tab or buffers. 
"
" https://github.com/scrooloose/nerdtree/issues/21
"
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" When editing a text file, if you want word wrapping, but only want line breaks inserted when you explicitly press the Enter key: (http://vim.wikia.com/wiki/Word_wrap_without_line_breaks)

set wrap
set linebreak
set nolist  " list disables linebreak

set exrc            " enable per-directory .vimrc files

set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc,*.pyo,*.so,*.sw*,__pycache__

" http://stackoverflow.com/questions/178257/how-to-avoid-syntax-highlighting-for-large-files-in-vim
" Adding the following line to _vimrc does the trick, with a bonus: it
" handles gzipped files, too (which is a common case with huge files):
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

set ai
set runtimepath^=~/.vim/bundle/ctrlp.vim
" let g:ackprg = 'ack --ignore-file="match:/vendors|bundle.js/" --nogroup --nocolor --column'

" see http://i.imgur.com/ze2uZQG.png
set breakindent

" Add a hyphen as a keyword symbol (see
" http://vi.stackexchange.com/questions/4009/include-symbols-in-cword)
set iskeyword+=-
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab

" Reset the cursor during git commits to not be the last place it was.
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
map <F1> <Esc>
imap <F1> <Esc>
Plugin 'chemzqm/vim-jsx-improve'
Plugin 'taglist'

if has("gui_running")
  colorscheme koehler  " or your preferred color scheme
endif

nnoremap <C-S-Up>    :resize +2<CR>
nnoremap <C-S-Down>  :resize -2<CR>
nnoremap <C-S-Left>  :vertical resize -2<CR>
nnoremap <C-S-Right> :vertical resize +2<CR>

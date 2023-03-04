" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .vimrc                                             :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: tnaton <marvin@42.fr>                      +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2022/07/25 19:13:36 by tnaton            #+#    #+#              "
"    Updated: 2023/02/28 17:42:35 by tnaton           ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

" TESTING MELVIN'S THINGS
"""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Theming
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Filetype specific plugins
Plug 'vim-syntastic/syntastic'

" Git utils
Plug 'tpope/vim-fugitive'

call plug#end()

filetype plugin on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=0

" toggle mouse
:set mouse=a

:set number
:highlight LineNr ctermfg=grey

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" A buffer becomes hidden when it is abandoned
set hid

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display whitespace characters
set list
set listchars=tab:>─,eol:¬,trail:\ ,nbsp:¤

" Coloring whitespace characters
hi NonText guifg=darkgrey ctermfg=darkgrey
" Coloring tab
hi SpecialKey ctermfg=238 guifg=#649A9A

" Some unworking tests
":hi Myendline guifg=darkgrey ctermfg=darkgrey
":match Myendline /¬/

" highlighting Tabs

set fillchars=vert:│

" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme elford
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
"let g:cpp_simple_highlight = 1

"""""""""""""""""""""""""""""""""""""""""""""""""
" 42 Norm
"""""""""""""""""""""""""""""""""""""""""""""""""

set colorcolumn=81
highlight ColorColumn ctermbg=0 guibg=lightgrey
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartindent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile
set hidden

set undofile
set undodir=~/.vimundo/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Be smart when using tabs ;)
set smarttab

" Reload a file when it is changed from outside
set autoread

" Write the file when we leave the buffer
set autowrite

" Make backspace behave as expected
set backspace=eol,indent,start

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
"map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
"map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
"map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
"map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

colorscheme codedark

autocmd BufEnter *.tpp :setlocal filetype=cpp

nnoremap j h
nnoremap k j
nnoremap l k
nnoremap ; l
let g:syntastic_cpp_check_header = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow
set termwinsize=10x0
nnoremap <C-t> :term<CR>
set mouse=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Dev time
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function s:protec(string)
	let str = a:string[:-5] . "_" . a:string[-3:]
	let tmp = getline(13)
	if (tmp != "#ifndef " . toupper(str))
		echo "#ifndef " . toupper(str)
		call append(12, "#ifndef " . toupper(str))
	endif
	let tmp = getline(14)
	if (tmp != "# define " . toupper(str))
		call append(13, "# define " . toupper(str))
	endif
	execute "normal! G"
	let tmp = getline('.')
	if (tmp != "#endif")
		execute "normal! o"
		call append('.', "#endif")
	endif
endfunction

function s:canon(name, ...)
	let class = a:name
	let ret = []
	call add(ret, "	public:")
	call add(ret, "		" . class . "(void);")
	call add(ret, "		" . class . "(const " . class . " &);")
	call add(ret, "		~" . class . "(void);")
	call add(ret, "		" . class . " & operator=(" . class . " &);")
	let vars = a:000[0]
	for var in vars
		let var[-1] = toupper(var[-1][1]) . var[-1][2:]
		let type = ""
		for seg in var[:-2]
			if type == ""
				let type = type . seg
			else
				let type = type . ' ' . seg
			endif
		endfor
		if index(var, "const") == -1
			call add(ret, "		" . "void" . " set" . var[-1] . "(" . type . ");")
		endif
		call add(ret, "		" . type . " get". var[-1] . "(void);")
	endfor
	execute "normal! Gk"
	call append('.', ret)
	return ret
endfunction

function s:putf(name, ...)
	let lst = a:000[0]
	let ret = []
	"if (len(lst[0]) == 1 || stridx(lst[0], ")") != -1)
	"	call add(ret, " ")
	"endif
	let name = tolower(a:name[0]) . a:name[1:]
	let ret += lst + ['{']
	let ret = join(ret)
	let i = 0
	while (ret[i] != '(')
		let i += 1
	endwhile
	let j = 0
	while (ret[j] != ')')
		let j += 1
	endwhile
	if (stridx(lst[0], "(") != -1)
		let ret = [a:name . "::" . ret]
	elseif (ret[i + 1:j- 1] == "void")
		let k = i
		while (ret[k] != ' ' && k)
			let k -= 1
		endwhile
		let varname = tolower(ret[k + 1:i - 1][3]) . ret[k + 1:i - 1][4:]
		let type = ret[k + 1:i - 1][0:2]
		let ret = [ret[:k] . a:name . "::" . ret[k+1:]]
		if (type == "get")
			let ret += ["	return (this->" . "_" . varname . ");"]
		endif
	else
		let k = i
		while (ret[k] != ' ' && k)
			let k -= 1
		endwhile
		let type = ret[k + 1:i - 1][0:2]
		if (type == "set")
			let varname = tolower(ret[k + 1:i - 1][3]) . ret[k + 1:i - 1][4:]
			let ret = [ret[:k] . a:name . "::" . ret[k + 1:i - 1] . ret[i:j - 1] . " " . varname . ret[j:]]
			let ret += ["	this->" . "_" . varname . " = " . varname . ";"]
		else
			let ret = [ret[:k] . a:name . "::" . ret[k + 1:i - 1] . ret[i:j - 1] . " " . name . ret[j:]]
		endif
	endif
	let ret += ["}"]
	return (ret)
endfunction

function s:createcpp(name, ...)
	let lst = a:000[0]
	let name = a:name . ".cpp"
	let ret = []
	if (filereadable(name))
		echo "Already an existing " . name
		return
	endif
	for func in lst[1:]
		call add(ret, s:putf(name[:-5], split(func[2:-2])))
	endfor
	execute 'tabedit' name
	for line in reverse(ret)
		call append('.', line)
		call append('.', "")
	endfor
	execute "Stdheader"
	if ("#include \"" . name[:-4] . "h" . name[-2:] . "\"" != getline('.'))
		execute "normal! " . "i#include \"" . name[:-4] . "h" . name[-2:] . "\""
	endif
	execute "x"
endfunction

function s:getlst(file)
	let lines = readfile(a:file)
	let lst = []
	let start = 0
	for line in lines
		if line == "};" || line == "	public:"
			break
		endif
		if start
			call add(lst, split(line[2:-2]))
		endif
		if line == "	private:" || line == "	protected:"
			let start = 1
		endif
	endfor
	return reverse(lst)
endfunction

function! Test()
	let str = expand("%:f")
	let lst = split(str, '\.')
	execute "Stdheader"
	if (lst[-1] == "hpp")
		call s:createcpp(lst[0], s:canon(lst[0], s:getlst(str)))
		call s:protec(str)
		execute "w"
		execute "tabedit" lst[0] . ".cpp"
	endif

endfunction

:command! Canon :call Test()

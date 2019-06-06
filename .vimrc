execute pathogen#infect()
colorscheme solarized
set background=dark

syntax enable

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on
filetype plugin indent on

" Set to auto read when a single file is changed from outside
set autoread

" Set 7 lines to the cursor
set so=7

" Turn on the WiLd menu
set wildmenu

" Show the current position
set ruler

" Height of the command bar
"set cmdheight=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

set linespace=0 " don't insert any extra pixel lines betweens rows
set nostartofline " leave my cursor where it was
set scrolloff=10 " Keep 10 lines (top/bottom) for scope
set shortmess=aOstT " shortens messages to avoid 'press a key' prompt
set showcmd " show the command being typed
set sidescrolloff=10 " Keep 5 lines at the size

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Line number
set number

" Enable mouse
set mouse=a

"set list " we do what to show tabs, to ensure we get them out of my files
"set listchars=trail:. " show tabs and trailing 

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

set clipboard+=unnamed " share windows clipboard
set autochdir " always switch to the current file directory

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

set noexpandtab                         " use tabs, not spaces
set tabstop=8                           " tabstops of 8
set shiftwidth=8                        " indents of 8
"set textwidth=78                        " screen in 80 columns wide, wrap at 78
set autoindent smartindent              " turn on auto/smart indenting
set smartindent              " turn on auto/smart indenting
set smarttab                            " make <tab> and <backspace> smarter
set backspace=eol,start,indent          " allow backspacing over indent, eol, & start
nmap <C-J> vip=                         " forces (re)indentation of a block of code

" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w[%04L][%{&ff}]\ \ \ CWD:\ %r%{getcwd()}%h\ \ \ [%p%%][%04l,%04v]
set statusline=\ %{HasPaste()}%F%m%r%h%w\ %y\ [%{&ff}]%=[%04L][%03p%%][%04l,%04v]

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

syn keyword cType uint ubyte ulong uint64_t uint32_t uint16_t uint8_t boolean_t int64_t int32_t int16_t int8_t u_int64_t u_int32_t u_int16_t u_int8_t
syn keyword cOperator likely unlikely

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
set cursorline
hi CursorLineNR cterm=bold
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup END

set tags=tags;/
set rtp+=~/.fzf

let g:ranger_executable = 'ranger'

:command WQ wq
:command Wq wq
:command W w
:command Q q

set wmh=0
nnoremap <silent> <M-Up> <c-w>k<C-W>_
nnoremap <silent> <M-Down> <c-w>j<C-W>_
nnoremap <silent> <M-Right> <c-w>l<C-W>_
nnoremap <silent> <M-Left> <c-w>h<C-W>_
nnoremap <silent> <M-PageUp> :tabprevious<CR>
nnoremap <silent> <M-PageDown> :tabnext<CR>
nnoremap <silent> <M-t> :tabnew<CR>:e.<CR>
nnoremap <silent> <M-k> :split<CR>:e.<CR>
nnoremap <silent> <M-j> :vsplit<CR>:e.<CR>
nnoremap <silent> <M-S-PageUp> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <M-S-PageDown> :execute 'silent! tabmove ' . tabpagenr()<CR>


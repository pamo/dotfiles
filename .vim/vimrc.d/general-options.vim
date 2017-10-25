set background=dark
colorscheme Tomorrow-Night-Eighties
set t_Co=256
if has('gui_running')
  set guifont=Input Mono:h12
endif

set autoindent
set autoread
set autowrite
set autowriteall
set backspace=indent,eol,start
set conceallevel=1

set undodir=~/.vim/undo/
set undofile
set directory=~/.vim/tmp
set noswapfile
set encoding=utf-8
set nobackup
set nowritebackup

set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set autoindent
set wrap

set number
set ruler                   " show the cursor position at all times
set showcmd                 " display incomplete commands
set nohlsearch              " don't highlight searched phrases
set ignorecase              " case-insensitive search
set smartcase
set incsearch               " but do highlight as you type search phrase

set autoread                " update files changed outside of vim
set clipboard=unnamed       " yank and paste with system clipboard
set pastetoggle=<F2>

set list                    " show trailing white space
set listchars=tab:▸\ ,trail:▫,eol:↩

set exrc
set gdefault
set history=100

set laststatus=2
set modelines=0

set showcmd
set showmatch
set showmode
set ttyfast
set visualbell
set noerrorbells

" Fold Defaults
set foldmethod=indent
set foldnestmax=10
set foldlevel=2

set wildignore+=build,bower_components,node_modules,target,release,*.beam,*.so,*.swp,*.zip,*.iml,.idea,*.pyc,*.min.js,tags,pkg,bin,*.a,*.test
set wildmenu
set wildmode=list:longest

syntax on

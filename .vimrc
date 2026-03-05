" vim-plug — single-file plugin manager (replaces pathogen + 40 git submodules)
" Auto-installs itself on first run, then run :PlugInstall
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Essentials (replaces: sensible, sleuth, repeat, surround, commentary, fugitive, gitgutter, editorconfig)
Plug 'tpope/vim-sensible'           " Sensible defaults
Plug 'tpope/vim-surround'           " cs'\" to change surrounding quotes
Plug 'tpope/vim-commentary'         " gcc to comment a line, gc to comment selection
Plug 'tpope/vim-fugitive'           " :Git blame, :Git diff, :Git log
Plug 'tpope/vim-repeat'             " Make . work with plugin mappings
Plug 'tpope/vim-sleuth'             " Auto-detect indent settings
Plug 'airblade/vim-gitgutter'       " Shows git diff in the gutter
Plug 'vim-airline/vim-airline'       " Status line
Plug 'editorconfig/editorconfig-vim' " Respect .editorconfig files

" Navigation (replaces: ctrlp, ag.vim, nerdtree, nerdtree-tabs)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder (uses ripgrep)
Plug 'junegunn/fzf.vim'             " :Files, :Rg, :Buffers, :History
Plug 'preservim/nerdtree'           " File tree sidebar
call plug#end()

" General
set clipboard=unnamed
set mouse=a
set termguicolors
set number relativenumber
set spelllang=en_us
autocmd BufRead,BufNewFile *.md set spell

" Navigation — move by visual line
nnoremap j gj
nnoremap k gk

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" fzf mappings (replaces ctrlp)
" ctrl-p: fuzzy find files    ctrl-b: fuzzy find buffers
" ctrl-f: ripgrep search      ctrl-h: recent files
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-f> :Rg<CR>
nnoremap <C-h> :History<CR>

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Disable arrow keys (training wheels)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Zap trailing whitespace
nnoremap <silent> <Leader>zz :%s/\s\+$//e<CR>

" Re-indent file
map <F7> mzgg=G`z

" Autosave on focus lost
autocmd FocusLost * :wa

" Return to last edit position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif

colorscheme fairyfloss

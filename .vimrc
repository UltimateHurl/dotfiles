set nocompatible
set t_Co=256
if has('win32')
else
  set term=xterm-256color
endif
filetype off                   " required!

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
if has('win32')
  let vundle_readme=expand('H:/vimfiles/bundle/vundle/README.md')
else
  let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
endif
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    if has('win32')
        silent !mkdir -p H:/vimfiles/bundle
        silent !git clone https://github.com/gmarik/vundle H:/vimfiles/bundle/vundle
    else
        silent !mkdir -p ~/.vim/bundle
        silent !git clone http://github.com/gmarik/vundle ~/.vim/bundle/vundle
    endif
    let iCanHazVundle=0
endif

if has('win32')
  set rtp+=H:/vimfiles/bundle/vundle/
  let path='H:/vimfiles/bundle'
else
  set rtp+=~/.vim/bundle/vundle/
  let path='~/.vim/bundle'
endif

call vundle#begin(path)
" call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'plasticboy/vim-markdown'
Plugin 'elzr/vim-json'
" ctrlp is file fuzzy search
Plugin 'kien/ctrlp.vim'
" Ack.vim uses ack to search within files
Plugin 'mileszs/ack.vim'
"Airline provides a stylish appearance for the styleline
Plugin 'bling/vim-airline'
" Syntastic provides syntax info
Plugin 'scrooloose/syntastic'
"Show git info in the gutter, sad that it and syntastic fight for space though
Plugin 'airblade/vim-gitgutter'
"Integrate with tmux
Plugin 'christoomey/vim-tmux-navigator'
" Make tmux look like vim-airline (read README for extra instructions)
Plugin 'edkolev/tmuxline.vim'
"Provides Sublime-Text like smart completion of braces, parens and such
Plugin 'Raimondi/delimitMate'
" Surround is useful for adding surrounding tags to elements (especially html)
Plugin 'tpope/vim-surround'
" Allows vim-surround to be used with . command
Plugin 'tpope/vim-repeat'
" Provides easy shortcuts for commenting out lines
Plugin 'scrooloose/nerdcommenter'
"Adds convenience stuff for writers
Plugin 'reedes/vim-pencil'
" Clojure
Plugin 'tpope/vim-classpath'
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
"Org mode
Plugin 'jceb/vim-orgmode'
"Date incrementing
Plugin 'tpope/vim-speeddating'
" Snippets engine
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
"Buffer Explorer
Plugin 'jlanzarotta/bufexplorer'
"Paredit
Plugin 'vim-scripts/paredit.vim'
Plugin 'ntpeters/vim-better-whitespace'
" Align CSV files at commas, align Markdown tables, and more
Plugin 'godlygeek/tabular'

call vundle#end() " required

filetype plugin indent on

"Appearance
"======
syntax enable                                   " Turn on syntax highlighting
set background=dark
set t_Co=256
colorscheme solarized
highlight clear SignColumn
set ruler                                       " Show the cursor position
set shortmess=atI                               " Don’t show the intro message when starting Vim
set title                                       " Show the filename in the window titlebar
set cursorline                                  " Highlight current line
set number                                      " always show line numbers
set noshowmode                                  " Let airline handle the mode display
if has('gui_macvim')
  set guifont=Inconsolata:h12
elseif has("gui_win32")
  set guifont=Inconsolata:h12:cANSI
endif


"Misc
"======
set encoding=utf-8
set termencoding=utf-8
set clipboard=unnamed                           " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set hidden                                      " Leave hidden buffers open
set history=1000                                " by default Vim saves your last 8 commands. We can handle more
set shiftround                                  " use multiple of shiftwidth when indenting with '<' and '>'
set noerrorbells                                " Disable error bells
nnoremap <up> <nop>                             " turn off arrow keys
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <c-j> <c-w>j                           "Split navigation
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

set autochdir
nnoremap ; :
let mapleader=","                              " change the mapleader from \ to ,

nmap <silent> <leader>ev :e $MYVIMRC<CR>       " Quickly edit/reload the vimrc file
nmap <silent> <leader>sv :so $MYVIMRC<CR>


"Indentation and display
"======
set autoindent                                 " always set autoindenting on
set smartindent                                " copy the previous indentation on autoindenting
set smarttab                                   " insert tabs on the start of a line according to
                                               " shiftwidth, not tabstop
set nowrap                                     " don't wrap lines
set tabstop=4                                  " a tab is four spaces
set softtabstop=4                              " a tab is four spaces
set shiftwidth=4                               " number of spaces to use for autoindenting
set expandtab
set backspace=indent,eol,start                 " allow backspacing over everything in insert mode
set showmatch                                  " set show matching parenthesis
set ignorecase                                 " ignore case when searching
set smartcase                                  " ignore case if search pattern is all lowercase, case-sensitive otherwise
set laststatus=2
set showcmd                                    " Show incomplete cmds down the bottom
set gcr=a:blinkon0                             " Disable cursor blink
set autoread                                   " Reload files changed outside vim
set splitright                                 " Opens vertical split right of current window
set splitbelow                                 " Opens horizontal split below current window

set scrolloff=10                               " Start scrolling when we're getting close to margins
set sidescrolloff=15
set sidescroll=1

"Mouse
"========
set ttyfast                                    " Send more characters for redraws
set lazyredraw
set mouse=a                                    " Enable mouse use in all modes
set ttymouse=xterm2

"Search
"========
set hlsearch                                   " highlight search terms
set incsearch                                  " show search matches as you type

"Backup/Swap
"========
set nobackup
set noswapfile
set nowritebackup

" Persistent Undo
" ===============
" Keep undo history across sessions, by storing in file
" Only works in MacVim (gui) mode
if has('gui_running')
  if has('win32')
    set undodir=H:/vimfiles/backups
  else
    set undodir=~/.vim/backups
  endif
  set undofile
endif

" Folds
"=====

set foldmethod=indent                          " Fold based on indent
set foldnestmax=3                              " Deepest fold is 3 levels
set nofoldenable                               " Don't fold by default

" Plugin Options
" ==============

" CTRL+P options
""""""""""""""""""""
let g:ctrlp_custom_ignore = {
    \ 'file': '\.swp$|\.tmp$|\.pdf$|\.zip$|\.exe$|\.pyc$',
    \ 'dir': '\.DS_Store$\|\.git$'
    \ }

" BufExplorer options
""""""""""""""""""""
nnoremap <space> :BufExplorerHorizontalSplit<CR>

"Markdown options
""""""""""""""""""""
let g:vim_markdown_folding_disabled=1

" vim-orgmode
""""""""""""""""""""
let g:org_todo_keywords = [
    \['TODO(t)', 'NEXT(n)', '|', 'DONE(d)'],
    \['WAITING(w@/!)', 'HOLD(h@/!)', '|', 'CANCELLED(c@/!)']]

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" fugitive git bindings
""""""""""""""""""""
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

"Syntastic
""""""""""""""""""""
nnoremap <leader>e :Error<CR>

" NERDCommenter
"""""""""""""""""""
let NERDSpaceDelims=1 " Add a space after comment delimeter

" Airline options
""""""""""""""""""""
let g:airline#extensions#tabline#enabled    = 1
let g:airline#extensions#branch#enabled     = 1
let g:airline#extensions#syntastic#enabled  = 1
let g:airline_powerline_fonts = 1
"let g:airline_theme             = 'powerlineish'

" airline symbols
""""""""""""""""""""
let g:airline_left_sep          = '>'
let g:airline_left_alt_sep      = ']'
let g:airline_right_sep         = '<'
let g:airline_right_alt_sep     = '['
let g:airline_symbols = {}
let g:airline_symbols.branch    = '|/'
let g:airline_symbols.readonly  = '[READ-ONLY]'
let g:airline_symbols.linenr    = ':'
let g:airline_symbols.space     = ' '

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

" Theme
Plugin 'altercation/vim-colors-solarized'

Plugin 'scrooloose/nerdtree'         " File tree
Plugin 'Xuyuanp/nerdtree-git-plugin' " Show git statuses beside files in above
Plugin 'sjl/gundo.vim'               " View undo history as tree

" Integrations
Plugin 'rizzatti/dash.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'edkolev/tmuxline.vim'           " Make tmux look like vim-airline
Plugin 'christoomey/vim-tmux-navigator' "Integrate with tmux
Plugin 'tpope/vim-fugitive'             " Git
Plugin 'airblade/vim-gitgutter'
Plugin 'Shougo/unite.vim'
Plugin 'bling/vim-airline'              " Airline status line
Plugin 'tpope/vim-fireplace'            " Clojure REPL
Plugin 'Valloric/YouCompleteMe'         " Autocomplete
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'           " Syntastic provides syntax info
Plugin 'SirVer/ultisnips'               " Snippets engine
Plugin 'honza/vim-snippets'             " Snippet collection

" Text manipulation
Plugin 'jiangmiao/auto-pairs'   " Automatically pair quotes, braces etc.
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'        
Plugin 'Lokaltog/vim-easymotion' " Awesome motion movement without numbers
Plugin 'tpope/vim-commentary'    " Comment/uncomment textobjs
Plugin 'tpope/vim-unimpaired'    " Collection of paired commands
Plugin 'tpope/vim-speeddating'   " Date incrementing
Plugin 'terryma/vim-multiple-cursors'     " Multiple cursors
Plugin 'vim-scripts/paredit.vim'          " Paredit
Plugin 'ntpeters/vim-better-whitespace'   " Strip whitespace etc
Plugin 'godlygeek/tabular'                " Align CSV files at commas etc

" Filetypes
Plugin 'tpope/vim-classpath'     " Clojure
Plugin 'guns/vim-clojure-static' " Clojure
Plugin 'lervag/vimtex'           " LaTeX
Plugin 'jceb/vim-orgmode'        " Org mode
Plugin 'elzr/vim-json'           " JSON
Plugin 'plasticboy/vim-markdown' " Markdown

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
" turn off arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
"Split navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <Leader>u :GundoToggle<CR>
" easily get rid of search highlights
noremap <esc> :noh<return><esc>
" quick taps for opening extra menus
map <F4> :NERDTreeToggle<CR>
imap <F4> <ESC>:NERDTreeToggle<CR>

command Wq wq
command WQ wq
command W w
command Q q

set autochdir
nnoremap ; :
let mapleader=","                              " change the mapleader from \ to ,

nmap <silent> <leader>ev :e $MYVIMRC<CR>" Quickly edit/reload the vimrc file
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

" Highlight > 80 chars
highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

"Mouse
"========
set ttyfast                                    " Send more characters for redraw
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
if exists("&undodir")
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

" Unite options
""""""""""""""""""""
let g:unite_source_history_yank_enable = 1
let g:unite_split_rule = "botright"
let g:unite_winheight = 10

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
nnoremap <leader>y :Unite history/yank<cr>
nnoremap <C-p> :Unite file_rec<cr>
nnoremap <space> :Unite -quick-match buffer<cr>
nnoremap <leader>/ :Unite grep:.<cr>


" CTRL+P options
""""""""""""""""""""
" let g:ctrlp_custom_ignore = {
    " \ 'file': '\.swp$|\.tmp$|\.pdf$|\.zip$|\.exe$|\.pyc$',
    " \ 'dir': '\.DS_Store$\|\.git$'
    " \ }

" BufExplorer options
""""""""""""""""""""
" nnoremap <space> :BufExplorerHorizontalSplit<CR>

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
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

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

" Syntastic
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
let g:airline_symbols.paste     = 'PASTE'


" vimtex
""""""""""""""""""""
let g:tex_flavor='xelatex'
let g:Tex_CompileRule_pdf='xelatex --interaction=nonstopmode $*'

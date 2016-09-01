set nocompatible
filetype off                   " required!

" Setting up vim-plug
if has('win32')
  let plug_file=expand('~/vimfiles/autoload/plug.vim')
else
  let plug_file=expand('~/.vim/autoload/plug.vim')
endif
if !filereadable(plug_file)
    echo "Installing vim-plug..."
    echo ""
    if has('win32')
        silent !mkdir -p C:/Users/ehurrell/vimfiles/autoload/
        silent !curl -fLo C:/Users/ehurrell/vimfiles/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !mkdir -p ~/.vim/autoload/
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
endif

if has('win32')
  let path='~/vimfiles/plugged'
else
  let path='~/.vim/plugged'
endif

call plug#begin(path)
" Appearance
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'              " Airline status line
Plug 'vim-airline/vim-airline-themes'

" Integrations
Plug 'mhinz/vim-sayonara'          " Sanely quit buffers/windows etc.
Plug 'jpalardy/vim-slime'
if has('mac') && isdirectory('/Applications/Dash.app')
  Plug 'rizzatti/dash.vim'                  " Integrate with Dash.app
endif
if executable('tmux')
  Plug 'justinmk/vim-gtfo'                  " Open a tmux pane with got!
  Plug 'tmux-plugins/vim-tmux-focus-events' " FocusGained etc. in tmux!
  Plug 'tmux-plugins/vim-tmux'
  Plug 'edkolev/tmuxline.vim'
  Plug 'christoomey/vim-tmux-navigator'
endif
Plug 'junegunn/goyo.vim' | Plug 'amix/vim-zenroom2'
" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv'

Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'sjl/gundo.vim'
Plug 'kien/ctrlp.vim'
Plug 'xolox/vim-easytags' | Plug 'majutsushi/tagbar'   " Tags
Plug 'xolox/vim-misc'
Plug 'goldfeld/ctrlr.vim'

" Plug 'Shougo/vimproc.vim'
" Plug 'ervandew/supertab'

" Typing/Autocomplete
Plug 'scrooloose/syntastic'           " Syntastic provides syntax info
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'           " Automatically pair quotes, braces etc.
Plug 'vim-scripts/paredit.vim'        " Paredit
Plug 'ajh17/VimCompletesMe'           " Super lightweight smart-tab for ins-completion
Plug 'unblevable/quick-scope'         " highlight in-line f/F/t/T motions
Plug 'skwp/YankRing.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'Lokaltog/vim-easymotion'        " Awesome motion movement without numbers
Plug 'tpope/vim-commentary'           " Comment/uncomment textobjs
Plug 'tpope/vim-unimpaired'           " Collection of paired commands
Plug 'tpope/vim-speeddating'          " Date incrementing
Plug 'AndrewRadev/splitjoin.vim'      " gS/gJ to switch single/multiline block
Plug 'terryma/vim-multiple-cursors'   " Multiple cursors
Plug 'ntpeters/vim-better-whitespace' " Strip whitespace etc
Plug 'godlygeek/tabular'              " Align CSV files at commas etc
Plug 'mattn/emmet-vim'

" Text objects
Plug 'austintaylor/vim-indentobject'
Plug 'coderifous/textobj-word-column.vim'
Plug 'kana/vim-textobj-datetime'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-user'
Plug 'lucapette/vim-textobj-underscore'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'thinca/vim-textobj-function-javascript'
Plug 'vim-scripts/argtextobj.vim'

" Filetypes
Plug 'tpope/vim-classpath' | Plug 'guns/vim-clojure-static' " Clojure
Plug 'tpope/vim-fireplace'                                  " Clojure REPL
Plug 'lervag/vimtex', { 'for': 'latex' }                    " LaTeX
Plug 'jceb/vim-orgmode', { 'for': 'org' }                   " Org mode
Plug 'plasticboy/vim-markdown'                              " Markdown

call plug#end()
filetype plugin indent on

" Filetype settings
augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  autocmd FileType html setlocal ts=2 sw=2 expandtab
  autocmd FileType ruby setlocal ts=2 sw=2 expandtab
  autocmd FileType vim setlocal ts=2 sw=2 expandtab keywordprg=:help
  autocmd FileType haskell setlocal ts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sw=4 expandtab
  autocmd FileType rust setlocal ts=4 sw=4 expandtab
  autocmd FileType javascript setlocal ts=2 sw=2 expandtab
  autocmd FileType coffee setlocal ts=2 sw=2 expandtab

  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufNewFile,BufRead *.css set filetype=scss
  " Hive
  autocmd BufNewFile,BufRead *.q set filetype=sql
  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  if has('win32')
    let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'
  else
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  endif

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

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
set numberwidth=5
" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
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
set noerrorbells                                " Disable error bells
"Indentation and display
"======
set autoindent                                 " always set autoindenting on
set smartindent                                " copy the previous indentation on autoindenting
set nowrap                                     " don't wrap lines
" Tabs
set smarttab                                   " insert tabs on the start of a line according to shiftwidth, not tabstop
set tabstop=4                                  " a tab is four spaces
set softtabstop=4                              " a tab is four spaces
set shiftwidth=4                               " number of spaces to use for autoindenting
set expandtab
set backspace=indent,eol,start                 " allow backspacing over everything in insert mode
set shiftround                      " 'h' and 'l' will wrap around lines
set showmatch                                  " set show matching parenthesis
set ignorecase                                 " ignore case when searching
set smartcase                                  " ignore case if search pattern is all lowercase, case-sensitive otherwise
" Command behaviour
set showcmd                                    " Show incomplete cmds down the bottom
set laststatus=2
set noshowmode                                  " Let airline handle the mode display
set gcr=a:blinkon0                             " Disable cursor blink
set autoread                                   " Reload files changed outside vim
set autochdir
set splitright                                 " Opens vertical split right of current window
set splitbelow                                 " Opens horizontal split below current window
set diffopt+=vertical                          " Always use vertical diffs
set scrolloff=10                               " Start scrolling when we're getting close to margins
set sidescrolloff=15
set sidescroll=1
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*DS_Store*
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
" Folds
set foldmethod=indent                          " Fold based on indent
set foldnestmax=3                              " Deepest fold is 3 levels
set nofoldenable                               " Don't fold by default
"Mouse
set ttyfast                                    " Send more characters for redraw
set lazyredraw
set mouse=a                                    " Enable mouse use in all modes
set ttymouse=xterm2
"Search
set hlsearch                                   " highlight search terms
set incsearch                                  " show search matches as you type
"Backup/Swap
set nobackup
set noswapfile
set nowritebackup

" Persistent Undo
if has("persistent_undo")
  let undoDir = expand('$HOME/.undodir')
  call system('mkdir -p ' . undoDir)
  let &undodir = undoDir
  set undofile
endif

" Keymaps
nnoremap ; :
let mapleader=","                              " change the mapleader from \ to ,
" Disable arrows
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
" Buffer navigation
nnoremap <leader>h :bp<CR>
nnoremap <leader>l :bn<CR>
" Split navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Toggle relative numbers
map <leader>r :setlocal relativenumber!<cr>
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
" Remap VIM 0 to first non-blank character
map 0 ^
" Close the current buffer
nnoremap <Leader>x :Sayonara<CR>y<CR>
nnoremap <Leader>q :w<CR>:Sayonara<CR>
nnoremap <Leader>s :w!<CR>
nnoremap <Leader>Q :q!<CR>
" Switch between the last two files
nnoremap <leader>l <c-^>
nnoremap <leader>u :GundoToggle<CR>
" easily get rid of search highlights
noremap <leader>/ :noh<CR>
nmap <silent> <leader>E :e $MYVIMRC<CR>" Quickly edit/reload the vimrc file
nmap <silent> <leader>S :so $MYVIMRC<CR>
" Quick Esc
inoremap ;; <Esc>:noh<CR>

" Plugin Options
" ==============
" Dash
" Search current word in Dash.app
if has('mac') && isdirectory('/Applications/Dash.app')
  nmap <silent> <Leader>d <Plug>DashSearch
endif
" Yank Ring
"==========
let g:yankring_history_file = '.yankring-history'
nnoremap <leader>yr :YRShow<CR>

" Vim-Slime
"""""""""""
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" NERDTree
"""""""""""
nnoremap <leader>t :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1

" CTRL+P options
""""""""""""""""""""
" let g:ctrlp_custom_ignore = {
"     \ 'file': '\.swp$|\.tmp$|\.pdf$|\.zip$|\.exe$|\.pyc$',
"     \ 'dir': '\.DS_Store$\|\.git$'
"     \ }
nnoremap <space> :CtrlPBuffer<CR>
nnoremap <leader>. :CtrlPTag<CR>

" Tagbar options
"""""""""""""""""
nnoremap <silent> <Leader>b :TagbarToggle<CR>

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
" let g:UltiSnipsExpandTrigger="<c-j>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" fugitive git bindings
""""""""""""""""""""
" vim-fugitive

nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gl :Glog<CR>:bot copen<CR>
nnoremap <leader>gv :Gitv<CR>

" Syntastic
""""""""""""""""""""
let g:syntastic_python_checkers = ['flake8', 'pylint']
nnoremap <Leader>e :SyntasticCheck<CR>:Errors<CR>

" Quick-scope
"""""""""""""
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" vim-gtfo
"""""""""""
let g:gtfo#terminals = { 'mac' : 'iterm' }

" NERDCommenter
"""""""""""""""""""
let NERDSpaceDelims=1 " Add a space after comment delimeter

" gitgutter
"""""""""""
" Gutter colours
" highlight CursorLineNR ctermfg=red
" highlight SignColumn ctermbg=black
" highlight lineNr ctermbg=black
" highlight GitGutterAdd ctermbg=black
" highlight GitGutterChange ctermbg=black
" highlight GitGutterDelete ctermbg=black
" highlight GitGutterChangeDelete ctermbg=black

" augroup GutterColourSet
"   autocmd!
"   autocmd ColorScheme * hi CursorLineNR ctermfg=black
"   autocmd ColorScheme * hi SignColumn ctermbg=black
"   autocmd ColorScheme * hi lineNr ctermbg=black
"   autocmd ColorScheme * hi GitGutterAdd ctermbg=black
"   autocmd ColorScheme * hi GitGutterChange ctermbg=black
"   autocmd ColorScheme * hi GitGutterDelete ctermbg=black
"   autocmd ColorScheme * hi GitGutterChangeDelete ctermbg=black
" augroup END
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

" Otherwise vim will get nasty escape codes
if has('mac') && ($TERM == 'xterm-256color' || $TERM == 'screen-256color')
  map <Esc>OP <F1>
  map <Esc>OQ <F2>
  map <Esc>OR <F3>
  map <Esc>OS <F4>
  map <Esc>[16~ <F5>
  map <Esc>[17~ <F6>
  map <Esc>[18~ <F7>
  map <Esc>[19~ <F8>
  map <Esc>[20~ <F9>
  map <Esc>[21~ <F10>
  map <Esc>[23~ <F11>
  map <Esc>[24~ <F12>
endif

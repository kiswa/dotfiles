" This must be first, because it changes other options as a side effect.
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Do not keep a backup file, use versions instead
set nobackup
" Kind of the same as above, no swap file for backups
set noswapfile
" Keep 250 lines of command line history
set history=250
" Show the cursor position all the time
set ruler
" Display incomplete commands
set showcmd
" Do incremental searching
set incsearch
" Hide buffers instead of closing them
set hidden
" Show line numbers
set number
" Use smart indenting
set smartindent
" Tabs are 4 spaces
set tabstop=4
" Ditto
set softtabstop=4
" Indenting matches tabs
set shiftwidth=4
" Expand tabs into spaces
set expandtab
" Two lines for status (so airline plugin is useful)
set laststatus=2
" Use indent code folding
set foldmethod=indent
" Don't indent files on open
set foldlevelstart=20
" Change default split position
set splitbelow
" Change default split position
set splitright
" Use UTF-8
set encoding=utf-8
" Ignore case when searching
set ignorecase
" Unless the search has capitals in it
set smartcase
" Default background color
set background=dark
" Don't let files change vim
set modelines=0
" Show matching parenthesis
set showmatch
" Numeric commands increment hex and alpha (not octal)
set nrformats=hex,alpha
" Display autocomplete options
set wildmenu
" Set the font
set guifont=FuraMonoForPowerline\ Nerd\ Font\ 11
" Don't wrap long lines
set nowrap

" Syntax highlighting on
syntax on

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.
if has('mouse')
    set mouse=a
endif

" Install vim-plug if we don't already have it
if empty(glob("~/.vim/autoload/plug.vim"))
    " Download the actual plugin manager
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
" Markdown syntax highlighting
Plug 'Markdown', { 'for': 'markdown' }
" Status and tabline
Plug 'vim-airline/vim-airline'
" Themes for vim-airline
Plug 'vim-airline/vim-airline-themes'
" Auto-completion with cache
Plug 'Shougo/neocomplete.vim'
" Base16 color schemes
Plug 'chriskempson/base16-vim'
" Make GUI color schemes work in terminal Vim
Plug 'CSApprox'
" Emmet implementation for vim
Plug 'mattn/emmet-vim'
" Language-aware commenting of text
Plug 'tomtom/tcomment_vim'
" Git wrapper
Plug 'tpope/vim-fugitive'
" Git status indicator
Plug 'mhinz/vim-signify'
" Handy bracket mappings
Plug 'tpope/vim-unimpaired'
" Tree explorer
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Multiple cursors
Plug 'terryma/vim-multiple-cursors'
" JSHint linter - Requires Node and JSHint: npm install -g jshint
Plug 'Shutnik/jshint2.vim'
" Work with surrounding tags
Plug 'tpope/vim-surround'
" Line numbers toggling by mode
Plug 'myusuf3/numbers.vim'
" HTML5 and Inline SVG support
Plug 'othree/html5.vim'
" Typescript syntax
Plug 'leafgarland/typescript-vim'
" Colorize inline colors
Plug 'gorodinskiy/vim-coloresque'
" Icon display in various plugins
Plug 'ryanoasis/vim-devicons'
" Show git status icons in NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'
" Highlight files by type in NERDTree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Automatically pair braces
Plug 'jiangmiao/auto-pairs'

" Enable airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline_theme='tomorrow'

" neocomplete settings
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Show hidden files in NERDTree
let NERDTreeShowHidden = 1
" Make NERDTree wider
let g:NERDTreeWinSize = 36
" Map Alt+a to toggle NERDTree
map <Esc>a :NERDTreeToggle<CR>

call plug#end()

" This must come after vundle#end.
colorscheme base16-eighties

" Map Ctrl+z to close a buffer without closing the split window
nnoremap <C-z> :bp\|bd #<CR>

" Use comma as leader key
let mapleader=","

" Only do this when compiled with support for autocommands.
if has("autocmd")
    filetype plugin indent on
    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " When editing a file, always jump to the last known good cursor position.
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif

        " Allow closing vim when only window open is NERDTree.
        autocmd BufEnter *
                    \ if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") |
                    \   q |
                    \ endif

        " Strip trailing whitespace on save and maintain cursor position.
        fun! StripTrailingWhitespace()
            let l = line(".")
            let c = col(".")
            %s/\s\+$//e
            call cursor(l, c)
        endfun
        autocmd BufWritePre * :call StripTrailingWhitespace()

        " Autocmd settings for neocomplete
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    augroup END
else
    " Set autoindenting on
    set autoindent
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

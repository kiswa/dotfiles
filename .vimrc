" This must be first, because it changes other options as a side effect.
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup            " Do not keep a backup file, use versions instead
set noswapfile          " Kind of the same as above, no swap file for backups
set history=250         " Keep 250 lines of command line history
set ruler               " Show the cursor position all the time
set showcmd             " Display incomplete commands
set incsearch           " Do incremental searching
set hidden              " Hide buffers instead of closing them
set number              " Show line numbers
set smartindent         " Use smart indenting
set tabstop=4           " Tabs are 4 spaces
set softtabstop=4       " Ditto
set shiftwidth=4        " Indenting matches tabs
set expandtab           " Expand tabs into spaces
set laststatus=2        " Two lines for status (so airline plugin is useful)
set foldenable          " Enable code folding
set splitbelow          " Change default split position
set splitright          " Change default split position
set encoding=utf-8      " Use UTF-8
set ignorecase          " Ignore case when searching
set smartcase           " Unless the search has capitals in it
set background=dark     " Default background color
set modelines=0         " Don't let files change vim
set showmatch           " Show matching parenthesis
set t_Co=256            " Use 256 colors
set nrformats=hex,alpha " Numeric commands increment hex and alpha (not octal)
set wildmenu            " Display autocomplete options
syntax on               " Syntax highlighting on

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.
if has('mouse')
  set mouse=a
endif

" Prep for Vundle
filetype off
" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" The Vim Bundle Manager manages itself
Plugin 'gmarik/Vundle.vim'
" Fuzzy finder
Plugin 'kien/ctrlp.vim'
" Markdown syntax highlighting
Plugin 'Markdown'
" Status and tabline
Plugin 'bling/vim-airline'
" Auto-complete popups
Plugin 'AutoComplPop'
" Base16 color schemes
Plugin 'chriskempson/base16-vim'
" Make GUI color schemes work in terminal Vim
Plugin 'CSApprox'
" Emmet implementation for vim
Plugin 'mattn/emmet-vim'
" Language-aware commenting of text
Plugin 'tomtom/tcomment_vim'
" Git wrapper
Plugin 'tpope/vim-fugitive'
" Git status indicator
Plugin 'mhinz/vim-signify'
" Handy bracket mappings
Plugin 'tpope/vim-unimpaired'
" Tree explorer
Plugin 'scrooloose/nerdtree'

" Enable airline
let g:airline#extensions#tabline#enabled = 1

" Show hidden files in NERDTree
let NERDTreeShowHidden = 1
" Map Ctrl+n to toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

call vundle#end()

" This must come after vundle#end.
colorscheme base16-eighties

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

" Settings {{{
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
" Tabs are 2 spaces
set tabstop=2
" Ditto
set softtabstop=2
" Indenting matches tabs
set shiftwidth=2
" Expand tabs into spaces
set expandtab
" Two lines for status (so airline plugin is useful)
set laststatus=2
" Enable folding
set foldenable
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
" Ignore certain files/directores
set wildignore+=*/node_modules/*,*/.git/*,*/tmp/*,*.swp
" Unless the search has capitals in it
set smartcase
" Default background color
set background=dark
" Let files change vim
set modelines=1
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
" Mark line length
set colorcolumn=80
" Don't include options in a saved session
set sessionoptions-=options

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
" }}}
" Plugins {{{
" Install vim-plug if we don't already have it
if empty(glob("~/.vim/autoload/plug.vim"))
  " Download the actual plugin manager
  execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
" Markdown syntax highlighting
Plug 'vim-scripts/Markdown', { 'for': 'markdown' }
" Status and tabline
Plug 'vim-airline/vim-airline'
" Themes for vim-airline
Plug 'vim-airline/vim-airline-themes'
" Auto-completion with cache
Plug 'Shougo/neocomplete.vim'
" Base16 color schemes
Plug 'chriskempson/base16-vim'
" Make GUI color schemes work in terminal Vim
Plug 'vim-scripts/CSApprox'
" Emmet implementation for vim
Plug 'mattn/emmet-vim'
" Language-aware commenting of text
Plug 'tomtom/tcomment_vim'
" Git status indicator
Plug 'mhinz/vim-signify'
" Handy bracket mappings
Plug 'tpope/vim-unimpaired'
" Tree explorer
Plug 'scrooloose/nerdtree'
" Work with surrounding tags
Plug 'tpope/vim-surround'
" Line numbers toggling by mode
Plug 'myusuf3/numbers.vim'
" HTML5 and Inline SVG support
Plug 'othree/html5.vim'
" Typescript syntax
Plug 'leafgarland/typescript-vim'
" Icon display in various plugins
Plug 'ryanoasis/vim-devicons'
" Show git status icons in NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'
" Highlight files by type in NERDTree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Automatically pair braces
Plug 'jiangmiao/auto-pairs'
" Handle Vue files
Plug 'posva/vim-vue'
" Navigate between Vim and tmux splits seamlessly
Plug 'christoomey/vim-tmux-navigator'
" }}}
" Plugin Settings {{{
" Enable airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline_theme='tomorrow'

" Ctrl+P settings
let g:ctrlp_match_window = 'bottom,order:btt'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 1

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

" neocomplete settings
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Show hidden files in NERDTree
let NERDTreeShowHidden = 1
" Make NERDTree wider
let g:NERDTreeWinSize = 36
" Hide NERDTree help message
let NERDTreeMinimalUI = 1
" Delete buffer when deleting in NERDTree
let NERDTreeAutoDeleteBuffer = 1
" Close NERDTree when opening file
let NERDTreeQuitOnOpen = 1

" Map Alt+a to toggle NERDTree
map <Esc>a :NERDTreeToggle<CR>
" Map Alt+s to open NERDTree with current file located
map <Esc>s :NERDTreeFind<CR>

call plug#end()

" This must come after plug#end
colorscheme base16-eighties
" }}}
" Mappings {{{
" Map Ctrl+z to close a buffer without closing the split window
nnoremap <C-z> :bp\|bd #<CR>

" Use comma as leader key
let mapleader=","

" Use ,ss to be prompted to save a session and .sr to restore
let g:sessions_dir = '~/.vim/sessions/'

exec 'nnoremap <Leader>ss :mks! ' . g:sessions_dir . '*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:sessions_dir. '*.vim<C-D><BS><BS><BS><BS><BS>'
"}}}
"Autocmd {{{
" Only do this when compiled with support for autocommands.
if has("autocmd")
  filetype plugin indent on
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " For Markdown files, wrap lines
    autocmd FileType markdown setlocal wrap

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

    " Auto-reload changed buffers.
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
    autocmd FileChangedShellPost *
          \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

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
    autocmd FileType typescript setlocal omnifunc=typescriptcomplete#Complete
    autocmd FileType typescript setlocal isk-=.
  augroup END
else
  " Set autoindenting on
  set autoindent
endif
" }}}
" Custom Commands {{{
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
" }}}
" vim:foldmethod=marker:foldlevel=0

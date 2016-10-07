set nocompatible   " Disable vi-compatibility
set t_Co=256
set background=dark
set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar
set linespace=15
set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set smarttab
set tags=tags
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set relativenumber
set number                      " always show line numbers
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
set timeout timeoutlen=200 ttimeoutlen=100
set visualbell           " don't beep
set noerrorbells         " don't beep
set autowrite  "Save on buffer switch
set mouse=a
set incsearch "incremental dynamic search..
set hlsearch  "highlight search results
set smartindent
syntax on
filetype indent on
filetype plugin on

"using delete/backspace key to remove the hlsearch 
nmap <silent> <BS> :nohlsearch<CR>

"Yeah changing the map leader key to comma. It's easier that way.
let mapleader = ","
let g:mapleader = ","

" Map J and K keys to move through tabs...
"
nmap K gt
nmap J gT
"  
" " Fast saves
nmap <leader>w :w!<cr>
"  
" Fast quit, Boy i'm really lazy
nmap <leader>q :q!<cr>

" " Down is really the next line
nnoremap j gj
nnoremap k gk
"  
""Easy escaping to normal model
imap jj <esc>

" Mapping redo.. this could be a bad practise but then
nmap rr :redo<cr>
"  
" "Auto change directory to match current file ,cd
" nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
"  
" "easier window navigation
" Open splits
nmap vs :vsplit<cr>
nmap sp :split<cr>
"  

"Moving through buffers
nmap <C-h> :bprev<cr>
nmap <C-l> :bnext<cr>

"wrapping inserts
set wrap
set linebreak
set showbreak=>>\ 

"Scrolling effects
set scrolloff=10

""" Minimal config for SSH use mostly
set noswapfile
set nu
set mouse=a
sy on
colorscheme zellner
set numberwidth=5
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight LineNr ctermfg=black ctermbg=gray
setlocal colorcolumn=80
setlocal path=.,**

set clipboard=unnamed

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

set softtabstop=4
set expandtab
set shiftwidth=4
set tabstop=4
set encoding=utf8

set noerrorbells
set novisualbell

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
" For regular expressions turn magic on
set magic

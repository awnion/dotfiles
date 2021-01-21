set noswapfile
set nu
set mouse=a
set termguicolors
sy on
" highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
" highlight LineNr ctermfg=black ctermbg=gray
" colorscheme NeoSolarized

colorscheme one
set background=light

set showtabline=2
set numberwidth=5
set colorcolumn=80,120
setlocal path=.,**

set clipboard+=unnamedplus

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

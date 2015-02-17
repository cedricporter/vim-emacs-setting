set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'

Plugin 'Zenburn'

Plugin 'saltstack/salt-vim'

Plugin 'https://github.com/kien/ctrlp.vim'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

Plugin 'bling/vim-airline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
" filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"

set t_Co=256       " Explicitly tell Vim that the terminal supports 256 colors
set laststatus=2

let g:airline#extensions#tabline#enabled = 1

" let g:zenburn_high_Contrast=1
colors zenburn

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugin
" filetype plugin on
" filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

set ignorecase "Ignore case when searching
set smartcase

" Set 5 lines to the curors - when moving vertical..
set so=5
" set wildmenu "Turn on Wild menu
" set ruler "Always show current position
" set cmdheight=2 "The commandbar height
" set hid "Change buffer - without saving

set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 
set magic "Set magic on, for regular expressions
set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink
set showcmd	"show (partial) command when not complete

syntax enable "Enable syntax hl
set nu
set encoding=utf8

set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr     "Line break
set tw=500  "Textwidth

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

map zz ZQ


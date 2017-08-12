" Eric Reinecke's vimrc
" 
" Useful tidbits:
"  https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/

" ==== BEGIN VUNDLE ====

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

"Plugin 'https://github.com/andviro/flake8-vim.git'
Plugin 'vim-syntastic/syntastic.git'
Plugin 'ervandew/supertab.git'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'heavenshell/vim-pydocstring'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'martinda/Jenkinsfile-vim-syntax'

" Snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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

" ==== END VUNDLE ====


" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"########## EREINECKE SETTINGS
" snag python scripts
"python << EOF
"try:
"    from vimPythonScripts import openPyDoc, loadHeaderFile
"except ImportError:
"    pass
"EOF
"au BufReadPre * setlocal foldmethod=syntax

set encoding=utf-8

" use eric colorscheme
colorscheme eric

" I heart 80 columns
if exists('+colorcolumn')
  set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif


" Custom Sytax highlights
au BufNewFile,BufRead *rc set ft=tcsh
au BufNewFile,BufRead .vimrc set ft=vim
au BufNewFile,BufRead *.sl set ft=sl
au BufNewFile,BufRead cloudformation.template set ft=yaml
au BufNewFile,BufRead *.json set ft=javascript
au BufNewFile,BufRead *.otio set ft=javascript
au BufNewFile,BufRead *.mpd set ft=xml

" Use NerdTree when opening a dir
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" autoquit vim if the last buffer is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Pydocstring custom templates
let g:pydocstring_templates_dir = $HOME . '/.vim/template/pydocstring'
let g:pydocstring_enable_mapping = 0

" @{
" Python hot keys.
" run the current buffer as a python file
map ;PD  :Pydocstring
map ;PF  :pyfile %<cr>
" bring up the pydoc for the current file
map ;PH :python openPyDoc()<cr>
ounmap ;PF
ounmap ;PH
" ounmap ;PC
" bicycle repairman stuff
map ;br :BikeRename<cr>
map ;be :BikeExtract<cr>
" @}

" enable all Python syntax highlighting features
let python_highlight_all = 1

set expandtab	"enable soft tabs
set shiftwidth=4
"set softtabstop=4
set tabstop=4
autocmd BufEnter *.js set shiftwidth=2
autocmd BufEnter *.html set shiftwidth=2
autocmd BufEnter *.css set shiftwidth=2

" Visual things
set cursorline  " visual line under cursor's line
set showmatch   " show matching brackets and such
set relativenumber
set number      " show line numbers

" smartcase
" /copyright      " Case insensitive
" /Copyright      " Case sensitive
" /copyright\C    " Case sensitive
" /Copyright\c    " Case insensitive
:set smartcase

set vb "Visual bells

" Backup settings
set backup
" set backupdir=~/.vimBak

" Wrapping settings
set whichwrap=b,s,<,>,[,]

" highlighting lines longer than 80 chars
 " automatically be warned for all files - turn * in to *.c,*.h,*.py
 " http://vim.wikia.com/wiki/Highlight_text_beyond_80_columns
" au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>81v', -1)
" au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%81v.\+', -1)

" taglist stuff
map <c-a-T> :TlistToggle<cr>
map ;T :!ctags .<cr>:TlistToggle<cr>:TlistUpdate<cr>

" allow alt / to search currently selected text
vnoremap <M-/> <Esc>/\%V

" Set size to 80x54 if in gui mode (84 cols takes gutter numbering into acct)
" We add a bit to the 54 to allow NerdTree some space too!
if has("gui_running")
    set lines=52 columns=116
endif

" Use github markdown
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=1

" Comment
map ;c <Plug>Comment
map ;x <Plug>DeComment

" Filetype stuff
"filetype on
"filetype plugin on

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"########## END EREINECKE SETTINGS

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


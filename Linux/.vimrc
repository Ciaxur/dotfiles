" Vundle Setup
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
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" Nerd Tree 
Plugin 'file:///home/omar/.vim/bundle/nerdtree'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

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



"" General Configuration
set         history=500



" Change viminfo Location
set viminfo+=n~/.vim/viminfo

" Tabbing Configuration
filetype    plugin indent on
set         tabstop=4
set         shiftwidth=4
set         expandtab
set         smarttab
set         ai              " Auto Indent
set         si              " Smart Indent
syntax      on
colorscheme desert
set         mouse=a         " Enable Mouse Interactions

" Active Search Highlighting
set hlsearch                " Highlights Search
set incsearch               " Highlight as you type
set ignorecase              " Ignore Case while searching  
set smartcase               " Be Smart About Cases
set showcmd                 " Show Commands being typed


" Clear Search -> \c
map <leader>c :noh<cr>     

" Match Braces
set showmatch

" Hybrid Line Numbers ON
set         relativenumber
set         nu rnu


"" Mapping Keys
" Remap ctrl+w to ctrl+e (File Switching for vim -o file1 file2)
nnoremap    <C-e> <C-w>             
" Quick Save -> \w
nmap        <leader>w :w<cr>        
" Switch between opened Files \[ and \]
nmap        <leader>[ :prev<cr>     
nmap        <leader>] :next<cr>


" Mapping for Managing Tabs
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>t[ :tabprevious<cr>
map <leader>t] :tabnext<cr>


"" Commands
" Sudo Saves current file -> :W
command W w !sudo tee % > /dev/null


"" Status Line
set laststatus=2
set statusline=\%{HasPaste()}%F%m%r%h\ %w\ \ \ \ %=Line:\ %l\ \ Column:\ %c


"" Spell Check Toggle (Type ss)
map ss :setlocal spell!<cr>


"" User-Plugins
Plugin 'airblade/vim-gitgutter'


"""""""""""""""""""""""""""""
" NERD TREE CONFIGURATION
"""""""""""""""""""""""""""""
"" Toggle NerdTree (Ctrl+B)
map <C-b> :NERDTreeToggle<cr>
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize=35




"" Functions
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction




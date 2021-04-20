"" General Configuration
set         history=500


" Make Cursor Hori-Line in Insert
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

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
set number

"" Commands
" Sudo Saves current file -> :W
command W w !sudo tee % > /dev/null

"" Status Line
set laststatus=2
set statusline=\%{HasPaste()}%F%m%r%h\ %w\ \ \ \ %=Line:\ %l\ \ Column:\ %c


"" Spell Check Toggle (Type ss)
map ss :setlocal spell!<cr>

"" Functions
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

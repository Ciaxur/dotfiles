" Sudo Saves current file -> :W
command W w !sudo tee % > /dev/null

" Custom Commands
command RunPython !python %
command RunGo     !go run %
command FoldAll   normal zM<cr>
command UnFoldAll normal zR<cr>

" Buffer
noremap <c-w> :bdel<cr>
nnoremap <silent><c-n> :tabnew<cr>
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>w :w<cr>
nnoremap <silent> <leader>nn :NnnPicker<cr>


" Switch to # Tabs Alt+<Tab#>
noremap <A-1> 1gt<cr>
noremap <A-2> 2gt<cr>
noremap <A-3> 3gt<cr>
noremap <A-4> 4gt<cr>
noremap <A-5> 5gt<cr>
noremap <A-6> 6gt<cr>


" Clear Search -> \c
map <leader>c :noh<cr>

" Mapping for Managing Tabs -> \
noremap <silent> <c-t> :tabnew<cr>
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>t[ :tabprevious<cr>
map <leader>t] :tabnext<cr>

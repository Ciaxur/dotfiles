" NNN Plugin Settings
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }

" Setup NNN Command & ENV
let $NNN_TMPFILE='/tmp/nnn.tmp'
let $NNN_FCOLORS='EEEEAAAF00000087005F8700FF'
let $NNN_PLUG='f:fzcd;o:fzopen;h:hexview;d:diffs;i:mediainf;j:autojump'
let $TERMINAL='/bin/termite'
let g:nnn#command = 'nnn -ade'

" Remap nnn to open Current File's Directory
let g:nnn#set_default_mappings = 0
nnoremap <leader>n :NnnPicker %:p:h<CR>

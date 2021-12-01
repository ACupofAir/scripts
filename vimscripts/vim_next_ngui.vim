"v2021.12.01.11_Linux

" configs {{{
set autowriteall
set relativenumber number
set splitbelow
set splitright
set mouse=
set nocompatible
let $LANG = 'en'  "set message language
set langmenu=en   "set menu's language of gvim. no spaces beside '='
set encoding=utf-8
set fileencodings=utf8,gbk
set backspace=2
set incsearch
set shortmess-=S
set showcmd
set ignorecase smartcase
set clipboard=unnamedplus
set number
syntax on
set ruler
set autoindent
set cindent
set shiftwidth=2
set tabstop=2
set expandtab
%retab!
set history=1000
set hlsearch
set novb
set wrap
set numberwidth=4
set t_Co=256
set showtabline=2
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" }}}

" functions {{{
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"ToggleMouse:
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
  else
    set mouse=a
  endif
endfunction

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"Vsb:
function VsbFunction (arg1)
  execute 'vert sb' a:arg1
endfunction

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" mappings{{{
noremap <Space> <Nop>
map <Space> <Leader>
nnoremap <leader>e :Vex<CR>
nnoremap <leader>th :ter ++rows=10<CR>
nnoremap <leader>tv :vert :ter ++cols=55<CR>
nnoremap <leader>nh :nohl<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>rn *Ncgn
nnoremap <leader>m :call ToggleMouse()<CR>
" Maps Ctrl-[h,j,k,l] to resizing a window split
map <silent> <C-h> <C-w><
map <silent> <C-j> <C-W>-
map <silent> <C-k> <C-W>+
map <silent> <C-l> <C-w>>
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>
nnoremap <ESC><ESC> :call popup_close(win_getid())<CR>
autocmd FileType html inoremap <buffer> ><space> ><Esc>F<lyt>o</<C-r>"><Esc>kJxi

tnoremap <Esc> <C-\><C-n>

command -nargs=1 Vsb call VsbFunction(<f-args>)
"}}}


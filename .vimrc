
execute pathogen#infect()
filetype plugin indent on

" Vim stuff
set number
"set rnu
set t_Co=256
set timeoutlen=0
set expandtab
set tabstop=4
set shiftwidth=2
set laststatus=2
set backspace=indent,eol,start
colorscheme 1989
syntax on

fun! TrimTraillingSpace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

"Remove all trailing whitespace by pressing F5
" noremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Unmap useless stuff
noremap <S-F> <NOP>
noremap <C-s> <NOP>
noremap <S-q> <NOP>
noremap <S-j> <NOP>
noremap <S-k> <NOP>
noremap <S-a> <NOP>
" noremap | <NOP>
noremap $ <NOP>
noremap 0 <NOP>
noremap a <NOP>
noremap <C-t> :tabnew<CR>

" noremap <silent> <C-Up>
" noremap <silent> <C-Down>
noremap <C-Left> b
noremap <C-Right> w

" Syntastic stuff
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Airline stuff
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_theme = 'zenburn'
let g:airline#extensions#bufferline#enabled = 1

" NerdTree stuff
map <F4> :NERDTreeToggle<CR>
" let g:NERDTreeDirArrowExpandable='>'
" let g:NERDTreeDirArrowCollapsibl ='^'
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


" Plugins / vim-plug  --------------- {{{
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
" Plug 'plasticboy/vim-markdown'
" Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'

call plug#end()
" }}}

" Formatting & UI settings --------------- {{{


" set laststatus=2

" Add line underneath cursor
set cursorline

" Highlight cursor column
set cursorcolumn

" Add line numbers to left hand side
set number

" Expand tabs into space characters
set expandtab

" set number of spaces per tab
set tabstop=4
set shiftwidth=4

" Backspace will delete a tab/shiftwidth worth of whitespace 
set smarttab

" Copy indentation from last line
set autoindent

" Wrap text when too long to fit on line
set wrap

" Backspace and movement keys will wrap to prev/next line at start/end of line
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" Briefly highlights matchine brace/parenthesis/bracket when typeds
set showmatch

" Ignore case when searching, unless there are upper case chars in search
set ignorecase
set smartcase

" Highlight search, and search as user types
set hlsearch
set incsearch

" Overlay menu to display options
set wildmenu
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*.pages

" Keep X lines above/below cursor when scrolling
set scrolloff=7


" }}} 

" Misc Settings --------------- {{{
" Return to last edit position when opening a file
autocmd BufReadPost * if line("'\'") > 1 && line("'\'") <= line("$") | execute "normal! g'\"" | endif
" }}}

" Color Scheme --------------- {{{
try
    colorscheme slate
catch
endtry
" }}}

" Fold settings --------------- {{{
augroup remember_folds
  autocmd!
  "autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Filetype settings --------------- {{{
augroup file_types
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
    autocmd FileType markdown set conceallevel=3
    autocmd FileType markdown setlocal nospell
augroup END
" }}}

" Coding Settings ~~~~~~~~~~~~~~~ {{{
" Coding comment shortcuts --------------- {{{
augroup comment_code
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
augroup END
" }}}
" Code parenthesis/etc settings --------------- {{{
augroup code_parenthesis
    autocmd!
    autocmd FileType python inoremap { {<cr>}ko
    autocmd FileType python inoremap ( ()<esc>i
    autocmd FileType python inoremap [ []<esc>i
    autocmd FileType javascript inoremap { {<cr>}ko
    autocmd FileType javascript inoremap ( ()<esc>i
    autocmd FileType javascript inoremap [ []<esc>i
augroup END    
" }}}
"}}}

" NERDTree config --------------- {{{


" toggle NERDTree file manager sidebar
silent! nmap <C-p> :NERDTreeToggle<CR>

silent! map <F3> :NERDTreeFind<CR>
let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"


" }}}

" Keybinds --------------- {{{


" Define leader and alt/local leader
let mapleader = ","
let maplocalleader = "]"

" input mode cut and paste -- ,d ,p
inoremap <leader>d <esc>ddi
inoremap <leader>p <esc>pi

" normal mode edit vim and source vim -- ,ev  ,sv
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Shortcut for begining or end of line -- ,h  ,l
nnoremap <leader>l $
nnoremap <leader>h ^
inoremap <leader>l <esc>$a
inoremap <leader>h <esc>^i

" remap esc to jk for ease of use
inoremap jk <esc>

" Quick upper or lower case current word -- ,U  or ,u
inoremap <leader>U <esc>viwU<esc>wi
nnoremap <leader>U viwU<esc>w
inoremap <leader>u <esc>viwu<esc>wi
nnoremap <leader>u viwU<esc>w 

" Surround current word in quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" Quick save in input mode -- ,w
inoremap <leader>w <esc>:w<cr>a

" Append semicolon to eol, but leave cursor where it is (normal mode) -- ,;
nnoremap <leasder>; :execute "normal! mqA;\<esc>`q"

" removed keymaps {{{
"onoremap p i(
"onoremap q i'
"onoremap Q i"
"onoremap b i[
"onoremap B i{
" }}}

" movements for inside next and last () [] '' etc ~~~~~~~~~~~~~~~ {{{
onoremap in( :<c-u>normal! F(vi(<cr>
onoremap il( :<c-u>normal! f(vi(<cr>
onoremap in{ :<c-u>normal! F{vi{<cr>
onoremap il{ :<c-u>normal! f{vi{<cr>
onoremap in' :<c-u>normal! F'vi'<cr>
onoremap il' :<c-u>normal! f'vi'<cr>
onoremap in" :<c-u>normal! F"vi"<cr>
onoremap il" :<c-u>normal! f"vi"<cr>
onoremap in[ :<c-u>normal! F[vi[<cr>
onoremap il[ :<c-u>normal! f[vi[<cr>
" ~ }}}
" }}}

" Abbreviations and character shortcuts --------------- {{{

" }}}

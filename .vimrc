"## NOTE: Use 'zR' to open all folds in the file and 'zM' to close all folds
" **MUST BE IN NORMAL MODE**

"PLUGINS{{{

" Plugins / vim-plug  --------------- {{{
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
"Plug 'plasticboy/vim-markdown'
"Plug 'junegunn/fzf.vim'

call plug#end()
" --------------- }}}


" NERDTree config --------------- {{{


" # Toggle NERDTree file manager sidebar
silent! nmap <C-p> :NERDTreeToggle<CR>

silent! map <F3> :NERDTreeFind<CR>
let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"


" --------------- }}}

"}}}

"SETTINGS{{{

" Status Line --------------- {{{
" *** for highlighting colors, use:
"     so: $VIMRUNTIME/syntax/hitest.vim
" highlighting syntax:
"     #%<COLOR SCHEME>#


" Initialize statusline
set statusline=
set statusline+=%#Directory#\ 

" Always have a status line
set laststatus=2

" Add (relative) path to working file to statusline
set statusline+=%f\ 
set statusline+=%#SignColumn#\ 

" Statusline separator
"set statusline+=\ -\ 

" FileType label
set statusline+=FileType:%y

" Line Number
set statusline+=\ -\ 
set statusline+=Line:\ 
set statusline+=%l/%L\ 
"set statusline+=\ -\ 
"set statusline+=%L

" Show current mode ~~~~~~~~~~ {{{

set statusline+=%#StatusLineTermNC#
set statusline+=\ [\ 

let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ "\<C-V>" : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \}

set statusline+=\ %{toupper(g:currentmode[mode()])}]\ 

" ~~~~~~~~~~ }}}

" Show * if modified
set statusline+=%{&modified?'*':''}


" --------------- }}}

" Formatting & UI settings --------------- {{{


" Add line underneath cursor
set cursorline

" Highlight cursor column
set cursorcolumn

" Add line numbers to left hand side
set number

" Expand tabs into space characters
set expandtab

" Set number of spaces per tab
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
set noshowmatch

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


" --------------- }}} 

" Misc Settings --------------- {{{


" # Return to last edit position when opening a file
autocmd BufReadPost * if line("'\'") > 1 && line("'\'") <= line("$") | execute "normal! g'\"" | endif

" # Enable use of mouse in all modes
set mouse=a

" --------------- }}}

" Color Scheme --------------- {{{
try
    colorscheme slate
catch
endtry
" }}}

"}}}

"AUTOCOMMANDS{{{

" Fold settings --------------- {{{

" # Do not ignore '#' characters for folding -- only useful for editing C files
set foldignore=

augroup remember_fold
  autocmd!
  "autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END
" # Best to setup manual folds for vimscript files
augroup marker_fold
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" # Using expression folding for markdown files ~~~~~~~~~~ {{{
augroup expr_fold_md
    autocmd!
    autocmd FileType markdown setlocal foldmethod=expr
    autocmd FileType markdown setlocal foldexpr=GetMdFold(v:lnum)
augroup END
" # Markdown expression folding code ===== {{{
function! GetMdFold(lnum)
    " ...cheching for blank lines...
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif
   
    " ...using 'IndentLevel' helper function to get line num of this and next line...
    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    " ...comparing indent level of this and next line to decide how to fold
    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
endfunction

function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1
    while current <= numlines
        if getline(current) = ~? '\v\S'
            return current
        endif
        let current += 1
    endwhile
    " ...arbitrary 'error code' -2...
    return -2
endfunction
" ===== }}}
" ~~~~~~~~~~ }}}

" # Using indent-based folding for code files
augroup indent_fold_code
    autocmd!
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType javascript setlocal foldmethod=indent
augroup END

" --------------- }}}

" Filetype settings --------------- {{{
augroup filetype_settings
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
    autocmd FileType markdown set conceallevel=3
    autocmd FileType markdown setlocal nospell
augroup END
" --------------- }}}

" Coding Settings --------------- {{{
" Coding comment shortcuts ~~~~~~~~~~~ {{{
augroup comment_code
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
augroup END
" ~~~~~~~~~~ }}}
" Code parenthesis/etc settings ~~~~~~~~~~ {{{
augroup code_parenthesis
    autocmd!
    autocmd FileType python inoremap { {<cr>}<esc>ko
    autocmd FileType python inoremap ( ()<esc>i
    autocmd FileType python inoremap [ []<esc>i
    autocmd FileType javascript inoremap { {<cr>}<esc>ko
    autocmd FileType javascript inoremap ( ()<esc>i
    autocmd FileType javascript inoremap [ []<esc>i
augroup END    
" ~~~~~~~~~~ }}}
" --------------- }}}

"}}}

" Keybinds --------------- {{{


" # Define leader and alt/local leader
let mapleader = ","
let maplocalleader = "]"

" # Cut, copy, paste from system clipboard -- uses '+' register on mac,  or '*' register on
" windows
vnoremap <leader>d "+d
vnoremap <leader>y "+y
inoremap <leader>P <esc>"+pa
nnoremap <leader>P "+pa

" # Input mode cut, copy and paste -- ,d ,p
inoremap <leader>d <esc>ddi
inoremap <leader>y <esc>yyi
inoremap <leader>p <esc>pi

" # Normal mode edit vim and source vim -- ,ev  ,sv
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" # Shortcut for begining or end of line -- ,h  ,l
nnoremap <leader>l $
nnoremap <leader>h ^
inoremap <leader>l <esc>$a
inoremap <leader>h <esc>^i

" # Remap esc to jk for ease of use
inoremap jk <esc>

" # Quick upper or lower case current word -- ,U  or ,u
inoremap <leader>U <esc>viwU<esc>wi
nnoremap <leader>U viwU<esc>w
inoremap <leader>u <esc>viwu<esc>wi
nnoremap <leader>u viwU<esc>w 

" # Surround current word in quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" # Quick save in input mode -- ,w
inoremap <leader>w <esc>:w<cr>a

" # Append semicolon to eol, but leave cursor where it is (normal mode) -- ,;
nnoremap <leader>; :execute "normal! mqA;\<esc>`q"

" Removed keymaps ~~~~~~~~~~ {{{
"onoremap p i(
"onoremap q i'
"onoremap Q i"
"onoremap b i[
"onoremap B i{
" ~~~~~~~~~~ }}}

" Movements for inside next and last () [] '' etc ~~~~~~~~~~~ {{{
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

" Abbreviations and character shortcuts ~--------- {{{

" --------------- }}}

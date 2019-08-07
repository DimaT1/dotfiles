" Auto update file when it is changed outside vim
" TODO: does not work as it expected with nvim
set autoread

" Aesthetic line numeration
set nu rnu

" Leader Key
let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab
au FileType go set noexpandtab

" Smart tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
au FileType vue set shiftwidth=2
au FileType vue set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocompile, file format
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run golang file
au FileType go map <F8> :w <CR> : !clear; go run % <CR>

" Auto pep8 for python (autopep8 is required)
au FileType python map <F7> :w <CR> : !clear; autopep8 --in-place % <CR> :e <CR>
" Run python3 file
au FileType python map <F8> :w <CR> : !clear; python3 % <CR>

" Auto format C/C++ file (clang-format is required)
au FileType c,cpp,objc map <F7> :w <CR> : !clear; clang-format % >> temp.cpp; mv temp.cpp % <CR> :e <CR>
" Build & run C++ file with g++ -std=c++11
au FileType cpp map <F8> :w <CR> : !clear; ~/Projects/cpp/build_n_run_cpp11.sh % <CR>

" Build & run C file with gcc -std=c99
au FileType c map <F8> :w <CR> : !clear; ~/Projects/cpp/build_n_run_c99.sh % <CR>
" Build & run C file with tcc
au FileType c map <F9> :w <CR> : !clear; tcc -run -g % <CR>


" Print int main() to C file
function! CIntma()
call append(line('^'), [ '#include <stdio.h>'
\                      , ''
\                      , 'int main(int argc, char *argv[]) {'])
call append(line('$'), [ '    printf("Hello World");'
\                      , '    return 0;'
\                      , '}'])
endfunction
" :Intma function in .c files
au FileType c command Intma :call CIntma()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " don't remember what it actually does

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/fzf.vim'
Plugin 'posva/vim-vue'
Plugin 'itchyny/lightline.vim'

Plugin 'maralla/completor.vim'
Plugin 'davidhalter/jedi-vim', { 'for': 'python' }
Plugin 'neomake/neomake'

highlight Pmenu ctermfg=0 ctermbg=15 guifg=#ffffff guibg=#707880

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" let g:ycm_autoclose_preview_window_after_insertion = 1
" 
" " Syntastic
" let g:syntastic_c_checkers=['make']
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_check_on_open=1
" let g:syntastic_enable_signs=1
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_warning_symbol = '⚠'

function! Tab_Or_Complete() abort
    " If completor is already open the `tab` cycles through suggested completions.
    if pumvisible()
        return "\<C-N>"
    " If completor is not open and we are in the middle of typing a word then
    " `tab` opens completor menu.
    elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^[[:keyword:][:ident:]\.]'
        return "\<C-R>=completor#do('complete')\<CR>"
    else
        " If we aren't typing a word and we press `tab` simply do the normal `tab`
        " action.
        return "\<Tab>"
    endif
endfunction

" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <Tab> Tab_Or_Complete()
set completeopt=menuone,noinsert,noselect
let g:completor_complete_options='menuone,noinsert,noselect'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neomake
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! CheckNeomakeSkip()
	for linenr in range(5)
		if match(getline(linenr), 'neomake: skip') != -1
		\ || match(getline(line('$') - linenr), 'neomake: skip') != -1
			silent NeomakeDisableBuffer
			NeomakeClean
			return
		endif
	endfor
	let [disabled, source] = neomake#config#get_with_source('disabled', 0)
	if disabled && source ==# 'buffer'
		silent NeomakeEnableBuffer
		Neomake
	endif
endfunction

augroup neomake_skip
	au!
	autocmd BufEnter,InsertLeave,TextChanged * call CheckNeomakeSkip()
augroup END

let g:neomake_python_pylint_maker = {
    \ 'args': [
    \ '-d', 'C0103,C0111',
    \ ],
    \ }

let g:neomake_highlight_lines = 1
let g:neomake_highlight_columns = 0
let g:neomake_shellcheck_args = ['-fgcc']
let g:neomake_python_enabled_makers = ['python3', 'flake8', 'mypy', 'pylint']

let g:neomake_error_sign = {
    \ 'text': nr2char(10007),
    \ 'texthl': 'NeomakeErrorSign'
    \ }

let g:neomake_warning_sign = {
    \ 'text': nr2char(10071),
    \ 'texthl': 'NeomakeWarningSign'
    \ }

let g:neomake_info_sign = {
    \ 'text': nr2char(10148),
    \ 'texthl': 'NeomakeInfoSign'
    \ }

let g:neomake_message_sign = {
    \ 'text': nr2char(10148),
    \ 'texthl': 'NeomakeMessageSign'
    \ }

call neomake#configure#automake('nrwi', 200)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open NERDTree with Ctrl-n
" TODO: auto reload tree
" Nwerd tree can be reloaded with r key or while reload
map <C-n> :NERDTreeToggle<CR>:NERDTreeRefreshRoot<CR>
" let NERDTreeIgnore=['\.o$', '\.out$', '\.pyc$', '\~$'] 
let NERDTreeIgnore=['\.o$', '\.pyc$', '\~$', '__pycache__$', '.git$', '.mypy_cache$']
let NERDTreeShowHidden=1

nnoremap Y y$

" split screen navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Smart search
" silversearcher-ag required
map <F4> :Ag<CR>

" Disable bells 
set visualbell
set t_vb=

" Copy from vim - ctrl+c
" Paste to vim - ctrl+p
" gvim required
vnoremap <C-c> "*y :let @+=@*<CR>
map <C-p> "+p

" Check spelling
map <F6> :setlocal spell! spelllang=en_us,ru<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HTML leader combinations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType html map <leader>b o<b></b><Space><Esc>FbT>i
au FileType html map <leader>1 o<h1></h1><Esc>02f<i
au FileType html map <leader>2 o<h2></h2><Esc>02f<i
au FileType html map <leader>3 o<h3></h3><Esc>02f<i
au FileType html map <leader>4 o<h4></h4><Esc>02f<i
au FileType html map <leader>5 o<h5></h5><Esc>02f<i
au FileType html map <leader>6 o<h6></h6><Esc>02f<i
au FileType html map <leader>p o<p></p><Esc>02f<i
au FileType html map <leader>a o<a href=""><++></a><Esc>0f"a
au FileType html map <leader>im o<img src="" alt="<++>"<++>><Esc>0f"a
au FileType html map <leader>it o<i></i><Esc>0f>a
au FileType html map <leader>sm o<small></small><Esc>0f>a
au FileType html map <leader>ma o<mark></mark><Esc>0f>a
au FileType html map <leader>q o<q></q><Space><Esc>02f<i
au FileType html map <leader>/ o<!--  --><Space><Esc>0f a
au FileType html map <leader>ul o<ul><Enter><li></li><Enter></ul><Esc>0k2f<i
au FileType html map <leader>li o<li></li><Esc>F>a
au FileType html map <leader>ol o<ol><Enter><li></li><Enter></ol><Esc>0k2f<i

inoremap <leader>c <Esc>/<++><Enter>"_c4l
vnoremap <leader>c <Esc>/<++><Enter>"_c4l
map      <leader>c <Esc>/<++><Enter>"_c4l

inoremap <leader>d <Esc>/<++><Enter>"_d4l
vnoremap <leader>d <Esc>/<++><Enter>"_d4l
map      <leader>d <Esc>/<++><Enter>"_d4l

" Print main to HTML file
function! HTMLma()
call append(line('^'), [ '<!DOCTYPE html>'
\                      , '<html>'
\                      , '<head>'
\                      , '<title><++></title>'
\                      , '</head>'
\                      , '<body>'])
call append(line('$'), [ '</body>'
\                      , '</html>'])
endfunction
" :Intma function in .c files
au FileType html command Intma :call HTMLma()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim color scheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme darkblue
set cursorline
hi CursorLine   cterm=NONE ctermbg=8


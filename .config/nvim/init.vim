" Auto update file when it is changed outside vim
" TODO: does not work as it expected with nvim
set autoread

" Aesthetic line numeration
set nu rnu

" Leader Key
let mapleader = ","

set viminfo='1000,f1

" Requires
" pip install jedi pyls pynvim
" clangd texlab
" flake8 mypy pylint


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
au FileType yaml set shiftwidth=2
au FileType yaml set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines

" Ex mode
map q: <Nop>
nnoremap Q <nop>

set ttyfast

" To prevent conceal in LaTeX files
let g:tex_conceal = ''

" To prevent conceal in any file
set conceallevel=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " don't remember what it actually does

call plug#begin('~/.vim/plugged')
Plug 'jceb/vim-orgmode'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'

Plug 'maralla/completor.vim'
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'neomake/neomake'

Plug 'raimon49/requirements.txt.vim'
Plug 'shmup/vim-sql-syntax'

Plug 'flazz/vim-colorschemes'

Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
Plug 'kshenoy/vim-signature'
Plug 'RRethy/vim-illuminate'

Plug 'christoomey/vim-tmux-navigator'

Plug 'tomtom/tcomment_vim'
Plug 'tmhedberg/matchit'
Plug 'gregsexton/matchtag'
Plug 'donRaphaco/neotex', { 'for': 'tex' }

Plug 'mhinz/vim-startify'
call plug#end()


" All of your Plugins must be added before the following line
filetype plugin indent on    " required

" Displaying thin vertical lines at each indentation level
let g:jedi#use_splits_not_buffers = "right"
let g:indentLine_char_list = ['|', '¦', '┆', '┊']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
let g:completor_min_chars=1
let g:completor_completion_delay=10

let g:completor_clang_binary = '/usr/bin/clang'
let g:completor_filetype_map = {}
let g:completor_filetype_map.c = {'ft': 'lsp', 'cmd': 'clangd'}
let g:completor_filetype_map.cpp = {'ft': 'lsp', 'cmd': 'clangd'}
let g:completor_filetype_map.tex = {'ft': 'lsp', 'cmd': 'texlab'}

noremap <silent> <leader>gd :call completor#do('definition')<CR>
" noremap <silent> <leader>c :call completor#do('doc')<CR>
" noremap <silent> <leader>f :call completor#do('format')<CR>
" noremap <silent> <leader>s :call completor#do('hover')<CR>


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
    \ 'text': '✗',
    \ 'texthl': 'NeomakeErrorSign'
    \ }

let g:neomake_warning_sign = {
    \ 'text': '⚠',
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
map <F3> :FZF<CR>
map <F4> :Ag<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
" let g:fzf_layout = { 'up': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10new' }

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
" Snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/.vim/snippets.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim color scheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorschemes I lile
"
" colorscheme
" colorscheme Revolution
" colorscheme OceanicNext
" colorscheme Tomorrow-Night
" colorscheme badwolf " ---
" colorscheme beekai " ---
colorscheme gruvbox

" blues colorscheme
" colorscheme blues
" let g:lightline = {
"       \ 'colorscheme': 'wombat',
"       \ }
" hi String ctermfg=109
" hi Number ctermfg=109
" hi Character ctermfg=109
"

au FileType python set colorcolumn=80
hi ColorColumn ctermbg=8

set cursorline
hi CursorLine   cterm=NONE ctermbg=8

hi NeomakeWarning   ctermbg=8
hi NeomakeError     ctermbg=4

" highlight trailing spaces
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap gn :tabnew<Space>
nnoremap gl :tabnext<CR>
nnoremap gh :tabprev<CR>

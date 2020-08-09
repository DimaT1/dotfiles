set autoread

" Aesthetic line numeration
set nu rnu

" Leader Key
let mapleader = ","

set viminfo='1000,f1
set encoding=UTF-8

" Requires
" pip install jedi pyls pynvim flake8 mypy pylint
" clangd texlab
" gofmt gocode
" ctags ripgrep

set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab
au FileType go set noexpandtab
au FileType c set noexpandtab
au FileType c set noexpandtab

" Smart tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
au FileType javascript set shiftwidth=2
au FileType javascript set tabstop=2
au FileType vue set shiftwidth=2
au FileType vue set tabstop=2
au FileType yaml set shiftwidth=2
au FileType yaml set tabstop=2
au FileType cpp set shiftwidth=2
au FileType cpp set tabstop=2

au FileType c,cpp,objc map <F7> :w <CR> : !clear; clang-format % >> temp.cpp; mv temp.cpp % <CR> :e <CR>
au FileType go map <F7> :w <CR> : !clear; gofmt % >> temp.cpp; mv temp.cpp % <CR> :e <CR>

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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'

Plug 'neomake/neomake'

Plug 'raimon49/requirements.txt.vim'

Plug 'flazz/vim-colorschemes'
Plug 'wadackel/vim-dogrun'
Plug 'sainnhe/edge'

Plug 'sheerun/vim-polyglot'
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
Plug 'kshenoy/vim-signature'
Plug 'RRethy/vim-illuminate'

Plug 'christoomey/vim-tmux-navigator'

Plug 'tomtom/tcomment_vim'
Plug 'tmhedberg/matchit'
Plug 'gregsexton/matchtag'
Plug 'donRaphaco/neotex', { 'for': 'tex' }

Plug 'tpope/vim-fugitive'
Plug 'arzg/vim-plan9'

" Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'ryanoasis/vim-devicons'

Plug 'tounaishouta/coq.vim'

" Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'

call plug#end()

" All of your Plugins must be added before the following line
filetype plugin indent on    " required

" Displaying thin vertical lines at each indentation level
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:Illuminate_highlightUnderCursor = 0

let g:polyglot_disabled = ['markdown']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Language Servers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if executable('clangd')
    lua require'nvim_lsp'.clangd.setup{}
endif
if executable('pyls')
    lua require'nvim_lsp'.pyls.setup{}
endif
if executable('bash-language-server')
    lua require'nvim_lsp'.bashls.setup{}
endif
if executable('gopls')
    lua require'nvim_lsp'.gopls.setup{}
endif
if executable('texlab')
    lua require'nvim_lsp'.texlab.setup{}
endif

lua vim.lsp.callbacks['textDocument/publishDiagnostics'] = nil
nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>d <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>D <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>k <cmd>lua vim.lsp.buf.hover()<CR>

autocmd BufEnter * lua require'completion'.on_attach()

let g:completion_enable_auto_popup = 0
inoremap <silent><expr> <c-p> completion#trigger_completion()
inoremap <silent><expr> <c-n> completion#trigger_completion()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect,longest

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_chain_complete_list = {
    \ 'default': [
    \    {'complete_items': ['buffers', ]},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \],
    \ 'c': [
    \    {'complete_items': ['lsp', ]},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \],
    \ 'cpp': [
    \    {'complete_items': ['lsp', ]},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \],
    \ 'python': [
    \    {'complete_items': ['lsp', ]},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \],
    \ 'sh': [
    \    {'complete_items': ['lsp', ]},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \],
    \ 'go': [
    \    {'complete_items': ['lsp', ]},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \],
    \ 'tex': [
    \    {'complete_items': ['lsp', ]},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \],
    \ 'latex': [
    \    {'complete_items': ['lsp', ]},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \]
\}

map <F8> :lua require'completion'.addCompletionSource('buffers', require'buffers'.complete_item)

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

" NeoMake linters config
let g:neomake_shellcheck_args = ['-fgcc']
let g:neomake_python_enabled_makers = ['python']
if executable('flake8')
	let g:neomake_python_enabled_makers += ['flake8']
endif
if executable('mypy')
	let g:neomake_python_enabled_makers += ['mypy']
endif
if executable('pylint')
	let g:neomake_python_enabled_makers += ['pylint']
endif

let g:neomake_go_enabled_makers = ['go', 'golint', 'golangci_lint']

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

" Run all makers with 200ms timeout in all modes
call neomake#configure#automake('nrwi', 200)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd Filetype coq nnoremap ,, :CoqRunToCursor<CR>

" Open NERDTree with Ctrl-n
" TODO: auto reload tree
" Nwerd tree can be reloaded with r key or while reload
map <C-n> :NERDTreeToggle<CR>:NERDTreeRefreshRoot<CR>
" let NERDTreeIgnore=['\.o$', '\.out$', '\.pyc$', '\~$']
let NERDTreeIgnore=['\.o$', '\.pyc$', '\~$', '__pycache__$', '.git$', '.mypy_cache$']
let NERDTreeShowHidden=1

nnoremap Y y$
nnoremap H 0
nnoremap L $

" split screen navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Smart search
" map <F3> :Clap files<CR>
" map <F4> :Clap grep<CR>
" nnoremap <C-f> :Clap blines <CR>
"
map <F3> :Files<CR>
map <F4> :Ag<CR>
nnoremap <C-f> :Lines<CR>

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
" colorscheme gruvbox
" colorscheme dogrun
" important!!
set termguicolors

" for dark version
set background=dark

" the configuration options should be placed before `colorscheme edge`

" let g:edge_style = 'neon'
" let g:edge_disable_italic_comment = 1
" colorscheme edge

" colorscheme edge

" colorscheme industry
highlight Pmenu ctermbg=gray guibg=gray


" colorscheme Tomorrow-Night-Bright
colorscheme PerfectDark
" colorscheme hybrid
"
" colorscheme darkdevel

" blues colorscheme
" colorscheme blues
" let g:lightline = {'colorscheme': 'one'}
" hi String ctermfg=109
" hi Number ctermfg=109
" hi Character ctermfg=109
"

au FileType python set colorcolumn=80
au FileType cpp set colorcolumn=80
hi ColorColumn ctermbg=8

set cursorline
hi CursorLine cterm=NONE ctermbg=8

hi NeomakeWarning   ctermbg=8
hi NeomakeError     ctermbg=4

" highlight trailing spaces
" hi ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/

" i3 config filetype detect
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

let g:lightline = {
    \ 'colorscheme': 'powerline',
    \ 'active': {
    \ 	'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified', 'gitbranch', 'current_func' ] ]
    \  },
    \ 'component_function': {
    \	'gitbranch': 'fugitive#head',
    \  }
    \ }
set noshowmode



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap gn :tabnew<Space>
nnoremap gl :tabnext<CR>
nnoremap gh :tabprev<CR>

nnoremap <C-e>     :tabnew<CR>
inoremap <C-e>     <Esc>:tabnew<CR>

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

tnoremap <Esc> <C-\><C-n>

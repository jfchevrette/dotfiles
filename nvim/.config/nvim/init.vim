if has('nvim')
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
end

if has('nvim')
    call plug#begin('~/.config/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
end

Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-signify'
Plug 'voldikss/vim-floaterm'
Plug 'justinmk/vim-sneak'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'sainnhe/sonokai'
Plug 'ap/vim-css-color'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'ayu-theme/ayu-vim'

call plug#end()

set updatetime=100

syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set relativenumber
set nowrap
set smartcase
set ignorecase
set noswapfile
set nobackup
if has('nvim')
    set undodir=~/.config/nvim/undodir
else
    set undodir=~/.vim/undodir
end
set undofile
set incsearch
set scrolloff=7

set list
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

set colorcolumn=80
if has('termguicolors')
    set termguicolors
endif
let ayucolor="mirage"
colorscheme ayu

let g:lightline = {
  \ 'colorscheme': 'ayu',
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' },
  \ }

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
    if exists('*fugitive#head')
        let branch = fugitive#head()
        return branch !=# '' ? ''.branch : ''
    endif
    return ''
endfunction

let mapleader=','


nnoremap <leader>t :FloatermNew --autoclose=1<CR>

nnoremap <leader>ud :UndotreeToggle<CR>

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>

nnoremap <leader>of :Files<CR>
nnoremap <leader>og :GFiles<CR>

nnoremap <leader>ec :e $MYVIMRC<CR>
nnoremap <leader>rc :w<CR>:so $MYVIMRC<CR>

nnoremap <leader>x <C-w>c
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

nnoremap <leader>bl :buffers<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

nnoremap <leader>a :Switch<CR>
let g:switch_custom_definitions =
    \ [
    \   ['yes', 'no'],
    \   ['on',  'off']
    \ ]

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

autocmd BufEnter * silent! lcd %:p:h
autocmd FileType fish setlocal sw=2 sts=2 et

lua <<EOF
require'nvim_lsp'.pyls.setup{
    on_attach=require'completion'.on_attach
}
require'nvim_lsp'.gopls.setup{
    on_attach=require'completion'.on_attach
}
EOF


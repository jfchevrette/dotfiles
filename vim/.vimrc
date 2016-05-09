call plug#begin('~/.vim/plugged')

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" ui/color
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'scrooloose/nerdtree'

" syntax/filetypes
Plug 'fatih/vim-go'
Plug 'vim-ruby/vim-ruby'
Plug 'elzr/vim-json'
Plug 'ekalinin/Dockerfile.vim'
Plug 'fatih/vim-nginx'

" utils
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'SirVer/ultisnips'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/vimproc' , { 'do': 'make'}

call plug#end()

" ================
" =   Settings   =
" ================

set nocompatible
filetype off
filetype plugin indent on

set ttyfast
set ttymouse=xterm2
set ttyscroll=3

set laststatus=2
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically reread changed files without asking me anything
set autoindent                  
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches

set noerrorbells             " No beeps
set number                   " Show line numbers
set relativenumber
set showcmd                  " Show me what I'm typing
set showmode                 " Show current mode.
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical to the right
set splitbelow               " split horizontal down
set autowrite                " Automatically save before switching buffer
set hidden                   " Hide buffers when abandonning it instead of unloading it
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS9 formats
set noshowmatch              " Do not show matching brackets
set nocursorcolumn           " Do not show the column the cursor is on
set cursorline               " Dont show the line the cursor is on
set ignorecase               " Ignore case when searching, typing commands, completing, etc...
set smartcase                " ...but not if it begins with upper case
set completeopt=menu,menuone " Autocomplete menu on insert mode
set pumheight=10             " Completion indow max items

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set clipboard^=unnamed
set clipboard^=unnamedplus

set lazyredraw " Do not redraw screen when executing macros or commands that have not been typed
set re=1
syntax sync minlines=256
set synmaxcol=300

set undofile
set undodir=~/.vim/tmp/undo//

set background=dark
"colorscheme molokai
let g:base16colorspace=256
colorscheme base16-ocean


if has("gui_macvim")
  set guifont=Hack:h16
  set clipboard+=unnamed
  set vb t_vb=
  set guioptions-=m " no menu
  set guioptions-=T " no toolbar
  set guioptions-=l " no left scrollbar
  set guioptions-=L " no left scrollbar on vsplit
  set guioptions-=r " no right scrollbar
  set guioptions-=R " no right scrollbar on hsplit

  let macvim_skip_colorscheme=1
  highlight SignColumn guibg=#232c31
endif

" ================
" =   Mappings   =
" ================

" use a mapleader variable 
let   mapleader = ","
let g:mapleader = ","

" close quickfix window
nnoremap <leader>a :cclose<CR>

" fast saving
nnoremap <leader>w :w!<CR>
nnoremap <silent> <leader>q :q!<CR>

" center the screen
nnoremap <space> zz

" better split management
nnoremap <C-H> :call WinMove('h')<CR>
nnoremap <C-J> :call WinMove('j')<CR>
nnoremap <C-K> :call WinMove('k')<CR>
nnoremap <C-L> :call WinMove('l')<CR>
nnoremap <C-X> :hide<CR>
function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr()) "we havent moved
    if (match(a:key,'[jk]')) "were we going up/down
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

" source/reload configuration
nnoremap <silent> <leader><F5> :source $MYVIMRC<CR>

" center on searching when going to the next match
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" ======================
" =   Plugin configs   =
" ======================

" ===== vim-airline =====
let g:airline_powerline_fonts = 1
let g:airline_theme='base16'

" ===== vim-go =====
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_term_enabled = 1
let g:go_term_height = 10
let g:go_highlight_space_tab_error = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

augroup gocmds
  au!
  autocmd FileType go nmap <buffer> <Leader>s  <Plug>(go-def-split)
  autocmd FileType go nmap <buffer> <Leader>v  <Plug>(go-def-vertical)
  autocmd FileType go nmap <buffer> <Leader>i  <Plug>(go-info)
  autocmd FileType go nmap <buffer> <Leader>l  <Plug>(go-metalinter)
  autocmd FileType go nmap <buffer> <leader>r  <Plug>(go-run-split)
  autocmd FileType go nmap <buffer> <leader>b  <Plug>(go-build)
  autocmd FileType go nmap <buffer> <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <buffer> <leader>dt <Plug>(go-test-compile)
  autocmd FileType go nmap <buffer> <Leader>d  <Plug>(go-doc)
augroup END

" ===== CtrlP =====
nnoremap <leader>ff :CtrlP<CR>
nnoremap <leader>fb :CtrlPBuffer<CR>
nnoremap <leader>fm :CtrlPMixed<CR>

let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'  " jump to a file if it's open already
let g:ctrlp_mruf_max=450    " number of recently opened files
let g:ctrlp_max_files=0     " do not limit the number of searchable files
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_match_window = 'bottom,order:btt,min:10,max:10,results:10'
let g:ctrlp_buftag_types = {'go' : '--language-force=go --golang-types=ftv'}
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" ===== NERDTree =====
noremap <Leader>n :NERDTreeToggle<cr>
let NERDTreeShowHidden=1
let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1

" ===== neocomplete =====
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
if !exists('g:neocomplete#sources')
  let g:neocomplete#sources = {}
endif
let g:neocomplete#sources._ = ['buffer', 'member', 'tag', 'file', 'dictionary']
let g:neocomplete#sources.go = ['omni']
call neocomplete#custom#source('_', 'sorters', [])

inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" ==================== UltiSnips ====================
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"


" ==================== Other plugins & settings ====================
nmap - <Plug>(choosewin)
let g:choosewin_overlay_enable = 1


" ====================
" =   Autocommands   =
" ====================
"
" Only show cursorline in the current window and in normal mode
augroup cursorline
  au!
  au WinLeave,InsertEnter * set nocursorline
  au WinEnter,InsertLeave * set cursorline
augroup END

" open help vertically
augroup verticalhelp
  au!
  command! -nargs=* -complete=help Help vertical belowright help <args>
  autocmd FileType help wincmd L
  autocmd FileType help setlocal nohidden
augroup END

augroup misc_stuff
  " cd into the file directory on enter
  autocmd BufEnter * silent! lcd %:p:h

  " Buffers/Files events
  autocmd BufNewFile,BufRead *.go   setlocal noet ts=4 sw=4 sts=4
  autocmd BufNewFile,BufRead *.vim  setlocal noet ts=2 sw=2 sts=2
  autocmd BufNewFile,BufRead *.md   setlocal noet ts=4 sw=4
  autocmd FileType json setlocal   et ts=2 sw=2
  autocmd FileType ruby setlocal   et ts=2 sw=2
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
augroup END


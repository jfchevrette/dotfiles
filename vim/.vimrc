" Bootstrap vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  echo "Installing vim-plug..."
  echo ""
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:just_installed_vimplug = "yes"
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
" ui/color
Plug 'itchyny/lightline.vim'
Plug 'felixjung/vim-base16-lightline'
Plug 'dracula/vim'
Plug 'chriskempson/base16-vim'
Plug 'scrooloose/nerdtree'

" syntax/filetypes
Plug 'fatih/vim-go'
Plug 'vim-ruby/vim-ruby'
Plug 'elzr/vim-json'
Plug 'ekalinin/Dockerfile.vim'
Plug 'fatih/vim-nginx'
Plug 'rust-lang/rust.vim'

" utils
Plug 'justinmk/vim-sneak'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'SirVer/ultisnips'
Plug 'Shougo/neocomplete.vim'

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
  let g:make = 'make'
endif
Plug 'Shougo/vimproc' , { 'do': g:make}

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
set fileencoding=utf-8
set fileencodings=utf-8
set autoread                    " Automatically reread changed files without asking me anything
set autoindent                  
set backspace=indent,eol,start  " Makes backspace key more powerful.

set hlsearch                    " Highlight found searches
set incsearch                   " Shows the match while typing
set ignorecase               " Ignore case when searching, typing commands, completing, etc...
set smartcase                " ...but not if it begins with upper case

set noerrorbells             " No beeps
set number                   " Show line numbers
set relativenumber
set showcmd                  " Show me what I'm typing
set showmode                 " Show current mode.

set nobackup                 " Don't create annoying backup files
set noswapfile               " Don't use swapfile

set splitright               " Split vertical to the right
set splitbelow               " split horizontal down
set autowrite                " Automatically save before switching buffer
set hidden                   " Hide buffers when abandonning it instead of unloading it
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS9 formats
set noshowmatch              " Do not show matching brackets
set nocursorcolumn           " Do not show the column the cursor is on
set cursorline               " Dont show the line the cursor is on
set completeopt=menu,menuone " Autocomplete menu on insert mode
set pumheight=10             " Completion indow max items

set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab

set clipboard^=unnamed
set clipboard^=unnamedplus

set lazyredraw " Do not redraw screen when executing macros or commands that have not been typed
set re=1
syntax sync minlines=256
set synmaxcol=300

set undofile
set undodir=~/.vim/tmp/undo//

set modeline
set modelines=10

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

if has("gui_running")
  set guifont=Source\ Code\ Pro\ for\ Powerline\ 14
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
nnoremap <C-n> :cnext<CR>
nnoremap <C-m> :cprevious<CR>
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
nnoremap <leader>x :hide<CR>
nnoremap <leader>o :only<CR>
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

" ===== lightline =====
let g:lightline = {
  \ 'colorscheme': 'base16_oceanicnext',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
  \   'right': [ [ 'syntastic', 'percent', 'lineinfo' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component': {
  \   'readline': '%{&readonly?"x":""}'
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightLineFugitive',
  \   'filename': 'LightLineFilename',
  \   'fileformat': 'LightLineFileformat',
  \   'filetype': 'LightLineFiletype',
  \   'fileencoding': 'LightLineFileencoding',
  \   'mode': 'LightLineMode',
  \ },
  \ 'component_expand': {
  \   'syntastic': 'SyntasticStatuslineFlag',
  \ },
  \ 'component_type': {
  \   'syntastic': 'error',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '|', 'right': '|' }
\ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '±' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? '' :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = '⎇ '
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END

function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

" ===== vim-sneak =====
let g:sneak#streak = 1

" ===== vim-go =====
let g:go_metalinter_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_term_enabled = 1
let g:go_term_height = 10
let g:go_highlight_space_tab_error = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1


function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

augroup gocmds
  au!
  autocmd FileType go nmap <buffer> <Leader>s  <Plug>(go-def-split)
  autocmd FileType go nmap <buffer> <Leader>v  <Plug>(go-def-vertical)
  autocmd FileType go nmap <buffer> <Leader>i  <Plug>(go-info)
  autocmd FileType go nmap <buffer> <Leader>l  <Plug>(go-metalinter)
  autocmd FileType go nmap <buffer> <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <buffer> <leader>b  :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <buffer> <leader>c  <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <buffer> <leader>t  <Plug>(go-test)
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

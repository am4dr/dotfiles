" neobundle.vim

if has('vim_starting')
    set nocompatible
	set runtimepath+=~/vimfiles/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/vimfiles/bundle/'))

filetype plugin indent on

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
let g:unite_enable_start_insert = 1
NeoBundle 'Shougo/unite-session'
NeoBundle 'Shougo/neomru.vim'

NeoBundle 'Shougo/vimfiler.vim'
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_time_format = "%m%d %H%M"

NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vinarise.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'koron/codic-vim'
" syntax
NeoBundle 'tikhomirov/vim-glsl'
" color
NeoBundle 'thinca/vim-guicolorscheme'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'vim-scripts/AfterColors.vim'
" colorschemes
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/Wombat'
set t_Co=256
set background=dark
colorscheme molokai
syntax on

NeoBundle 'itchyny/lightline.vim'
set laststatus=2
let g:lightline = {
\   'colorscheme': 'jellybeans',
\}

if has('lua')
    NeoBundle 'Shougo/neocomplete.vim'
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
else
    NeoBundle 'Shougo/neocomplcache'
    let g:neocomplcache_enable_at_startup = 1
endif

NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config = {
\   '_' : {
\       'outputter/buffer/split' : ':botright 10sp',
\       'outputter/buffer/close_on_empty' : 1,
\       'hook/time/enable' : 1,
\       'runner' : 'vimproc',
\       'runner/vimproc/updatetime' : 500
\   },
\   'markdown' : { 'type' : 'markdown/previm'},
\   'markdown/previm' : {
\       'exec' : ':PrevimOpen',
\       'runner' : 'vimscript',
\       'outputter' : 'null',
\   },
\}

NeoBundle 'glidenote/memolist.vim'
let g:memolist_path = '~/Dropbox/works/Memo'
let g:memolist_memo_date = '%Y-%m-%d %H:%M:%S'
let g:memolist_template_dir_path = '~/vimfiles/misc/memolist_templates'
let g:memolist_qfixgrep = 1

NeoBundle 'vim-scripts/autodate.vim'
let g:autodate_format = '%Y-%m-%d %H:%M:%S'

NeoBundle 'fuenor/qfixgrep'

NeoBundle 'osyo-manga/vim-over'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

NeoBundle 'vim-jp/vimdoc-ja'

NeoBundleCheck

set hlsearch

set cursorline

set scrolloff=1

" backspace deletes fixed letters
set backspace=start,indent

" encoding settings
" fileencodings: for auto-detection
" encoding: internal file encoding
" fileencoding: file encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,sjis,cp932,latin1

set number " show number
set ruler  " show ruler

" tab & indent
" expandtab: instert spaces for tab
" tabstop(ts): width of tab
" softtabstop(sts): inserted number of spaces for tab
" shiftwidth(sw): inserted number of spaces as autoindent 
" autoindent: considering only before line
" smartindent: considering some C syntax
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent

" Entering insert mode or search mode, disable the IME
set iminsert=0 imsearch=0
" don't register IME state for insert-mode
inoremap <silent> <Esc> <Esc>:set iminsert=0<CR>

set backupdir=~/vimfiles/tmp

" to move cursor between the split screen
nnoremap <Left> h
nnoremap <Right> l
nnoremap <Up> k
nnoremap <Down> j

" VimShell
command Vs VimShell
command Vsp VimShellPop


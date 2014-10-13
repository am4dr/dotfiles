scriptencoding utf-8
set nocompatible
filetype off
filetype plugin indent off

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" load neobundle """"""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
	set runtimepath+=~/vimfiles/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/vimfiles/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" syntax  """""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tikhomirov/vim-glsl'

" colorscheme """""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/Wombat'

" colorscheme utility """""""""""""""""""""""""""""""""""""
NeoBundle 'thinca/vim-guicolorscheme'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'vim-scripts/AfterColors.vim'

" other plugins """""""""""""""""""""""""""""""""""""""""""
NeoBundle 'Shougo/vimproc' , {
\   'build' : {
\       'unix' : 'make -f make_unix.mak',
\   },
\}
NeoBundle 'Shougo/unite.vim'
let g:unite_enable_start_insert = 1
NeoBundle 'Shougo/unite-session'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler.vim'
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_time_format = "%m%d %H%M"
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vinarise.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'koron/codic-vim'
NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
\   'colorscheme': 'jellybeans',
\}
if has('lua')
    NeoBundle 'Shougo/neocomplete.vim'
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#auto_completion_start_length = 3
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
let g:previm_enable_realtime = 1
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'gist:amadarain/35ba8308674c6a0a7526', {
\   'name' : 'gtags.vim',
\   'script_type' : 'plugin'
\}
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundleCheck


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Settings                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim internal """"""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
" encoding settings
" fileencodings: for auto-detection
" encoding: internal file encoding
" fileencoding: file encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,sjis,cp932,latin1
set backupdir=~/vimfiles/tmp
" turn off the IM
set iminsert=0
" use the iminsert value for imsearch
set imsearch=-1

" appearance """"""""""""""""""""""""""""""""""""""""""""""
" color
set t_Co=256
set background=dark
colorscheme molokai
syntax on " calls ':filetype on' internally

set ruler
set number
set hlsearch
set cursorline
set scrolloff=1
set laststatus=2
set cmdheight=2

" editting """"""""""""""""""""""""""""""""""""""""""""""""
" backspace deletes fixed letters
set backspace=start,indent
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" shortcut commands                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" escape into normal mode
imap <silent> <C-J> <Esc>
inoremap <silent> <Esc> <Esc>:set iminsert=0<CR>

nnoremap <Left> h
nnoremap <Right> l
nnoremap <Up> k
nnoremap <Down> j

nnoremap [shortcut] <Nop>
nmap <Space> [shortcut]

nmap [shortcut]m [memolist]
nnoremap [memolist] <Nop>
nnoremap [memolist]l :<C-u>MemoList<CR>
nnoremap [memolist]g :<C-u>MemoGrep 
nnoremap [memolist]n :<C-u>MemoNew 

nmap [shortcut]u [unite]
nnoremap [unite] :<C-u>Unite 
nnoremap [unite]f :<C-u>Unite file<CR>
nnoremap [unite]m :<C-u>Unite file_mru<CR>

nmap [shortcut]v [vimshell]
nnoremap [vimshell] :<C-u>VimShell
nnoremap [vimshell]s :<C-u>VimShell<CR>
nnoremap [vimshell]p :<C-u>VimShellPop<CR>
nnoremap [vimshell]b :<C-u>VimShellBufferDir<CR>

nmap [shortcut]o [overvim]
nnoremap [overvim] :<C-u>OverCommandLine<CR>


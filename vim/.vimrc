" neobundle.vim

if has('vim_starting')
    set nocompatible
	set runtimepath+=~/vimfiles/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/vimfiles/bundle/'))

filetype plugin indent on

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
let g:unite_enable_start_insert = 1

NeoBundle 'Shougo/vimfiler.vim'
let g:vimfiler_as_default_explorer = 1

NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vinarise.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'koron/codic-vim'
" syntax
NeoBundle 'beyondmarc/glsl.vim'
" color
NeoBundle 'thinca/vim-guicolorscheme'
NeoBundle 'ujihisa/unite-colorscheme'
" colorschemes
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/Wombat'
set t_Co=256
syntax on
set background=dark
colorscheme molokai

NeoBundle 'Lokaltog/powerline', {'rtp' : 'powerline/bindings/vim'}
set laststatus=2 "need to show

NeoBundle 'Shougo/neocomplcache'
let g:neocomplcache_enable_at_startup = 1

NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config = {
\   "_" : {
\       "outputter/buffer/split" : ":botright 10sp",
\       "outputter/buffer/close_on_empty" : 1,
\       "hook/time/enable" : 1,
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 500
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

NeoBundle 'vim-jp/vimdoc-ja'

NeoBundleCheck

" encoding settings
" fileencodings: for auto-detection
" encoding: internal file encoding
" fileencoding: file encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,sjis,cp932,latin1

" show number
set number

" always display tabs
set showtabline=2

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

" don't leave the buckup files
set backupdir=~/vimfiles/tmp

" to move cursor between the split screen
nmap <Left> h
nmap <Right> l
nmap <Up> k
nmap <Down> j

" VimShell
command Vs VimShell
command Vsp VimShellPop

" gtags
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>
nmap <C-g> :Gtags 
nmap <C-h> :Gtags -f %<CR>
nmap <C-k> :GtagsCursor<CR>

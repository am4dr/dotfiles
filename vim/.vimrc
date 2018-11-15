scriptencoding utf-8
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/vimfiles/vimplug/vim-plug/plug.vim
call plug#begin('~/vimfiles/vimplug')
Plug 'junegunn/vim-plug'

" local plugins """""""""""""""""""""""""""""""""""""""""""
Plug '~/vimfiles/plugin-prototype/editor-action'

" language support """"""""""""""""""""""""""""""""""""""""
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" syntax  """""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }
" colorscheme """""""""""""""""""""""""""""""""""""""""""""
Plug 'AlessandroYorba/Alduin'
Plug 'altercation/vim-colors-solarized'
Plug 'jeetsukumaran/vim-nefertiti'
Plug 'nanotech/jellybeans.vim'
" colorscheme utility """""""""""""""""""""""""""""""""""""
Plug 'ujihisa/unite-colorscheme'
Plug 'vim-scripts/AfterColors.vim'

" other plugins """""""""""""""""""""""""""""""""""""""""""
Plug 'Shougo/unite-session'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/vinarise.vim', { 'on' : 'Vinarise' }
Plug 'editorconfig/editorconfig-vim'
Plug 'glidenote/memolist.vim'
Plug 'itchyny/lightline.vim'
Plug 'kannokanno/previm', { 'for': 'markdown' }
Plug 'osyo-manga/vim-over'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tyru/open-browser.vim'
Plug 'vim-jp/vimdoc-ja'

call plug#end()
delc PlugUpgrade
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin config                                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_fmt_command = "goimports"
let g:unite_enable_start_insert = 1
let g:vimfiler_time_format = "%m%d %H%M"
let g:lightline = {
            \   'active' : {
            \       'left'  : [ ['mode', 'paste'],
            \                   ['readonly', 'filename', 'modified'] ],
            \       'right' : [ ['percent', 'lineinfo'],
            \                   ['filetype'],
            \                   ['fileformat', 'fileencoding'] ],
            \   },
            \   'inactive' : {
            \       'left'  : [ ['filename'] ],
            \       'right' : [ ['percent', 'lineinfo'] ]
            \   },
            \   'component_function' : {
            \       'fileformat' : 'LLFileFormat',
            \       'fileencoding': 'LLFileEncoding',
            \   },
            \   'colorscheme': 'jellybeans',
            \   'mode_map': {
            \      'n' : 'N',
            \      'i' : 'I',
            \      'R' : 'R',
            \      'v' : 'V',
            \      'V' : 'VL',
            \      "\<C-v>" : 'VB',
            \   },
            \   'subseparator' : { 'left' : '', 'right' : '' },
            \}
function! LLFileFormat()
    let ff = &fileformat
    return ff == 'unix' ? 'NL' :
                \ ff == 'dos'  ? 'CN' :
                \ ff == 'mac'  ? 'CR' :
                \ ff
endfunction
function! LLFileEncoding()
    let fe = &fileencoding
    return fe == 'utf-8' ? 'u8' : fe
endfunction

let g:memolist_path = '~/works/memo'
let g:memolist_memo_date = '%Y-%m-%d %H:%M:%S'
let g:memolist_template_dir_path = '~/vimfiles/misc/memolist_templates'
let g:memolist_unite = 1
let g:previm_enable_realtime = 1
let g:quickrun_config = {
            \   '_' : {
            \       'outputter/buffer/split' : ':botright 10sp',
            \       'outputter/buffer/close_on_empty' : 1,
            \       'hook/time/enable' : 1,
            \   },
            \   'markdown' : { 'type' : 'markdown/previm'},
            \   'markdown/previm' : {
            \       'exec' : ':PrevimOpen',
            \       'runner' : 'vimscript',
            \       'outputter' : 'null',
            \   },
            \   'groovy' : {
            \       'type' : 'groovy/groovy',
            \   },
            \   'groovy/groovyserv' : {
            \       'command' : 'groovyclient',
            \   },
            \   'groovy/groovy' : {
            \       'command' : 'groovy',
            \       'cmdopt' : '-c %{&fenc==#""?&enc:&fenc}',
            \   },
            \}

let g:fireplace_no_maps = 1
command! LoadReply runtime reply-terminal.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Settings                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim internal """"""""""""""""""""""""""""""""""""""""""""
" encoding settings
" fileencodings: for auto-detection
" encoding: internal file encoding
" fileencoding: file encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,sjis,cp932,latin1
set fileformats=unix,dos
set backupdir=~/vimfiles/tmp
set directory=~/vimfiles/tmp//
" turn off the IM
set iminsert=0
" use the iminsert value for imsearch
set imsearch=-1

" appearance """"""""""""""""""""""""""""""""""""""""""""""
" color
if &t_Co == 8
    colorscheme delek
else
    set background=dark
    colorscheme jellybeans
endif
" syntax highlighting
let java_highlight_java_lang_ids=1

set ruler
set hlsearch
set scrolloff=1
set laststatus=2
set cmdheight=2
set display+=lastline
set colorcolumn=81
set visualbell

" editting """"""""""""""""""""""""""""""""""""""""""""""""
" backspace deletes fixed letters
set backspace=start,indent
set expandtab       " insert spaces instead of tab
set tabstop=4       " width of tab
set softtabstop=4   " width of expaned tab
set shiftwidth=4    " width of autoindent
set smartindent
inoremap <silent> <C-@> <Nop>
set formatoptions+=mM
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

"  """""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch
set spelllang=en,cjk

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gocha Gocha                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! -nargs=+ -bar ArgsByExtension
            \ execute 'args **/*.' . join([<f-args>], ' **/*.')
command! TimeStamp
            \ execute 'normal "=strftime("%Y-%m-%dT%H:%M:%S")<C-M>P'
command! -nargs=* -bar SilentMake
            \ execute 'silent make ' . join([<f-args>], ' ') . '| redraw!'
command! -nargs=* -bar SilentMakeCwindow
            \ execute 'silent make ' . join([<f-args>], ' ') . '| redraw! | cw'

nnoremap <Leader>mk :SilentMakeCwindow 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mappings                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Left> h
nnoremap <Right> l
nnoremap <Up> k
nnoremap <Down> j

nnoremap [c :<C-u>cprevious<CR>
nnoremap ]c :<C-u>cnext<CR>
nnoremap [C :<C-u>cpfile<CR>
nnoremap ]C :<C-u>cnfile<CR>
nnoremap [fc :<C-u>cfirst<CR>
nnoremap ]lc :<C-u>clast<CR>
nnoremap [l :<C-u>lprevious<CR>
nnoremap ]l :<C-u>lnext<CR>
nnoremap [L :<C-u>lpfile<CR>
nnoremap ]L :<C-u>lnfile<CR>
nnoremap [fl :<C-u>lfirst<CR>
nnoremap ]ll :<C-u>llast<CR>
nnoremap [a :<C-u>previous<CR>
nnoremap ]a :<C-u>next<CR>
nnoremap [fa :<C-u>first<CR>
nnoremap ]la :<C-u>last<CR>

nnoremap M `
nnoremap MM :<c-u>marks abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" shortcut commands                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
nnoremap [unite]r :<C-u>Unite file_rec<CR>
nnoremap [unite]s :<C-u>Unite session<CR>
nnoremap [unite]b :<C-u>Unite buffer<CR>

nmap [shortcut]o [overvim]
nnoremap [overvim] :<C-u>OverCommandLine<CR>

nnoremap [shortcut]zz :<C-u>execute ':save ' . expand('~/ZatsuMemo/' . strftime('%Y-%m%d-%H%M') . '-' . getline('1') . '.txt')<CR>
nnoremap [shortcut]zo :<C-u>execute ':e ' . expand('~/ZatsuMemo/')<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" buffer-local mappings                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <LocalLeader>a  <Plug>(EditorActionEditPeerFile)
nmap <silent> <LocalLeader>ga <Plug>(EditorActionGotoPeerFile)
nmap <silent> <LocalLeader>gt <Plug>(EditorActionGotoTerminal)
nmap <silent> <LocalLeader>rr <Plug>(EditorActionRunFile)
nmap <silent> <LocalLeader>rt <Plug>(EditorActionRunTests)
nmap <silent> <LocalLeader>ee <Plug>(EditorActionEvaluateCursor)
nmap <silent> <LocalLeader>eb <Plug>(EditorActionEvaluateBuffer)

scriptencoding utf-8
set nocompatible
filetype off
filetype plugin indent off

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath^=~/vimfiles/dein/repos/github.com/Shougo/dein.vim
"if dein#load_state(expand('~/vimfiles/dein/'))
call dein#begin(expand('~/vimfiles/dein/'))
call dein#add('Shougo/dein.vim')

" syntax  """""""""""""""""""""""""""""""""""""""""""""""""
call dein#add('tikhomirov/vim-glsl')
call dein#add('scrooloose/syntastic', {
\   'lazy' : 1,
\   'on_cmd' : ['Syntastic']
\})
call dein#add('https://gist.github.com/amadarain/4e6fc1bade7c1add02e5', {
\   'depends' : 'scrooloose/syntastic',
\   'lazy' : 1,
\   'name' : 'syntastic_groovy_groovyc.vim',
\})
" colorscheme """""""""""""""""""""""""""""""""""""""""""""
call dein#add('altercation/vim-colors-solarized')
call dein#add('nanotech/jellybeans.vim')
call dein#add('tomasr/molokai')
call dein#add('vim-scripts/Wombat')
" colorscheme utility """""""""""""""""""""""""""""""""""""
call dein#add('ujihisa/unite-colorscheme')
call dein#add('vim-scripts/AfterColors.vim')

" other plugins """""""""""""""""""""""""""""""""""""""""""
call dein#add('Shougo/vimproc', {'build': 'make'})
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/unite-session')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/vimfiler.vim')
call dein#add('Shougo/vimshell')
call dein#add('Shougo/vinarise.vim')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-fugitive')
call dein#add('koron/codic-vim')
call dein#add('itchyny/lightline.vim')
call dein#add('Shougo/neocomplete.vim', { 'if' : has('lua') })
call dein#add('thinca/vim-quickrun')
call dein#add('glidenote/memolist.vim')
call dein#add('vim-scripts/autodate.vim')
call dein#add('fuenor/qfixgrep')
call dein#add('osyo-manga/vim-over')
call dein#add('kannokanno/previm')
call dein#add('tyru/open-browser.vim')
call dein#add('https://gist.github.com/amadarain/35ba8308674c6a0a7526', {
\   'name' : 'gtags.vim',
\})
call dein#add('rhysd/wandbox-vim')
call dein#add('Shougo/junkfile.vim')
call dein#add('vim-jp/vimdoc-ja')

call dein#end()
"endif " for dein#load_state()
"call dein#save_state()
"if dein#check_install()
"    call dein#install()
"endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin config                                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_java_javac_options = '-J-Dfile.encoding=utf-8'
let g:vimproc#download_windows_dll = 1
let g:unite_enable_start_insert = 1
let g:vimfiler_as_default_explorer = 1
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
        \  ff == 'dos'  ? 'CN' :
        \  ff == 'mac'  ? 'CR' :
        \  ff
endfunction
function! LLFileEncoding()
    let fe = &fileencoding
    return fe == 'utf-8' ? 'u8' : fe
endfunction

let g:memolist_path = '~/works/memo'
let g:memolist_memo_date = '%Y-%m-%d %H:%M:%S'
let g:memolist_template_dir_path = '~/vimfiles/misc/memolist_templates'
let g:memolist_qfixgrep = 1
let g:memolist_unite = 1
let g:autodate_format = '%Y-%m-%d %H:%M:%S'
let g:previm_enable_realtime = 1
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
\   'processing/groovy' : {
\       'command' : 'groovy',
\       'cmdopt' : '-c %{&fenc==#""?&enc:&fenc}',
\       'runner/vimproc/updatetime' : 0,
\       'outputter' : 'null',
\   },
\}
if has('lua')
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_camel_case = 1
    let g:neocomplete#auto_completion_start_length = 7
endif

filetype plugin indent on

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
" turn off the IM
set iminsert=0
" use the iminsert value for imsearch
set imsearch=-1

" appearance """"""""""""""""""""""""""""""""""""""""""""""
" color
set background=dark
if has('win32')
    colorscheme default
else
    set t_Co=256
    colorscheme jellybeans
endif
" syntax highlighting
let java_highlight_java_lang_ids=1
syntax on " calls ':filetype on' internally

if has('win32') && !has('gui_running')
    set nocursorline
else
    set cursorline
endif
set ruler
set number
set hlsearch
set scrolloff=1
set laststatus=2
set cmdheight=2
set display+=lastline
set colorcolumn=81

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gocha Gocha                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" this command does not handle import errors yet
function! s:useGradleAsMakeprg()
    set makeprg=gradle\ --daemon\ --quiet
    let &errorformat = ''
        \   . '%f: %l: %\%%([Static type checking] - %\)%\=%m @%.%#column %c.,'
        \   . '%E%f: %l: %\%%([Static type checking] - %\)%\=%m,'
        \   . '%-Z @ line %l%\, column %c.,'
        \   . '%-Gstartup failed:,'
        \   . '%+G  %.%#,'
        \   . '%-G,'
        \   . '%-G%.%#,'
endfunction
command! -nargs=0 UseGradle call s:useGradleAsMakeprg()

function! s:args_by_extention(...) range abort
    execute 'args **/*.' . join(a:000, ' **/*.')
endfunction
command! -nargs=+ -bar ArgsByExtension
\   execute 'args **/*.' . join([<f-args>], ' **/*.')
command! TimeStamp execute 'normal "=strftime("%Y-%m-%dT%H:%M:%S")<C-M>P'
command! -nargs=* -bar SilentMake
\   execute 'silent make ' . join([<f-args>], ' ') . '| redraw!'
command! -nargs=* -bar SilentMakeCwindow
\   execute 'silent make ' . join([<f-args>], ' ') . '| redraw! | cw'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" shortcut commands                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" escape into normal mode
nmap <silent> <C-j> <Esc>
imap <silent> <C-j> <Esc>

nnoremap <Left> h
nnoremap <Right> l
nnoremap <Up> k
nnoremap <Down> j

nnoremap <Leader>mk :SilentMakeCwindow 

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
nnoremap [unite]m :<C-u>Unite file_mru<CR>
nnoremap [unite]s :<C-u>Unite session<CR>
nnoremap [unite]b :<C-u>Unite buffer<CR>

nmap [shortcut]v [vimshell]
nnoremap [vimshell] :<C-u>VimShell
nnoremap [vimshell]s :<C-u>VimShell<CR>
nnoremap [vimshell]p :<C-u>VimShellPop<CR>
nnoremap [vimshell]b :<C-u>VimShellBufferDir<CR>

nmap [shortcut]o [overvim]
nnoremap [overvim] :<C-u>OverCommandLine<CR>

nmap [shortcut]s [syntastic]
nnoremap [syntastic]c :<C-u>SyntasticCheck<CR>
nnoremap [syntastic]t :<C-u>SyntasticToggleMode<CR>

nnoremap [shortcut]zz :<C-u>execute ':save ' . expand('~/ZatsuMemo/' . strftime('%Y-%m%d-%H%M') . '-' . getline('1') . '.txt')<CR>

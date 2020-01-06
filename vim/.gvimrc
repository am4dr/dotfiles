scriptencoding utf-8
if filereadable(expand('~/.gvimrc_local'))
    source ~/.gvimrc_local
endif

colorscheme nefertiti
set guioptions-=m   " メニュー非表示
set guioptions-=T   " ツールバー非表示
set guioptions-=l   " スクロールバーの非表示(常に左)
set guioptions-=L   " スクロールバーの非表示(分割時のみ左)
set guioptions-=r   " スクロールバーの非表示(常に右)
set guioptions-=R   " スクロールバーの非表示(分割時のみ右)
set guioptions-=e   " タブをCUI風に

set t_vb=

inoremap <silent> <Esc> <Esc>:set iminsert=0<CR>

" https://github.com/chriskempson/base16-vim/blob/master/colors/base16-default-dark.vim
let g:terminal_ansi_colors = [
            \ "#181818",
            \ "#ab4642",
            \ "#a1b56c",
            \ "#f7ca88",
            \ "#7cafc2",
            \ "#ba8baf",
            \ "#86c1b9",
            \ "#d8d8d8",
            \ "#585858",
            \ "#ab4642",
            \ "#a1b56c",
            \ "#f7ca88",
            \ "#7cafc2",
            \ "#ba8baf",
            \ "#86c1b9",
            \ "#f8f8f8",
            \ ]

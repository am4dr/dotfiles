if filereadable(expand('~/.gvimrc_local'))
    source ~/.gvimrc_local
endif

colorscheme alduin
set guioptions-=m   " メニュー非表示
set guioptions-=T   " ツールバー非表示
set guioptions-=l   " スクロールバーの非表示(常に左)
set guioptions-=L   " スクロールバーの非表示(分割時のみ左)
set guioptions-=r   " スクロールバーの非表示(常に右)
set guioptions-=R   " スクロールバーの非表示(分割時のみ右)
set guioptions-=e   " タブをCUI風に

@echo off

set DF_DIR=%HOME%\dotfiles
set LINK_FILES=.gitconfig .global_ignore .vimrc .gvimrc .conkyrc .Xmodmap .tmux.conf .vimshrc .config\git\attributes
set LINK_DIRS=vimfiles .emacs.d
set LINK_TARGET=git vim emacs

rem mode selection
if "%1" == "" call :usage
if "%1" == "init" call :init
if "%1" == "link" call :link
if "%1" == "clean" call :clean
exit /b

rem ---------- subroutines ----------
:usage
echo win [init link clean]
exit /b

:init
mkdir vim\bundle
git clone https://github.com/Shougo/neobundle.vim vim/bundle/neobundle.vim
exit /b

:link
for %%i in (%LINK_TARGET%) do (
    echo link %%i
    if "%%i" == "git" call :git
    if "%%i" == "vim" call :vim
    if "%%i" == "emacs" call :emacs
    if "%%i" == "conky" call :conky
    if "%%i" == "xmodmap" call :xmodmap
    if "%%i" == "tmux" call :tmux
)
exit /b

:clean
pushd %HOME%
del /P %LINK_FILES%
for %%i in (%LINK_DIRS%) do (
    echo rmdir %%i
    rmdir %%i
)
popd
exit /b

rem ----------- link rules -----------
:git
mklink %HOME%\.gitconfig %DF_DIR%\git\gitconfig
mklink %HOME%\.global_ignore %DF_DIR%\git\global_ignore
mkdir %HOME%\.config\git
mklink %HOME%\.config\git\attributes %DF_DIR%\git\attributes
exit /b

:vim
mklink %HOME%\.vimrc %DF_DIR%\vim\.vimrc
mklink %HOME%\.gvimrc %DF_DIR%\vim\.gvimrc
mklink %HOME%\.vimshrc %DF_DIR%\vim\.vimshrc
mklink /D %HOME%\vimfiles %DF_DIR%\vim
exit /b

:emacs
mklink /D %HOME%\.emacs.d %DF_DIR%\emacs.d
exit /b

:conky
:xmodmap
:tmux
echo stab: link conky, xmodmap, tmux
exit /b

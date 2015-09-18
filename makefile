
DF_DIR = $(HOME)/dotfiles
TARGET = .gitconfig .global_ignore .vimrc .gvimrc .conkyrc .Xmodmap .tmux.conf .vimshrc .config/git/attributes
TARGET_DIR = vimfiles .emacs.d .vim

# link
#   make links or copies for each dotfiles
link: _git _vim _emacs _conky _xmodmap _tmux

# initialize
init:
	mkdir -p vim/bundle
	git clone https://github.com/Shougo/neobundle.vim vim/bundle/neobundle.vim

clean:
	pushd $(HOME)
	rm -f $(TARGET)
	rm -f $(TARGET_DIR)
	popd

# update setting files
_git:
	ln -vs $(DF_DIR)/git/gitconfig $(HOME)/.gitconfig
	ln -vs $(DF_DIR)/git/global_ignore $(HOME)/.global_ignore
	mkdir -p $(HOME)/.config/git
	ln -vs $(DF_DIR)/git/attributes $(HOME)/.config/git/attributes

_vim:
	ln -vs $(DF_DIR)/vim/.vimrc $(HOME)/.vimrc
	ln -vs $(DF_DIR)/vim/.gvimrc $(HOME)/.gvimrc
	ln -vs $(DF_DIR)/vim/.vimshrc $(HOME)/.vimshrc
	ln -vs $(DF_DIR)/vim $(HOME)/.vim
	ln -vs $(DF_DIR)/vim $(HOME)/vimfiles

_emacs:
	ln -vs $(DF_DIR)/emacs.d $(HOME)/.emacs.d

_conky:
	ln -vs $(DF_DIR)/.conkyrc $(HOME)/.conkyrc

_xmodmap:
	ln -vs $(DF_DIR)/.Xmodmap $(HOME)/.Xmodmap

_tmux:
	ln -vs $(DF_DIR)/.tmux.conf $(HOME)/.tmux.conf

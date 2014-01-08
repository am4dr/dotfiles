
DF_DIR = $(HOME)/dotfiles
TARGET = .gitconfig .global_ignore .vimrc .gvimrc .conkyrc .Xmodmap .tmux.conf
TARGET_DIR = vimfiles .emacs.d

# link
#   make links or copies for each dotfiles
link: _git _vim _emacs _conky _xmodmap _tmux

# initialize
#   setup the submodules and update-script
#   run after `git clone /path/to/dotfiles.git`
init: 
	git submodule init
	git submodule update
	@echo 'please build the submodules!'

clean:
	cd $(HOME)
	rm -f $(TARGET)
	rmdir $(TARGET_DIR)

# update setting files
_git:
	ln -vs $(DF_DIR)/git/gitconfig $(HOME)/.gitconfig
	ln -vs $(DF_DIR)/git/global_ignore $(HOME)/.global_ignore

_vim:
	ln -vs $(DF_DIR)/vim/.vimrc $(HOME)/.vimrc
	ln -vs $(DF_DIR)/vim/.gvimrc $(HOME)/.gvimrc
	ln -vs $(DF_DIR)/vimfiles $(HOME)/.vim

_emacs:
	ln -vs $(DF_DIR)/emacs.d $(HOME)/.emacs.d

_conky:
	ln -vs $(DF_DIR)/.conkyrc $(HOME)/.conkyrc

_xmodmap:
	ln -vs $(DF_DIR)/.Xmodmap $(HOME)/.Xmodmap

_tmux:
	ln -vs $(DF_DIR)/.tmux.conf $(HOME)/.tmux.conf

DOTFILES = $(PWD)
all:: vim emacs bin tmux bash

vim::
	@ln -fs $(DOTFILES)/vim/vimrc    			${HOME}/.vimrc
	@ln -fns $(DOTFILES)/vim         			${HOME}/.vim
	@echo Vim is symlinked.

emacs::
	@ln -fns $(DOTFILES)/emacs   					${HOME}/.emacs.d
	@echo Emacs is symlinked.

bin::
	@ln -fns $(DOTFILES)/bin							${HOME}/bin
	@echo bin files are linked to homedir.

tmux::
	@ln -fs $(DOTFILES)/tmux/tmux.conf 		${HOME}/.tmux.conf
	@echo tmux is symlinked.

bash::
	@ln -fs $(DOTFILES)/bash/bash_profile	${HOME}/.bash_profile
	@ln -fs $(DOTFILES)/bash/bashrc				${HOME}/.bashrc
	@echo bash is symlinked.

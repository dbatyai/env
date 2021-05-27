.PHONY: help
help:
	@echo "Available targets:"
	@grep -o '^[a-z]*:' Makefile

.PHONY: terminal
terminal: rcfiles git vim gnome-profile

.PHONY: desktop
desktop: terminal i3 x11

.PHONY: rcfiles
rcfiles:
	@ln -srfv bashrc ~/.bashrc
	@ln -srfv bash_profile ~/.bash_profile
	@ln -srfv inputrc ~/.inputrc
	@ln -srfv nanorc ~/.nanorc
	@ln -srfv vimrc ~/.vimrc
	@ln -srfv screenrc ~/.screenrc

.PHONY: git
git:
	@ln -srfv gitconfig ~/.gitconfig
	@ln -srfnv git-template ~/.git-template

.PHONY: vim
vim: rcfiles
	@test -d ~/.vim/bundle/Vundle.vim || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	@vim +PluginInstall +qall
	@ln -srfv vim/lightlinecolors.vim ~/.vim/bundle/lightline.vim/autoload/lightline/colorscheme/lightlinecolors.vim
	@mkdir -p ~/.vim/after
	@ln -srfnv vim/after/syntax ~/.vim/after/syntax

.PHONY: gnome-profile
gnome-profile:
	@dconf load /org/gnome/terminal/legacy/profiles:/ < terminal-profile.dconf

.PHONY: i3
i3:
	@mkdir -p ~/.config/i3
	@mkdir -p ~/.config/i3status
	@ln -srv i3.conf ~/.config/i3/config
	@ln -srv i3status.conf ~/.config/i3status/config

.PHONY: x11
x11:
	@sudo mkdir -p /etc/X11/xinit
	@sudo ln -srbv xinitrc /etc/X11/xinit/xinitrc
	@sudo ln -srbv xserverrc /etc/X11/xinit/xserverrc
	@sudo ln -srbv Xresources /etc/X11/xinit/.Xresources
	@sudo ln -srbv Xresources /etc/X11/Xresources
	@sudo cp -v xorg-conf/* /etc/X11/xorg.conf.d/


.PHONY: basic
basic: bashrc bash_profile gitconfig inputrc nanorc vimrc screenrc

.PHONY: all
all: basic i3 xinit

.PHONY: bashrc
bashrc:
	@ln -srbv bashrc ~/.bashrc

.PHONY: bash_profile
bash_profile:
	@ln -srbv bash_profile ~/.bash_profile

.PHONY: gitconfig
gitconfig:
	@ln -srbv gitconfig ~/.gitconfig

.PHONY: inputrc
inputrc:
	@ln -srbv inputrc ~/.inputrc

.PHONY: nanorc
nanorc:
	@ln -srbv nanorc ~/.nanorc

.PHONY: vimrc
vimrc:
	@ln -srbv vimrc ~/.vimrc

.PHONY: screenrc
screenrc:
	@ln -srbv screenrc ~/.screenrc

.PHONY: i3
i3:
	@mkdir -p ~/.config/i3
	@mkdir -p ~/.config/i3status
	@ln -srbv i3.conf ~/.config/i3/config
	@ln -srbv i3status.conf ~/.config/i3status/config

.PHONY: x11
x11:
	@sudo mkdir -p /etc/X11/xinit
	@sudo ln -srbv xinitrc /etc/X11/xinit/xinitrc
	@sudo ln -srbv xserverrc /etc/X11/xinit/xserverrc
	@sudo ln -srbv Xresources /etc/X11/xinit/.Xresources
	@sudo ln -srbv Xresources /etc/X11/Xresources
	@sudo cp -v xorg-conf/* /etc/X11/xorg.conf.d/

.PHONY: gnome-profile
gnome-profile:
	@dconf load /org/gnome/terminal/legacy/profiles:/ < terminal-profile.dconf

.PHONY: vundle
vundle:
	@git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

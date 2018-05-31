.PHONY: basic
basic: bashrc bash_profile gitconfig inputrc nanorc vimrc screenrc

.PHONY: all
all: basic i3 xinit

.PHONY: bashrc
bashrc:
	@ln -srfv .bashrc ~/

.PHONY: bash_profile
bash_profile:
	@ln -srfv .bash_profile ~/

.PHONY: gitconfig
gitconfig:
	@ln -srfv .gitconfig ~/

.PHONY: inputrc
inputrc:
	@ln -srfv .inputrc ~/

.PHONY: nanorc
nanorc:
	@ln -srfv .nanorc ~/

.PHONY: vimrc
vimrc:
	@ln -srfv .vimrc ~/

.PHONY: screenrc
screenrc:
	@ln -srfv .screenrc ~/

.PHONY: i3
i3:
	@mkdir -p ~/.config/i3
	@mkdir -p ~/.config/i3status
	@ln -srfv i3.conf ~/.config/i3/config
	@ln -srfv i3status.conf ~/.config/i3status/config

.PHONY: xinit
xinit:
	@sudo mkdir -p /etc/X11/xinit
	@sudo ln -srfv xinitrc /etc/X11/xinit/xinitrc
	@sudo ln -srfv xserverrc /etc/X11/xinit/xserverrc
	@sudo ln -srfv .Xresources /etc/X11/xinit/.Xresources
	@sudo ln -srfv .Xresources /etc/X11/Xresources

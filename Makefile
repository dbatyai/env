define link
	@test -L $2 || ln -srfbnv $1 $2
endef

define slink
	@test -L $2 || sudo ln -srfbnv $1 $2
endef

.PHONY: help
help:
	@echo "Available targets:"
	@grep -o '^[a-z0-9]*:' Makefile

.PHONY: terminal
terminal: rcfiles etc git vim ycm

.PHONY: desktop
desktop: i3 x11 kitty

.PHONY: rcfiles
rcfiles:
	$(call link, bashrc, ~/.bashrc)
	$(call link, bash_profile, ~/.bash_profile)
	$(call link, inputrc, ~/.inputrc)
	$(call link, nanorc, ~/.nanorc)
	$(call link, screenrc, ~/.screenrc)

.PHONY: etc
etc:
	$(call slink, pacman.conf, /etc/pacman.conf)

.PHONY: git
git:
	$(call link, gitconfig, ~/.gitconfig)
	$(call link, git-template, ~/.git-template)
	@sh git-user.sh

.PHONY: vim
vim:
	$(call link, vimrc, ~/.vimrc)
	$(call link, vim/lightlinecolors.vim, \
							  ~/.vim/bundle/lightline.vim/autoload/lightline/colorscheme/lightlinecolors.vim)
	@mkdir -p ~/.vim/after
	$(call link, vim/after/syntax, ~/.vim/after/syntax)
	@test -d ~/.vim/bundle/Vundle.vim || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	@vim +PluginInstall +qall

.PHONE: ycm
ycm:
	@python3 ~/.vim/bundle/YouCompleteMe/install.py --clangd-completer

.PHONY: kitty
kitty:
	@mkdir -p ~/.config/kitty
	$(call link, kitty.conf, ~/.config/kitty/kitty.conf)

.PHONY: i3
i3:
	@mkdir -p ~/.config/i3
	@mkdir -p ~/.config/i3status
	@mkdir -p ~/.config/dunst
	$(call link, i3.conf, ~/.config/i3/config)
	$(call link, i3status.conf, ~/.config/i3status/config)
	$(call link, dunstrc, ~/.config/dunst/dunstrc)
	$(call link, lock.sh, ~/.lock.sh)

.PHONY: x11
x11:
	@sudo mkdir -p /etc/X11/xinit
	$(call slink, xinitrc, /etc/X11/xinit/xinitrc)
	$(call slink, xserverrc, /etc/X11/xinit/xserverrc)
	@sudo cp -v xorg-conf/* /etc/X11/xorg.conf.d/

.PHONY: yay
yay:
	@mkdir -p ~/.config/yay
	$(call link, yay.json, ~/.config/yay/config.json)
	@git clone https://aur.archlinux.org/yay /tmp/yay
	@cd /tmp/yay && yes | makepkg -sircC

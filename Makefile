# Create a symlink if target is not yet a link, backing up the original
define link
	@test ! -e $2 -o -L $2 || cp $2 $2.save
	@ln -sfnvT `readlink -f $1` $2
endef

# Install target file to a destination, unless the destination is newer
define install
	@cp -buv $1 $2
endef

.PHONY: help
help: ## print this help message
	@echo "Usage: make TARGET..."
	@echo ""
	@echo "Available targets:"
	@sed -n 's/^\(\w*\):.*##\(.*\)/\1: \2/p' Makefile | column -t -s ':'

.PHONY: user
user: rcfiles git vim ycm kitty yay ## install user specific configs

.PHONY: desktop
desktop: i3 x11 kitty ## config files for desktop usage

.PHONY: rcfiles
rcfiles: ## common rc files in $HOME
	$(call link, config/ackrc, ~/.ackrc)
	$(call link, config/bashrc, ~/.bashrc)
	$(call link, config/bash_profile, ~/.bash_profile)
	$(call link, config/inputrc, ~/.inputrc)
	$(call link, config/nanorc, ~/.nanorc)
	$(call link, config/screenrc, ~/.screenrc)
	$(call link, config/zshrc, ~/.zshrc)

.PHONY: git
git: ## git config and template
	$(call link, git/gitconfig, ~/.gitconfig)
	$(call link, git/git-template, ~/.git-template)
	@test -f ~/.git-user || sh git/git-user.sh

.PHONY: vim
vim: ## vim config, colorscheme, syntax highlight and plugins
	@mkdir -p ~/.vim/after
	@mkdir -p ~/.vim/bundle
	@test -d ~/.vim/bundle/Vundle.vim || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	$(call link, vim/vimrc, ~/.vimrc)
	$(call link, vim/colors, ~/.vim/colors)
	$(call link, vim/after/syntax, ~/.vim/after/syntax)
	@vim +PluginInstall +qall
	$(call link, vim/lightlinecolors.vim, \
        ~/.vim/bundle/lightline.vim/autoload/lightline/colorscheme/lightlinecolors.vim)

.PHONY: ycm
ycm: vim ## install ycm completer
	@vim +PluginUpdate +qall
	@python3 ~/.vim/bundle/YouCompleteMe/install.py --clangd-completer

.PHONY: kitty
kitty: ## kitty terminal config and screen terminfo
	@mkdir -p ~/.config/kitty
	$(call link, config/kitty.conf, ~/.config/kitty/kitty.conf)
	@tic util/screen.xterm-kitty.terminfo

.PHONY: yay
yay: ## install yay pacman wrapper
	@mkdir -p ~/.config/yay
	$(call link, config/yay.json, ~/.config/yay/config.json)
	@git clone https://aur.archlinux.org/yay /tmp/yay
	@cd /tmp/yay && yes | makepkg -sircC

.PHONY: i3
i3: ## i3 and dunst config files
	@mkdir -p ~/.config/i3
	@mkdir -p ~/.config/i3status
	@mkdir -p ~/.config/dunst
	$(call link, i3/i3.conf, ~/.config/i3/config)
	$(call link, i3/i3status.conf, ~/.config/i3status/config)
	$(call link, i3/lock.sh, ~/.lock.sh)
	$(call link, config/dunstrc, ~/.config/dunst/dunstrc)

.PHONY: x11
x11: root ## x11 config files
	@mkdir -p /etc/X11/xinit
	$(call link, x11/xinitrc, /etc/X11/xinit/xinitrc)
	$(call link, x11/xserverrc, /etc/X11/xinit/xserverrc)
	$(call install, x11/xorg-conf/*, /etc/X11/xorg.conf.d/)

.PHONY: etc
etc: root ## config files in /etc
	$(call link, etc/pacman.conf, /etc/pacman.conf)

.PHONY: grub
grub: root ## install grub config
	$(call link, etc/grub, /etc/default/grub)

.PHONY: root
root:
	@if ! [ "$(shell id -u)" = 0 ]; then echo "This target requires root priviledge"; exit 1; fi

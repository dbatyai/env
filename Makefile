# Create a symlink if target is not yet a link, backing up the original
define link
	@test -L $2 || ln -sfbnvT `readlink -f $1` $2
endef

# Same as link, but with root priviledge
define slink
	@test -L $2 || sudo ln -sfbnvT `readlink -f $1` $2
endef

.PHONY: help
help: ## print this help message
	@echo "Usage: make TARGET..."
	@echo ""
	@echo "Available targets:"
	@sed -n 's/^\(\w*\):.*##\(.*\)/\1: \2/p' Makefile | column -t -s ':'

.PHONY: terminal
terminal: rcfiles etc git vim ycm ## config files for remote/terminal usage

.PHONY: desktop
desktop: i3 x11 kitty ## config files for desktop usage

.PHONY: rcfiles
rcfiles: ## common rc files in $HOME
	$(call link, bashrc, ~/.bashrc)
	$(call link, bash_profile, ~/.bash_profile)
	$(call link, inputrc, ~/.inputrc)
	$(call link, nanorc, ~/.nanorc)
	$(call link, screenrc, ~/.screenrc)
	$(call link, zshrc, ~/.zshrc)

.PHONY: etc
etc: ## config files in /etc
	$(call slink, pacman.conf, /etc/pacman.conf)

.PHONY: git
git: ## git config and template
	$(call link, gitconfig, ~/.gitconfig)
	$(call link, git-template, ~/.git-template)
	@test -f ~/.git-user || sh git-user.sh

.PHONY: vim
vim: ## vim config, colorscheme, syntax highlight and plugins
	@mkdir -p ~/.vim/after
	@mkdir -p ~/.vim/bundle
	@test -d ~/.vim/bundle/Vundle.vim || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	$(call link, vimrc, ~/.vimrc)
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
	$(call link, kitty.conf, ~/.config/kitty/kitty.conf)
	@sudo tic screen.xterm-kitty.terminfo

.PHONY: i3
i3: ## i3 and dunst config files
	@mkdir -p ~/.config/i3
	@mkdir -p ~/.config/i3status
	@mkdir -p ~/.config/dunst
	$(call link, i3.conf, ~/.config/i3/config)
	$(call link, i3status.conf, ~/.config/i3status/config)
	$(call link, dunstrc, ~/.config/dunst/dunstrc)
	$(call link, lock.sh, ~/.lock.sh)

.PHONY: x11
x11: ## x11 config files
	@sudo mkdir -p /etc/X11/xinit
	$(call slink, xinitrc, /etc/X11/xinit/xinitrc)
	$(call slink, xserverrc, /etc/X11/xinit/xserverrc)
	@sudo cp -v xorg-conf/* /etc/X11/xorg.conf.d/

.PHONY: yay
yay: ## install yay pacman wrapper
	@mkdir -p ~/.config/yay
	$(call link, yay.json, ~/.config/yay/config.json)
	@git clone https://aur.archlinux.org/yay /tmp/yay
	@cd /tmp/yay && yes | makepkg -sircC

.PHONY: grub
grub: ## install grub config
	$(call slink, grub, /etc/default/grub)

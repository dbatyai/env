# Create a symlink if target is not yet a link, backing up the original
define link
	@test ! -e $2 || test -L $2 || cp $2 $2~
	@ln -sfvT `readlink -f $1` $2
endef

# Install target file to a destination, unless the destination is newer
define install
	@cmp -s $1 $2 || cp -buv $1 $2
endef

# Install target file to destination, replacing if present
define copy
	@cmp -s $1 $2 || cp -v $1 $2
endef

# Append line to file if it not yet contains it
define append
	@test -e $1 && grep -Fqx $2 $1 || echo $2 >> $1
endef

.PHONY: help
help: ## print this help message
	@echo "Usage: make TARGET..."
	@echo ""
	@echo "Available targets:"
	@sed -n 's/^\([[:alnum:]-]*\):.*##\(.*\)/\1: \2/p' Makefile | column -t -s ':'

.PHONY: user
user: rcfiles git vim ycm kitty yay ## install user specific configs

.PHONY: rcfiles
rcfiles: ## common rc files in $HOME
	$(call link, config/bashrc, ~/.bashrc)
	$(call link, config/bash_profile, ~/.bash_profile)
	$(call link, config/inputrc, ~/.inputrc)
	$(call link, config/nanorc, ~/.nanorc)
	$(call link, config/screenrc, ~/.screenrc)
	$(call link, config/tmux.conf, ~/.tmux.conf)
	$(call link, config/zshrc, ~/.zshrc)

.PHONY: git
git: ## git config and template
	$(call link, git/gitconfig, ~/.gitconfig)
	$(call link, git/git-template, ~/.git-template)
	$(call link, git/ctags-hook, ~/.ctags-hook)
	@test -f ~/.git-user || sh git/git-user.sh

.PHONY: vim-config
vim-config: ## vim config, colorscheme, syntax highlight
	@mkdir -p ~/.vim/after
	@mkdir -p ~/.vim/colors
	$(call link, vim/vimrc, ~/.vimrc)
	$(call link, vim/obscure.vim, ~/.vim/colors/obscure.vim)
	$(call link, vim/after/syntax, ~/.vim/after/syntax)

.PHONY: vim-plugins
vim-plugins: vim-config ## vim plugins
	@mkdir -p ~/.vim/bundle
	@test -d ~/.vim/bundle/Vundle.vim || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	@vim +PluginInstall +qall
	$(call link, vim/lightlinecolors.vim, \
        ~/.vim/bundle/lightline.vim/autoload/lightline/colorscheme/lightlinecolors.vim)

.PHONY: ycm
ycm: vim-plugins ## install ycm completer
	@vim +PluginUpdate +qall
	@python3 ~/.vim/bundle/YouCompleteMe/install.py --clangd-completer

.PHONY: vim
vim: vim-config vim-plugins ycm ## everything vim related

.PHONY: nvim
nvim: vim ## neovim config
	@mkdir -p ~/.config/nvim
	$(call link, config/nvim.vim, ~/.config/nvim/init.vim)

.PHONY: alacritty
alacritty: ## alacritty terminal config
	@mkdir -p ~/.config/alacritty
	$(call link, config/alacritty.yml, ~/.config/alacritty/alacritty.yml)

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

.PHONY: sway
sway: i3status ## sway and mako config files
	@mkdir -p ~/.config/sway/config.d
	@mkdir -p ~/.config/mako
	$(call link, sway/config, ~/.config/sway/config)
	$(call link, config/mako, ~/.config/mako/config)
	$(call install, sway/config.d/10-monitor.conf, ~/.config/sway/config.d/10-monitor.conf)
	$(call install, sway/config.d/20-input.conf, ~/.config/sway/config.d/20-input.conf)
	$(call install, sway/config.d/30-idle.conf, ~/.config/sway/config.d/30-idle.conf)
	$(call install, sway/config.d/40-mako.conf, ~/.config/sway/config.d/40-mako.conf)
	$(call copy, sway/displayrc, ~/.displayrc)

.PHONY: i3status
i3status: ## i3status config
	@mkdir -p ~/.config/i3status
	$(call link, config/i3status.conf, ~/.config/i3status/config)

.PHONY: i3
i3: i3status ## i3 and dunst config files
	@mkdir -p ~/.config/i3
	@mkdir -p ~/.config/i3status
	@mkdir -p ~/.config/dunst
	$(call link, i3/config, ~/.config/i3/config)
	$(call link, config/dunstrc, ~/.config/dunst/dunstrc)
	$(call link, i3/lock.sh, ~/.lock.sh)
	$(call copy, i3/displayrc, ~/.displayrc)

.PHONY: x11
x11: root ## x11 config files
	@mkdir -p /etc/X11/xinit
	$(call install, x11/xinitrc, /etc/X11/xinit/xinitrc)
	$(call install, x11/xserverrc, /etc/X11/xinit/xserverrc)
	$(call install, x11/xorg-conf/00-keyboard.conf, /etc/X11/xorg.conf.d/00-keyboard.conf)
	$(call install, x11/xorg-conf/10-monitor.conf, /etc/X11/xorg.conf.d/10-monitor.conf)
	$(call install, x11/xorg-conf/20-mouse.conf, /etc/X11/xorg.conf.d/20-mouse.conf)

.PHONY: etc
etc: pacman network grub ## config files in /etc

.PHONY: pacman
pacman: root ## pacman config
	$(call install, etc/pacman.conf, /etc/pacman.conf)

.PHONY: network
network: root ## systemd-networkd config
	$(call install, etc/network/20-wired.network, /etc/systemd/network/20-wired.network)
	$(call install, etc/network/25-wireless.network, /etc/systemd/network/25-wireless.network)

.PHONY: grub
grub: root ## install grub config
	$(call install, etc/grub, /etc/default/grub)

.PHONY: zram
zram: root ## zram config
	@sh etc/zram-rule.sh /etc/udev/rules.d/99-zram.rules
	$(call append, /etc/modules-load.d/zram.conf, "zram")
	$(call append, /etc/fstab, "/dev/zram0 none swap sw 0 0")
	@modprobe zram && sleep 0.5 && swapon -a # sleep is needed to allow udev to initialize device

.PHONY: root
root:
	@if ! [ "$(shell id -u)" = 0 ]; then echo "This target requires root priviledge"; exit 1; fi

XDG_CONFIG_HOME ?= ~/.config

# Create a symlink if target is not yet a link, backing up the original
ifndef HARDCOPY
define link
	@mkdir -p `dirname $2`
	@test ! -e $2 || test -L $2 || cp $2 $2~
	@ln -sfvT `readlink -f $1` $2
endef
else
define link
	@mkdir -p `dirname $2`
	@test ! -e $2 || test -d $2 || cmp -s $1 $2 || cp $2 $2~
	@test ! -L $2 || unlink $2
	@cp -vTr `readlink -f $1` $2
endef
endif

# Install target file to a destination, unless the destination is newer
define install
	@mkdir -p `dirname $2`
	@cmp -s $1 $2 || cp -buv $1 $2
endef

# Install target file to destination, replacing if present
define copy
	@mkdir -p `dirname $2`
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
user: config git vim ycm yay ## install user specific configs

.PHONY: config
config: ## common rc files in $HOME
	$(call link, config/bashrc, ~/.bashrc)
	$(call link, config/profile, ~/.profile)
	$(call link, config/inputrc, ~/.inputrc)
	$(call link, config/screenrc, ~/.screenrc)
	$(call link, config/tmux.conf, ${XDG_CONFIG_HOME}/tmux/tmux.conf)

.PHONY: nano
nano: ## nano config
	$(call link, config/nanorc, ~/.nanorc)

.PHONY: git
git: ## git config and template
	$(call link, git/gitconfig, ${XDG_CONFIG_HOME}/git/config)
	$(call link, git/git-template, ${XDG_CONFIG_HOME}/git/git-template)
	$(call link, git/ctags-hook, ${XDG_CONFIG_HOME}/git/ctags-hook)
	@test -f ${XDG_CONFIG_HOME}/git/git-user || sh git/git-user.sh

.PHONY: vim
vim: ## vim config, colorscheme, syntax highlight
	$(call link, vim/vimrc, ~/.vim/vimrc)
	$(call link, vim/obscure.vim, ~/.vim/colors/obscure.vim)
	$(call link, vim/after/syntax, ~/.vim/after/syntax)
	@curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.PHONY: nvim
nvim: vim ## neovim config
	$(call link, config/nvim.vim, ${XDG_CONFIG_HOME}/nvim/init.vim)

.PHONY: alacritty
alacritty: ## alacritty terminal config
	$(call link, config/alacritty.yml, ${XDG_CONFIG_HOME}/alacritty/alacritty.yml)

.PHONY: kitty
kitty: ## kitty terminal config and screen terminfo
	$(call link, config/kitty.conf, ${XDG_CONFIG_HOME}/kitty/kitty.conf)

.PHONY: yay
yay: ## install yay pacman wrapper
	$(call link, config/yay.json, ${XDG_CONFIG_HOME}/yay/config.json)
	@rm -rf /tmp/yay
	@git clone https://aur.archlinux.org/yay /tmp/yay
	@cd /tmp/yay && yes | makepkg -sircC

.PHONY: sway
sway: i3status ## sway and mako config files
	$(call link, sway/config, ${XDG_CONFIG_HOME}/sway/config)
	$(call link, config/mako, ${XDG_CONFIG_HOME}/mako/config)
	$(call install, sway/config.d/output.conf, ${XDG_CONFIG_HOME}/sway/config.d/output.conf)
	$(call install, sway/config.d/input.conf, ${XDG_CONFIG_HOME}/sway/config.d/input.conf)
	$(call install, sway/config.d/idle.conf, ${XDG_CONFIG_HOME}/sway/config.d/idle.conf)
	$(call install, sway/config.d/mako.conf, ${XDG_CONFIG_HOME}/sway/config.d/mako.conf)
	$(call copy, sway/desktoprc, ${XDG_CONFIG_HOME}/desktoprc)

.PHONY: i3status
i3status: ## i3status config
	$(call link, i3status/i3status.conf, ${XDG_CONFIG_HOME}/i3status/config)
	$(call install, i3status/i3status.sh, ${XDG_CONFIG_HOME}/i3status/i3status.sh)
	$(call install, i3status/i3status-setup.service, ${XDG_CONFIG_HOME}/systemd/user/i3status-setup.service)
	@systemctl --user daemon-reload
	@systemctl --user enable i3status-setup.service

.PHONY: i3
i3: i3status ## i3 and dunst config files
	$(call link, i3/config, ${XDG_CONFIG_HOME}/i3/config)
	$(call link, config/dunstrc, ${XDG_CONFIG_HOME}/dunst/dunstrc)
	$(call link, i3/lock.sh, ~/.lock.sh)
	$(call copy, i3/desktoprc, ${XDG_CONFIG_HOME}/desktoprc)

.PHONY: x11
x11: root ## x11 config files
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
	$(call install, etc/network/wired.network, /etc/systemd/network/wired.network)
	$(call install, etc/network/wireless.network, /etc/systemd/network/wireless.network)

.PHONY: polkit
polkit: root ## polkit rules
	$(call install, etc/polkit/wheel.rules, /etc/polkit-1/rules.d/wheel.rules)

.PHONY: grub
grub: root ## install grub config
	$(call install, etc/grub, /etc/default/grub)

.PHONY: zram
zram: root ## zram config
	@sh etc/zram-rule.sh /etc/udev/rules.d/99-zram.rules
	$(call append, /etc/modules-load.d/zram.conf, "zram")
	$(call append, /etc/fstab, "/dev/zram0 none swap sw 0 0")
	@modprobe zram && sleep 0.5 && swapon -a # sleep is needed to allow udev to initialize device

.PHONY: htop
htop: ## htop config
	$(call copy, config/htoprc, ${XDG_CONFIG_HOME}/htop/htoprc)

.PHONY: root
root:
	@if ! [ "$(shell id -u)" = 0 ]; then echo "This target requires root priviledge"; exit 1; fi

.PHONY: clean
clean:
	@find ${HOME} -xtype l | xargs -L1 unlink

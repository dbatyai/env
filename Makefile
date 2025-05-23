XDG_CONFIG_HOME ?= ~/.config

# Create a symlink if target is not yet a link, backing up the original
define link
	@mkdir -p `dirname $2`
	@test ! -e $2 || test -L $2 || cp $2 $2~
	@ln -sfvT `readlink -f $1` $2
endef

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
user: config vars git vim ycm yay ## install user specific configs

.PHONY: config
config: ## common rc files in $HOME
	$(call link, config/bashrc, ~/.bashrc)
	$(call link, config/profile, ~/.profile)
	$(call link, config/inputrc, ${XDG_CONFIG_HOME}/readline/inputrc)
	$(call link, config/screenrc, ${XDG_CONFIG_HOME}/screen/screenrc)
	$(call link, config/tmux.conf, ${XDG_CONFIG_HOME}/tmux/tmux.conf)
	$(call copy, config/htoprc, ${XDG_CONFIG_HOME}/htop/htoprc)

.PHONY: vars
vars: ## environment variables
	$(call link, vars/00-xdg-init.conf, ~/.config/environment.d/00-xdg-init.conf)
	$(call link, vars/05-xdg-dirs.conf, ~/.config/environment.d/05-xdg-dirs.conf)
	$(call link, vars/mozilla.conf, ~/.config/environment.d/mozilla.conf)
	$(call link, vars/qt.conf, ~/.config/environment.d/qt.conf)

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
	$(call link, vim/nvim.vim, ${XDG_CONFIG_HOME}/nvim/init.vim)
	@curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.PHONY: alacritty
alacritty: ## alacritty terminal config
	$(call link, config/alacritty.toml, ${XDG_CONFIG_HOME}/alacritty/alacritty.toml)

.PHONY: yay
yay: ## install yay pacman wrapper
	$(call link, config/yay.json, ${XDG_CONFIG_HOME}/yay/config.json)
	@rm -rf /tmp/yay
	@git clone https://aur.archlinux.org/yay /tmp/yay
	@cd /tmp/yay && yes | makepkg -sircC

.PHONY: sway
sway: ## sway desktop config files
	$(call link, sway/config, ${XDG_CONFIG_HOME}/sway/config)
	$(call link, sway/swaylock, ${XDG_CONFIG_HOME}/swaylock/config)
	$(call link, sway/swayidle, ${XDG_CONFIG_HOME}/swayidle/config)
	$(call link, config/mako, ${XDG_CONFIG_HOME}/mako/config)
	$(call link, i3status/i3status.conf, ${XDG_CONFIG_HOME}/i3status/config)
	$(call install, i3status/i3status-run, ${HOME}/.local/bin/i3status-run)
	$(call install, sway/output.conf, ${XDG_CONFIG_HOME}/sway/config.d/output.conf)
	$(call install, sway/input.conf, ${XDG_CONFIG_HOME}/sway/config.d/input.conf)
	$(call copy, sway/desktop, ${HOME}/.desktop)

.PHONY: nvidia
nvidia: ## nvidia specific config
	$(call link, sway/env/nvidia.conf, ${XDG_CONFIG_HOME}/environment.d/graphics.conf)

.PHONY: intel
intel: ## intel specific config
	$(call link, sway/env/intel.conf, ${XDG_CONFIG_HOME}/environment.d/graphics.conf)

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

.PHONY: root
root:
	@if ! [ "$(shell id -u)" = 0 ]; then echo "This target requires root priviledge"; exit 1; fi

.PHONY: clean
clean:
	@find ${HOME} -xtype l | xargs -L1 unlink

XDG_CONFIG_HOME ?= $(HOME)/.config

DOT := sh lib/dot.sh
SUDO ?= sudo
STAMPS := .stamps

# Directories scanned by 'clean' for broken links into this repo.
# Optional ':<depth>' suffix limits search depth (passed through to 'dot prune').
PRUNE_DIRS := $(HOME):1 $(XDG_CONFIG_HOME)

PLUG_URL := https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.PHONY: help user config vars git nvim opencode sway alacritty nano yay \
	nvidia intel etc pacman network polkit grub zram sudo clean

help: ## print this help message
	@echo "Usage: make TARGET..."
	@echo ""
	@echo "Available targets:"
	@awk '/^[[:alnum:]_.-]+:.*## / { \
		t = substr($$0, 1, index($$0, ":") - 1); \
		d = substr($$0, index($$0, "## ") + 3); \
		printf "  %-12s %s\n", t, d }' $(firstword $(MAKEFILE_LIST))

$(STAMPS):
	mkdir -p $@

sudo:
	$(if $(SUDO),$(SUDO) -v)

user: config vars git nvim yay ## install user specific configs

# --- config -----------------------------------------------------------------

config: $(STAMPS)/config $(XDG_CONFIG_HOME)/htop/htoprc ## common rc files in $HOME

$(STAMPS)/config: | $(STAMPS)
	$(DOT) link config/bashrc $(HOME)/.bashrc
	$(DOT) link config/profile $(HOME)/.profile
	$(DOT) link config/inputrc $(XDG_CONFIG_HOME)/readline/inputrc
	$(DOT) link config/screenrc $(XDG_CONFIG_HOME)/screen/screenrc
	$(DOT) link config/tmux.conf $(XDG_CONFIG_HOME)/tmux/tmux.conf
	touch $@

$(XDG_CONFIG_HOME)/htop/htoprc: config/htoprc
	$(DOT) install $< $@

# --- vars -------------------------------------------------------------------

vars: $(STAMPS)/vars ## environment variables

$(STAMPS)/vars: | $(STAMPS)
	$(DOT) link vars/00-xdg-init.conf $(XDG_CONFIG_HOME)/environment.d/00-xdg-init.conf
	$(DOT) link vars/05-xdg-dirs.conf $(XDG_CONFIG_HOME)/environment.d/05-xdg-dirs.conf
	$(DOT) link vars/mozilla.conf $(XDG_CONFIG_HOME)/environment.d/mozilla.conf
	$(DOT) link vars/qt.conf $(XDG_CONFIG_HOME)/environment.d/qt.conf
	$(DOT) link vars/pyenv.conf $(XDG_CONFIG_HOME)/environment.d/pyenv.conf
	touch $@

# --- nano -------------------------------------------------------------------

nano: $(STAMPS)/nano ## nano config

$(STAMPS)/nano: | $(STAMPS)
	$(DOT) link config/nanorc $(HOME)/.nanorc
	touch $@

# --- git --------------------------------------------------------------------

git: $(STAMPS)/git $(XDG_CONFIG_HOME)/git/git-user ## git config and template

$(STAMPS)/git: | $(STAMPS)
	$(DOT) link git/gitconfig $(XDG_CONFIG_HOME)/git/config
	$(DOT) link git/git-template $(XDG_CONFIG_HOME)/git/git-template
	$(DOT) link git/ctags-hook $(XDG_CONFIG_HOME)/git/ctags-hook
	touch $@

$(XDG_CONFIG_HOME)/git/git-user:
	XDG_CONFIG_HOME=$(XDG_CONFIG_HOME) sh git/git-user.sh

# --- opencode ---------------------------------------------------------------

opencode: $(STAMPS)/opencode ## opencode config

$(STAMPS)/opencode: | $(STAMPS)
	$(DOT) link opencode/AGENTS.md $(XDG_CONFIG_HOME)/opencode/AGENTS.md
	$(DOT) link opencode/opencode.jsonc $(XDG_CONFIG_HOME)/opencode/opencode.jsonc
	$(DOT) link opencode/skill/ $(XDG_CONFIG_HOME)/opencode/skill/
	$(DOT) link opencode/agent/ $(XDG_CONFIG_HOME)/opencode/agent/
	$(DOT) link opencode/plugins/ $(XDG_CONFIG_HOME)/opencode/plugins/
	$(DOT) link opencode/opencode.conf $(XDG_CONFIG_HOME)/environment.d/opencode.conf
	touch $@

# --- nvim -------------------------------------------------------------------

nvim: $(STAMPS)/nvim $(XDG_CONFIG_HOME)/nvim/autoload/plug.vim ## nvim config

$(STAMPS)/nvim: | $(STAMPS)
	$(DOT) link nvim/init.lua $(XDG_CONFIG_HOME)/nvim/init.lua
	$(DOT) link nvim/bindings.vim $(XDG_CONFIG_HOME)/nvim/bindings.vim
	$(DOT) link nvim/color.vim $(XDG_CONFIG_HOME)/nvim/color.vim
	$(DOT) link nvim/commands.vim $(XDG_CONFIG_HOME)/nvim/commands.vim
	$(DOT) link nvim/options.vim $(XDG_CONFIG_HOME)/nvim/options.vim
	$(DOT) link nvim/plugins.vim $(XDG_CONFIG_HOME)/nvim/plugins.vim
	$(DOT) link nvim/statusline.vim $(XDG_CONFIG_HOME)/nvim/statusline.vim
	$(DOT) link nvim/lua $(XDG_CONFIG_HOME)/nvim/lua
	$(DOT) link nvim/colors $(XDG_CONFIG_HOME)/nvim/colors
	$(DOT) link nvim/after $(XDG_CONFIG_HOME)/nvim/after
	touch $@

$(XDG_CONFIG_HOME)/nvim/autoload/plug.vim:
	$(DOT) fetch $(PLUG_URL) $@

# --- alacritty --------------------------------------------------------------

alacritty: $(STAMPS)/alacritty ## alacritty terminal config

$(STAMPS)/alacritty: | $(STAMPS)
	$(DOT) link config/alacritty.toml $(XDG_CONFIG_HOME)/alacritty/alacritty.toml
	touch $@

# --- yay --------------------------------------------------------------------

yay: $(STAMPS)/yay /usr/bin/yay ## install yay pacman wrapper

$(STAMPS)/yay: | $(STAMPS)
	$(DOT) link config/yay.json $(XDG_CONFIG_HOME)/yay/config.json
	touch $@

# makepkg elevates itself via sudo for -si; left interactive to confirm deps.
/usr/bin/yay:
	rm -rf /tmp/yay
	git clone https://aur.archlinux.org/yay /tmp/yay
	cd /tmp/yay && makepkg -sircC

# --- sway -------------------------------------------------------------------

SWAY_FILES := \
	$(HOME)/.local/bin/i3status-run \
	$(XDG_CONFIG_HOME)/sway/config.d/output.conf \
	$(XDG_CONFIG_HOME)/sway/config.d/input.conf \
	$(HOME)/.desktop

sway: $(STAMPS)/sway $(SWAY_FILES) ## sway desktop config files

$(STAMPS)/sway: | $(STAMPS)
	$(DOT) link sway/config $(XDG_CONFIG_HOME)/sway/config
	$(DOT) link sway/swaylock $(XDG_CONFIG_HOME)/swaylock/config
	$(DOT) link sway/swayidle $(XDG_CONFIG_HOME)/swayidle/config
	$(DOT) link config/mako $(XDG_CONFIG_HOME)/mako/config
	$(DOT) link i3status/i3status.conf $(XDG_CONFIG_HOME)/i3status/config
	$(DOT) link sway/env/sway.conf $(XDG_CONFIG_HOME)/environment.d/sway.conf
	mkdir -p $(XDG_CONFIG_HOME)/sway/quirks
	touch $@

$(HOME)/.local/bin/i3status-run: i3status/i3status-run
	$(DOT) install $< $@

$(XDG_CONFIG_HOME)/sway/config.d/output.conf: sway/output.conf
	$(DOT) install $< $@

$(XDG_CONFIG_HOME)/sway/config.d/input.conf: sway/input.conf
	$(DOT) install $< $@

$(HOME)/.desktop: sway/desktop
	$(DOT) install $< $@

# --- graphics ---------------------------------------------------------------
# nvidia/intel share one stamp; GRAPHICS_SRC is a target-specific variable
# inherited by the stamp. Use 'make -B nvidia' / 'make -B intel' to switch.

nvidia: GRAPHICS_SRC := sway/env/nvidia.conf
nvidia: $(STAMPS)/graphics ## nvidia specific config

intel: GRAPHICS_SRC := sway/env/intel.conf
intel: $(STAMPS)/graphics ## intel specific config

$(STAMPS)/graphics: | $(STAMPS)
	$(if $(GRAPHICS_SRC),,$(error use 'make nvidia' or 'make intel'))
	$(DOT) link $(GRAPHICS_SRC) $(XDG_CONFIG_HOME)/environment.d/graphics.conf
	touch $@

# --- /etc -------------------------------------------------------------------

etc: pacman network grub ## config files in /etc

pacman: /etc/pacman.conf ## pacman config

network: /etc/systemd/network/wired.network /etc/systemd/network/wireless.network ## systemd-networkd config

polkit: /etc/polkit-1/rules.d/wheel.rules ## polkit rules

grub: /etc/default/grub ## install grub config

/etc/pacman.conf: etc/pacman.conf | sudo
	$(SUDO) $(DOT) install $< $@

/etc/systemd/network/wired.network: etc/network/wired.network | sudo
	$(SUDO) $(DOT) install $< $@

/etc/systemd/network/wireless.network: etc/network/wireless.network | sudo
	$(SUDO) $(DOT) install $< $@

/etc/polkit-1/rules.d/wheel.rules: etc/polkit/wheel.rules | sudo
	$(SUDO) $(DOT) install $< $@

/etc/default/grub: etc/grub | sudo
	$(SUDO) $(DOT) install $< $@

# --- zram -------------------------------------------------------------------

zram: /etc/udev/rules.d/99-zram.rules | sudo ## zram config
	$(SUDO) $(DOT) append /etc/modules-load.d/zram.conf "zram"
	$(SUDO) $(DOT) append /etc/fstab "/dev/zram0 none swap sw 0 0"
	$(SUDO) modprobe zram && sleep 0.5 && $(SUDO) swapon -a # sleep lets udev initialize the device

/etc/udev/rules.d/99-zram.rules: | sudo
	$(SUDO) sh etc/zram-rule.sh $@

# --- clean ------------------------------------------------------------------

clean: ## remove broken links into this repo and reset stamps
	$(DOT) prune $(CURDIR) $(PRUNE_DIRS)
	rm -rf $(STAMPS)

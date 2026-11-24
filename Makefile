# Recipes run quietly; use V=1 to echo commands.
XDG_CONFIG_HOME ?= $(HOME)/.config

DOT := sh lib/dot.sh
SUDO ?= sudo
STAMPS := .stamps
Q := $(if $(V),,@)

# Directories scanned by 'clean-links' for broken links into this repo.
# Optional ':<depth>' suffix limits search depth (passed through to 'dot prune').
PRUNE_DIRS := $(HOME):1 $(XDG_CONFIG_HOME)

# Directories scanned by 'clean-backups' for '*~' backups (same ':<depth>' syntax).
BACKUP_DIRS := $(PRUNE_DIRS) $(HOME)/.local:2

PLUG_URL := https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.PHONY: help user config vars git nvim opencode sway alacritty nano yay \
	nvidia intel etc pacman network polkit grub zram sudo clean \
	clean-links clean-backups

help: ## print this help message
	$(Q) echo "Usage: make [V=1] TARGET..."
	$(Q) echo ""
	$(Q) echo "Available targets:"
	$(Q) awk '/^[[:alnum:]_.-]+:.*## / { \
		t = substr($$0, 1, index($$0, ":") - 1); \
		d = substr($$0, index($$0, "## ") + 3); \
		printf "  %-16s %s\n", t, d }' $(firstword $(MAKEFILE_LIST))

$(STAMPS):
	$(Q) mkdir -p $@

sudo:
	$(Q) $(if $(SUDO),$(SUDO) -v)

user: config vars git nvim yay ## install user specific configs

# --- config -----------------------------------------------------------------

config: $(STAMPS)/config $(XDG_CONFIG_HOME)/htop/htoprc ## common rc files in $HOME

$(STAMPS)/config: | $(STAMPS)
	$(Q) $(DOT) link config/bashrc $(HOME)/.bashrc
	$(Q) $(DOT) link config/profile $(HOME)/.profile
	$(Q) $(DOT) link config/inputrc $(XDG_CONFIG_HOME)/readline/inputrc
	$(Q) $(DOT) link config/screenrc $(XDG_CONFIG_HOME)/screen/screenrc
	$(Q) $(DOT) link config/tmux.conf $(XDG_CONFIG_HOME)/tmux/tmux.conf
	$(Q) touch $@

$(XDG_CONFIG_HOME)/htop/htoprc: config/htoprc
	$(Q) $(DOT) install $< $@

# --- vars -------------------------------------------------------------------

vars: $(STAMPS)/vars ## environment variables

$(STAMPS)/vars: | $(STAMPS)
	$(Q) $(DOT) link vars/00-xdg-init.conf $(XDG_CONFIG_HOME)/environment.d/00-xdg-init.conf
	$(Q) $(DOT) link vars/05-xdg-dirs.conf $(XDG_CONFIG_HOME)/environment.d/05-xdg-dirs.conf
	$(Q) $(DOT) link vars/mozilla.conf $(XDG_CONFIG_HOME)/environment.d/mozilla.conf
	$(Q) $(DOT) link vars/qt.conf $(XDG_CONFIG_HOME)/environment.d/qt.conf
	$(Q) $(DOT) link vars/pyenv.conf $(XDG_CONFIG_HOME)/environment.d/pyenv.conf
	$(Q) touch $@

# --- nano -------------------------------------------------------------------

nano: $(STAMPS)/nano ## nano config

$(STAMPS)/nano: | $(STAMPS)
	$(Q) $(DOT) link config/nanorc $(HOME)/.nanorc
	$(Q) touch $@

# --- git --------------------------------------------------------------------

git: $(STAMPS)/git $(XDG_CONFIG_HOME)/git/git-user ## git config and template

$(STAMPS)/git: | $(STAMPS)
	$(Q) $(DOT) link git/gitconfig $(XDG_CONFIG_HOME)/git/config
	$(Q) $(DOT) link git/git-template $(XDG_CONFIG_HOME)/git/git-template
	$(Q) $(DOT) link git/ctags-hook $(XDG_CONFIG_HOME)/git/ctags-hook
	$(Q) touch $@

$(XDG_CONFIG_HOME)/git/git-user:
	$(Q) XDG_CONFIG_HOME=$(XDG_CONFIG_HOME) sh git/git-user.sh

# --- opencode ---------------------------------------------------------------

opencode: $(STAMPS)/opencode ## opencode config

$(STAMPS)/opencode: | $(STAMPS)
	$(Q) $(DOT) link opencode/AGENTS.md $(XDG_CONFIG_HOME)/opencode/AGENTS.md
	$(Q) $(DOT) link opencode/opencode.jsonc $(XDG_CONFIG_HOME)/opencode/opencode.jsonc
	$(Q) $(DOT) link opencode/skill/ $(XDG_CONFIG_HOME)/opencode/skill/
	$(Q) $(DOT) link opencode/agent/ $(XDG_CONFIG_HOME)/opencode/agent/
	$(Q) $(DOT) link opencode/plugins/ $(XDG_CONFIG_HOME)/opencode/plugins/
	$(Q) $(DOT) link opencode/opencode.conf $(XDG_CONFIG_HOME)/environment.d/opencode.conf
	$(Q) touch $@

# --- nvim -------------------------------------------------------------------

nvim: $(STAMPS)/nvim $(XDG_CONFIG_HOME)/nvim/autoload/plug.vim ## nvim config

$(STAMPS)/nvim: | $(STAMPS)
	$(Q) $(DOT) link nvim/init.lua $(XDG_CONFIG_HOME)/nvim/init.lua
	$(Q) $(DOT) link nvim/bindings.vim $(XDG_CONFIG_HOME)/nvim/bindings.vim
	$(Q) $(DOT) link nvim/color.vim $(XDG_CONFIG_HOME)/nvim/color.vim
	$(Q) $(DOT) link nvim/commands.vim $(XDG_CONFIG_HOME)/nvim/commands.vim
	$(Q) $(DOT) link nvim/options.vim $(XDG_CONFIG_HOME)/nvim/options.vim
	$(Q) $(DOT) link nvim/plugins.vim $(XDG_CONFIG_HOME)/nvim/plugins.vim
	$(Q) $(DOT) link nvim/statusline.vim $(XDG_CONFIG_HOME)/nvim/statusline.vim
	$(Q) $(DOT) link nvim/lua $(XDG_CONFIG_HOME)/nvim/lua
	$(Q) $(DOT) link nvim/colors $(XDG_CONFIG_HOME)/nvim/colors
	$(Q) $(DOT) link nvim/after $(XDG_CONFIG_HOME)/nvim/after
	$(Q) touch $@

$(XDG_CONFIG_HOME)/nvim/autoload/plug.vim:
	$(Q) $(DOT) fetch $(PLUG_URL) $@

# --- alacritty --------------------------------------------------------------

alacritty: $(STAMPS)/alacritty ## alacritty terminal config

$(STAMPS)/alacritty: | $(STAMPS)
	$(Q) $(DOT) link config/alacritty.toml $(XDG_CONFIG_HOME)/alacritty/alacritty.toml
	$(Q) touch $@

# --- yay --------------------------------------------------------------------

yay: $(STAMPS)/yay /usr/bin/yay ## install yay pacman wrapper

$(STAMPS)/yay: | $(STAMPS)
	$(Q) $(DOT) link config/yay.json $(XDG_CONFIG_HOME)/yay/config.json
	$(Q) touch $@

# makepkg elevates itself via sudo for -si; left interactive to confirm deps.
/usr/bin/yay:
	$(Q) rm -rf /tmp/yay
	$(Q) git clone https://aur.archlinux.org/yay /tmp/yay
	$(Q) cd /tmp/yay && makepkg -sircC

# --- sway -------------------------------------------------------------------

SWAY_FILES := \
	$(HOME)/.local/bin/i3status-run \
	$(XDG_CONFIG_HOME)/sway/config.d/output.conf \
	$(XDG_CONFIG_HOME)/sway/config.d/input.conf \
	$(HOME)/.desktop

sway: $(STAMPS)/sway $(SWAY_FILES) ## sway desktop config files

$(STAMPS)/sway: | $(STAMPS)
	$(Q) $(DOT) link sway/config $(XDG_CONFIG_HOME)/sway/config
	$(Q) $(DOT) link sway/swaylock $(XDG_CONFIG_HOME)/swaylock/config
	$(Q) $(DOT) link sway/swayidle $(XDG_CONFIG_HOME)/swayidle/config
	$(Q) $(DOT) link config/mako $(XDG_CONFIG_HOME)/mako/config
	$(Q) $(DOT) link i3status/i3status.conf $(XDG_CONFIG_HOME)/i3status/config
	$(Q) $(DOT) link sway/env/sway.conf $(XDG_CONFIG_HOME)/environment.d/sway.conf
	$(Q) mkdir -p $(XDG_CONFIG_HOME)/sway/quirks
	$(Q) touch $@

$(HOME)/.local/bin/i3status-run: i3status/i3status-run
	$(Q) $(DOT) install $< $@

$(XDG_CONFIG_HOME)/sway/config.d/output.conf: sway/output.conf
	$(Q) $(DOT) install $< $@

$(XDG_CONFIG_HOME)/sway/config.d/input.conf: sway/input.conf
	$(Q) $(DOT) install $< $@

$(HOME)/.desktop: sway/desktop
	$(Q) $(DOT) install $< $@

# --- graphics ---------------------------------------------------------------
# nvidia/intel share one stamp; GRAPHICS_SRC is a target-specific variable
# inherited by the stamp. Use 'make -B nvidia' / 'make -B intel' to switch.

nvidia: GRAPHICS_SRC := sway/env/nvidia.conf
nvidia: $(STAMPS)/graphics ## nvidia specific config

intel: GRAPHICS_SRC := sway/env/intel.conf
intel: $(STAMPS)/graphics ## intel specific config

$(STAMPS)/graphics: | $(STAMPS)
	$(Q) $(if $(GRAPHICS_SRC),,$(error use 'make nvidia' or 'make intel'))
	$(Q) $(DOT) link $(GRAPHICS_SRC) $(XDG_CONFIG_HOME)/environment.d/graphics.conf
	$(Q) touch $@

# --- /etc -------------------------------------------------------------------

etc: pacman network grub ## config files in /etc

pacman: /etc/pacman.conf ## pacman config

network: /etc/systemd/network/wired.network /etc/systemd/network/wireless.network ## systemd-networkd config

polkit: /etc/polkit-1/rules.d/wheel.rules ## polkit rules

grub: /etc/default/grub ## install grub config

/etc/pacman.conf: etc/pacman.conf | sudo
	$(Q) $(SUDO) $(DOT) install $< $@

/etc/systemd/network/wired.network: etc/network/wired.network | sudo
	$(Q) $(SUDO) $(DOT) install $< $@

/etc/systemd/network/wireless.network: etc/network/wireless.network | sudo
	$(Q) $(SUDO) $(DOT) install $< $@

/etc/polkit-1/rules.d/wheel.rules: etc/polkit/wheel.rules | sudo
	$(Q) $(SUDO) $(DOT) install $< $@

/etc/default/grub: etc/grub | sudo
	$(Q) $(SUDO) $(DOT) install $< $@

# --- zram -------------------------------------------------------------------

zram: /etc/udev/rules.d/99-zram.rules | sudo ## zram config
	$(Q) $(SUDO) $(DOT) append /etc/modules-load.d/zram.conf "zram"
	$(Q) $(SUDO) $(DOT) append /etc/fstab "/dev/zram0 none swap sw,pri=100 0 0"
	$(Q) $(SUDO) modprobe zram && sleep 0.5 && $(SUDO) swapon -a # sleep lets udev initialize the device

/etc/udev/rules.d/99-zram.rules: | sudo
	$(Q) $(SUDO) sh etc/zram-rule.sh $@

# --- clean ------------------------------------------------------------------

clean: ## remove stamp files
	$(Q) rm -rf $(STAMPS)

clean-links: ## remove broken links pointing into this repo
	$(Q) $(DOT) prune $(CURDIR) $(PRUNE_DIRS)

clean-backups: ## interactively remove *~ backups
	$(Q) $(DOT) unbackup $(BACKUP_DIRS)

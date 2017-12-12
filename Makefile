.PHONY: all
all: bashrc bash_profile gitconfig inputrc nanorc vimrc screenrc

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


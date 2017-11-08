install:
	@: ln -srfv .bashrc ~/ && \
	ln -srfv .bash_profile ~/ && \
	ln -srfv .gitconfig ~/ && \
	ln -srfv .inputrc ~/ && \
	ln -srfv .nanorc ~/ && \
	ln -srfv .vimrc ~/ && \
	ln -srfv .screenrc ~/ && \
	echo "Done"

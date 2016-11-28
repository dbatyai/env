install:
	@: ln -srfv .bashrc ~/ && \
	ln -srfv .bash_profile ~/ && \
	ln -srfv .git_completion.sh ~/ && \
	ln -srfv .git_prompt.sh ~/ && \
	ln -srfv .gitconfig ~/ && \
	ln -srfv .inputrc ~/ && \
	ln -srfv .nanorc ~/ && \
	ln -srfv .screenrc ~/ && \
	echo "Done"

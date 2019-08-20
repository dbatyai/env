#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s checkwinsize

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=10000000
HISTFILESIZE=5000000
HISTIGNORE='ls.*'
PROPT_COMMAND='history -a'

alias ls='ls --color=auto'
alias pacman="sudo pacman"
alias systemctl="sudo systemctl"
alias ll='ls -al'

# Grep coloring
alias grep='grep --color=auto --exclude-dir=.git'

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


if [ -n "$SSH_CONNECTION" ]; then
   _ssh_host="@`echo $SSH_CONNECTION | cut -d ' ' -f 3` "
fi

# Prompt color
PS1='\[\033[37m\]\t \[\033[32m\]$_ssh_host\[\033[01;32m\]\u\[\033[00m\]:\[\033[34m\]\w\[\033[91m\]$(parse_git_branch)\[\033[00m\]$ '

# Set default editor
export EDITOR=vim

export PATH="/home/dbatyai/Work/depot_tools:$PATH"


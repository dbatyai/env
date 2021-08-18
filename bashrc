#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -q -s checkwinsize

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=10000000
HISTFILESIZE=10000000
HISTIGNORE='ls.*'
PROMPT_COMMAND='history -a'
PROMPT_DIRTRIM=2

alias ls='ls --color=auto'
alias pacman="sudo pacman"
alias systemctl="sudo systemctl"
alias ll='ls -al'

# Grep coloring
alias grep='grep -I --color=auto --exclude-dir=.git --exclude-dir=.cache'

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ -n "$SSH_CONNECTION" ]; then
   _ssh_host="@`echo $SSH_CONNECTION | cut -d ' ' -f 3` "
fi

# Prompt color
PS1='\[\033[37m\]\t \[\033[32m\]$_ssh_host\[\033[01;32m\]\u\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(parse_git_branch)\[\033[00m\]$ '

# Set default editor
export EDITOR=vim

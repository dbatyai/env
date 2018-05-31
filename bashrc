#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s checkwinsize

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=10000
HISTFILESIZE=20000

alias ls='ls --color=auto'
alias pacman="sudo pacman"
alias systemctl="sudo systemctl"
alias ll='ls -al'

# Grep coloring
alias grep='grep --color=auto'

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Prompt color
PS1='\[\033[37m\]\t\[\033[00m\] \[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[91m\]$(parse_git_branch)\[\033[00m\]$ '

# Set default editor
export EDITOR=vim

export PATH="/home/dbatyai/Work/depot_tools:$PATH"

function md {
    if [ $# -lt 1 ]; then
        echo 'No directory name given.'
        return 1;
    fi
    mkdir -p $1;
    cd $1;
    return 0;
}

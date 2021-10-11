#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -q -s checkwinsize
shopt -s histappend

HISTCONTROL=ignorespace:erasedups
HISTSIZE=10000000
HISTFILESIZE=10000000
HISTIGNORE='ls:cd ..:cd ../:cd -:pwd:exit'

PROMPT_COMMAND='history -a'
PROMPT_DIRTRIM=2

alias ls='ls --color=auto'
alias pacman="sudo pacman"
alias systemctl="sudo systemctl"
alias grep='grep -I --color=auto --exclude-dir=.git --exclude-dir=.cache'

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ -n "$SSH_CONNECTION" ]; then
   _ssh_host="@`echo $SSH_CONNECTION | cut -d ' ' -f 3` "
fi

PS1='\[\033[37m\]\t \[\033[32m\]$_ssh_host\[\033[01;32m\]\u\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(parse_git_branch)\[\033[00m\]$ '

export EDITOR=vim
export MANPAGER="less -R --use-color -Dd+r -Du+b"

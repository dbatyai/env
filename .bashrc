#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s checkwinsize

alias ls='ls --color=auto'
alias pacman="sudo pacman"
alias ll='ls -al'

# Git completion
source /home/dbatyai/.git_completion.sh
source /home/dbatyai/.git_prompt.sh

# Grep coloring
alias grep='grep --color=auto'

# Prompt color
PS1='[\[\e[0;33m\]\t\[\e[0m\]]\[\e[0;32m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;34m\]\w\[\e[0m\]\[\e[31m\]$(__git_ps1)\[\e[0m\]$ '

# Set default editor
export EDITOR=nano

alias tnano="screen -t nano nano"
alias t="screen -t tab"

# arm-none-eabi-gcc
export PATH=$PATH:/home/dbatyai/Work/gcc-arm-none-eabi/bin

# nano file:line
function nanoline {
    for f in "$@"
    do
        fname="$f"
        line=0

        index=`expr index "$f" : `
        if [ "$index" -gt 0 ]
            then
                fname=${f:0:$index - 1}
                linestr=${f:$index}
                linenum=`expr "$linestr" : '\([0-9]*\)'`
                if [ $linenum ]
                    then
                        line=$linenum
                fi
        fi

        nano "+$line" "$fname"
    done
}
alias nano="nanoline"

#zshrc

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
HISTORY_IGNORE="(ls|cd|cd ..|cd ../|cd -|pwd|exit)"

setopt autocd cdsilent
setopt globstarshort nomatch
setopt sharehistory appendhistory incappendhistory histignoredups histignorespace histreduceblanks
setopt promptsubst
setopt correct correctall
unsetopt beep autopushd

bindkey -e

zstyle :compinstall filename '/home/dbatyai/.zshrc'
zstyle ':completion:*' special-dirs true
zstyle ':vcs_info:*' formats ' %F{red}(%b)%f'
zstyle ':vcs_info:*' actionformats ' %F{red}(%a %b)%f'

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
autoload -Uz vcs_info

precmd () { vcs_info }
PROMPT='%F{8}%* %F{green}$_SSH_HOST%B%n%b%f:%F{blue}%(3~|.../%2~|%~)${vcs_info_msg_0_}%f$ '
RPROMPT='%(?..%F{red}%?)'

alias ls='ls --color=auto'
alias pacman="sudo pacman"
alias systemctl="sudo systemctl"
alias grep='grep -I --color=auto --exclude-dir=.git --exclude-dir=.cache --exclude-dir=build --exclude=compile_commands.json'
alias v='vim'

export EDITOR=vim
export MANPAGER="less -R --use-color -Dd+r -Du+b"

fpath=(~/.zsh $fpath)

if [ -n "$SSH_CONNECTION" -a -z "$STY" ]; then
  _SSH_HOST="(`echo $SSH_CONNECTION | cut -d ' ' -f 3`) "
  screen -dRR ssh-`echo $SSH_CONNECTION | cut -d ' ' -f 1`
fi

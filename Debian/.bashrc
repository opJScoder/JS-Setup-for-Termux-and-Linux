# ~/.bashrc — customized by JS

#Welcome!
clear
echo -e "\n\e[1;97m<\e[1;32m=========================================\e[1;97m>"
echo -e "  \e[1;97m‡\e[1;91m★\e[1;97m‡  \e[1;93m Welcome to \e[1;96mDebian 13(Trixie)  \e[1;97m‡\e[1;91m★\e[1;97m‡"
echo -e "\e[1;97m<\e[1;32m=========================================\e[1;97m>"
echo
quotes=(
    "Keep learning, JS — progress begins with curiosity."
    "Innovation thrives where questions are asked."
    "Simplicity is the ultimate sophistication."
    "Stay humble, think critically, and build boldly."
    "Talk is cheap. Show me code!"
)
echo -e "\033[1;92mQoute: \033[1;96m${quotes[$RANDOM % ${#quotes[@]}]}\033[0m"

# Exit if not an interactive shell
case $- in
    *i*) ;;
      *) return;;
esac

# History settings
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Auto-adjust terminal size
shopt -s checkwinsize

# Less-friendly enhancement
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable color support and useful aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    if command -v lsd &>/dev/null; then
        alias ls='lsd'
    else
        alias ls='ls --color=auto'
    fi
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Aliases
alias ll='ls -alF'
alias lsa='ls -A'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias py='source ~/Vscode/Python/.venv/bin/activate'
alias up='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean && sudo apt clean'
alias nf='clear; neofetch'
alias c='clear'
alias b='. ~/.bashrc'

# Bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Optional: enable GUI/VNC
# export DISPLAY=:0

# Custom Prompt
PS1='\n\[\e[92;1m\]┌─\[\e[0;91m\][\[\e[0m\]\T\[\e[91m\]]\[\e[92;1m\]─\[\e[0;91m\][\[\e[38;5;226m\]JS\[\e[91m\]]\[\e[92;1m\]──(\[\e[0m\]\#\[\e[92;1m\])\n└─\[\e[0;91m\][\[\e[96m\]\w\[\e[91m\]]\[\e[38;5;41;1m\]──\[\e[92m\]►\[\e[0m\] '

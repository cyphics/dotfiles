alias ll='ls -la'
alias l='ls -la'
alias la='ls -A'
alias gs='git status'
alias ..='cd ..'
alias vim=nvim

alias rm='rm -I --preserve-root'
#alias fd='fdfind'
alias px='ps auxf | grep -v grep | grep -i -e VSZ -e'
alias df='pydf'
alias hist='history | grep'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias tt=taskwarrior-tui

starship init fish | source



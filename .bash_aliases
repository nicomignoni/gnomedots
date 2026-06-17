alias gnomedots='/usr/bin/git --git-dir=$HOME/.gnomedots/ --work-tree=$HOME'
alias fd='fdfind'
alias ll='ls -lah'

alias ff='xdg-open "$HOME/Documents/storage/$(fd . --type file --ignore-case --base-directory=$HOME/Documents/storage | fzf)"'
# It uses zoxide in place of cd
alias cc='z "$HOME/Documents/storage/$(fd . --type directory --ignore-case --base-directory=$HOME/Documents/storage | fzf)"'
alias rr='z "$HOME/Documents/storage/research/$(fd . --type directory --ignore-case --base-directory=$HOME/Documents/storage/research | fzf)"'

alias tp="trash-put"
alias nn="nautilus -w ."
alias oo="xdg-open"
alias n="nvim"
alias nk='NVIM_APPNAME="nvim-kickstart" nvim'
alias na='NVIM_APPNAME="nvim-astrovim" nvim'
alias nz='NVIM_APPNAME="nvim-lazyvim" nvim'

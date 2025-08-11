alias gnomedots='/usr/bin/git --git-dir=$HOME/.gnomedots/ --work-tree=$HOME'
alias fd='fdfind'
alias ll='ls -lah'
alias cc='cd "$HOME/Documents/storage/$(fd . --type directory --ignore-case --base-directory=$HOME/Documents/storage | fzf)"'
alias ff='xdg-open "$HOME/Documents/storage/$(fd . --type file --ignore-case --base-directory=$HOME/Documents/storage | fzf)"'
alias tp="trash-put"
alias nn="nautilus -w ."
alias oo="xdg-open"
alias n="nvim"

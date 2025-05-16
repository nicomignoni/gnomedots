alias gnomedots='/usr/bin/git --git-dir=$HOME/.gnomedots/ --work-tree=$HOME'
alias ll='ls -lah'
alias hh='eval $(history | sort --reverse --numeric-sort | cut -c 8- | fzf)'
alias cc='cd "$HOME/Documents/storage/$(fd . --type directory --ignore-case --base-directory=$HOME/Documents/storage | fzf)"'
alias ff='xdg-open "$HOME/Documents/storage/$(fd . --type file --ignore-case --base-directory=$HOME/Documents/storage | fzf)"'
alias tp="trash-put"
alias nn="nautilus -w ."
alias oo="xdg-open"
alias n="nvim"
alias gpt4all="$HOME/gpt4all/bin/chat"
alias y="yazi"

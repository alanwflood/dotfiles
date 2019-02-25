# Alias the date command
alias tnow='date "+%T %d-%m-%Y"'
alias tnowtime='date "+%T"'
alias tnowdate='date "+%d-%m-%Y"'

# time savers
alias g="git"
alias h="history"
alias j="jobs"
alias be="bundle exec"

#Progressive verbose by default mkdir
alias mkdir="mkdir -pv"

# List all files colorized in long format
alias l="ls -lF"

# List all files colorized in long format, including dot files
alias la="ls -laF"

# List only directories and get high as a kite
alias lsd="ls -lF | grep --color=never '^d'"

# go to project root
alias root='cd (git rev-parse --git-dir)/..'

# Freenas SSH
alias msss='sshfs -p 4500 Alan@floodhome1991.asuscomm.com:/mnt/ $HOME/Documents/Mount'

# edit dotfiles repo
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Weather me this
function wth
  curl wttr.in/$argv
end

alias myip='curl ifconfig.io'

alias calc='bc -l'

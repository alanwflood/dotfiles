alias reload="source $HOME/.config/fish/config.fish"

# Alias the date command
alias tnow='date "+%T %d-%m-%Y"'
alias tnowtime='date "+%T"'
alias tnowdate='date "+%d-%m-%Y"'

# time savers
alias g="git"
alias gco='git checkout'

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

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Weather me this
function wth
  curl "wttr.in/$argv"
end

# Weather me that
function wth2
  curl "v2.wttr.in/$argv"
end

alias moon="curl wttr.in/moon"

function cheat
  curl "cheat.sh/$argv"
end

alias btc="curl eur.rate.sx/btc@10d"

alias myip='curl ifconfig.io'

alias calc='bc -l'

function mkdir-cd
    mkdir $argv && cd $argv
end
abbr -a mc mkdir-cd

alias gcb="git branch --show"

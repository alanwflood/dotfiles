# show/hide files in macOS
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# update, upgrade and clean homebrew installs
# brew cu requires brew-cask-update
alias brewski='brew update && brew upgrade && brew cu && brew cleanup; brew doctor'

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple's System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias purge="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Google Chrome
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

alias addDockSpacer='defaults write com.apple.dock persistent-apps -array-add \'{tile-type="spacer-tile";}\'; killall Dock'


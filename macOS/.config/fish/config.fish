set fish_greeting ""

set -gx LC_ALL en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8
set -gx TERM xterm-256color

if status is-interactive
  cd $HOME
end

set -gx EDITOR lvim

set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/opt/findutils/libexec/gnubin $PATH
set -gx PATH /opt/homebrew/opt/grep/libexec/gnubin $PATH
set -gx PATH /opt/homebrew/opt/gnu-sed/libexec/gnubin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/go/bin $PATH

direnv hook fish | source

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias j "z"
command -qv lvim && alias vim lvim
alias vimdiff "lvim -d"
alias copy "pbcopy"
alias week "date +%V"
alias gox86 "GOOS=linux GOARCH=amd64 go"

# source some other aliases that we don't include here
source ~/.aliases

function vps
        mosh irc
end

function upgrade
    brew update
    brew upgrade
    fisher update
    softwareupdate -i -a
end

set -g fish_escape_delay_ms 300
function fish_user_key_bindings
    bind \e. 'history-token-search-backward'
end

if status is-login
    ssh-add -q --apple-use-keychain --apple-load-keychain
end

stern --completion=fish | source

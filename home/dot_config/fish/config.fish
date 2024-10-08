fish_config theme choose "Dracula Official"

set fish_greeting ""
set -gx LC_ALL en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8
set -gx TERM xterm-256color

if status is-interactive
    cd $HOME
end

set -x PATH /usr/local/bin ~/.local/bin /opt/homebrew/bin ~/go/bin $PATH
set -gx PATH /opt/homebrew/opt/gnu-sed/libexec/gnubin $PATH
set -gx PATH /opt/homebrew/opt/gnu-tar/libexec/gnubin $PATH
set -gx EDITOR nvim
set -gx GOPATH $HOME/go
set -gx K9S_CONFIG_DIR $HOME/.config/k9s

direnv hook fish | source

command -qv bat && alias cat bat
command -qv nvim && alias vim nvim
command -qv rg && alias grep rg
command -qv fd && alias find fd
command -qv lazygit && alias lgit lazygit

alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias j z
alias vimdiff "nvim -d"
alias copy pbcopy
alias week "date +%V"
alias gox86 "GOOS=linux GOARCH=amd64 go"
alias k kubectl
alias kc "kubectl config use-context"
alias ku "kubectl config unset current-context"

# source some other aliases that we don't include here
source ~/.aliases

function vps
    mosh irc
end

function upgrade
    brew update
    brew outdated
    brew upgrade
    brew cleanup
    fisher update
    softwareupdate -i -a
end

set -g fish_escape_delay_ms 300
function fish_user_key_bindings
    bind \e. history-token-search-backward
end

if status is-login
    ssh-add -q --apple-use-keychain --apple-load-keychain
end

stern --completion=fish | source
atuin init fish | source

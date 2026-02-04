set fish_greeting ""

set -gx LC_ALL en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8
set -gx TERM xterm-256color

if status is-interactive
  cd $HOME
end

set -x PATH /usr/local/bin ~/.local/bin ~/go/bin $PATH
set -gx EDITOR nvim
set -gx GOPATH $HOME/go
set -gx K9S_CONFIG_DIR $HOME/.config/k9s

direnv hook fish | source

set -g fish_escape_delay_ms 300
function fish_user_key_bindings
    bind \e. 'history-token-search-backward'
end

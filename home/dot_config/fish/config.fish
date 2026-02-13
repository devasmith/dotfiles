set fish_greeting ""

set -gx LC_ALL en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8
set -gx TERM xterm-256color
set -gx PROTON_PASS_KEY_PROVIDER fs
set -gx EDITOR nvim
set -gx VISUAL nvim
alias vim="nvim"
alias j="z"
alias docker="podman"
alias top="btop"

if status is-interactive
    cd $HOME
end

set -x PATH /usr/local/bin ~/.local/bin ~/go/bin $PATH
set -gx GOPATH $HOME/go
set -gx K9S_CONFIG_DIR $HOME/.config/k9s
set -gx KIND_EXPERIMENTAL_PROVIDER podman
set -Ux LIBVIRT_DEFAULT_URI qemu:///system

if test -z "$SSH_AUTH_SOCK"
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/keyring/ssh"
end

direnv hook fish | source

functions -e gup
abbr -e gup
abbr -a vm vms
abbr -a vu vup
abbr -a vd vdown
abbr -a vr vreboot
abbr -a vs vssh
abbr -a vp vpick

set -g fish_escape_delay_ms 300
function fish_user_key_bindings
    bind \e. history-token-search-backward
end

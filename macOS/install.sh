#!/bin/bash
if [[ ! -x /usr/local/bin/brew ]] && [[ ! -x /opt/homebrew/bin/brew ]]; then
    echo "Brew is not installed. Let's install it."
    if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; then
        echo "Something went wrong with the installation."
        exit 1
    fi
fi

if [[ -x /usr/local/bin/brew ]]; then
    brew="/usr/local/bin/brew"
    fish="/usr/local/bin/fish"
elif [[ -x /opt/homebrew/bin/brew ]]; then
    brew="/opt/homebrew/bin/brew"
    fish="/opt/homebrew/bin/fish"
fi

echo "Install brew packages"
$brew install --quiet fish fisher jq ipcalc iproute2mac neovim direnv pwgen \
    git fzf grep bash curl k9s mosh tmux tmux-xpanes node findutils gnu-sed \
    koekeishiya/formulae/yabai koekeishiya/formulae/skhd

echo "Install brew cask packages"
$brew install --quiet --cask 1password alfred appcleaner alt-tab brave-browser firefox iterm2 \
    docker signal istat-menus obsidian gpg-suite-no-mail only-switch \
    visual-studio-code font-jetbrains-mono-nerd-font font-powerline-symbols \
    whichspace wireshark

echo "Install fish shell packages"
fisher_packages="jethrokuan/z IlanCosman/tide@v5 jethrokuan/fzf jhillyerd/plugin-git"
for package in $fisher_packages; do
    if ! $fish -c "fisher list | grep -q -i $package"; then
        $fish -c "fisher install $package"
    fi
done

if [[ "$(dscl . -read ~/ UserShell | sed 's/UserShell: //')" != "$fish" ]]; then
    echo "Set default shell to fish. You will have to enter your computer password here twice."
    echo "$fish" | sudo tee -a /etc/shells
    chsh -s "$fish"
fi

for file in .*; do
    if [[ -f $file ]]; then
        if [[ $file == .prepare-commit-msg ]]; then
            [[ -d ~/.githooks ]] || mkdir ~/.githooks
            [[ -f ~/.githooks/prepare-commit-msg ]] || ln -s "$HOME/workspace/dotfiles/macOS/$file" "$HOME/.githooks/prepare-commit-msg"
        elif [[ $file == .git-work.conf.gpg ]]; then
            [[ -f ~/.git-work.conf ]] || gpg -d -o ~/.git-work.conf .git-work.conf.gpg
        else
            [[ -f $HOME/$file ]] || ln -s "$HOME/workspace/dotfiles/macOS/$file" "$HOME/$file"
        fi
    fi
done

if [[ -d ~/.config.bak ]]; then
    echo "$HOME/.config.bak exists. Move it away rerun script."
    exit
elif [[ -d ~/.config ]]; then
    echo "Backup ~/.config to ~/.config.bak"
    cp -ap "$HOME/.config" "$HOME/.config.bak"
    echo "Copy config directory to $HOME/.config"
    rsync -a .config/ "$HOME/.config/"
fi

echo -e "to configure tide, run:\ntide configure"

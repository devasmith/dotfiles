# Dotfiles
Managed with [chezmoi](https://github.com/twpayne/chezmoi) on Fedora (Sway) and macOS. Secrets come from
Proton Pass via [pass-cli](https://protonpass.github.io/pass-cli/).

## Bootstrap a new machine

### 1. Install chezmoi and clone dotfiles
```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init $GITHUB_USERNAME
```
chezmoi and pass-cli are installed to `~/.local/bin`. If it is not on your `PATH` (macOS, until fish is the
login shell):
```bash
export PATH="$HOME/.local/bin:$PATH"
```

### 2. Generate chezmoi config
```bash
mkdir -p ~/.config/chezmoi
chezmoi execute-template < ~/.local/share/chezmoi/.chezmoi.toml.tmpl > ~/.config/chezmoi/chezmoi.toml
```

### 3. Install and log in to Proton Pass
The install script needs `curl` and `jq`. Later chezmoi runs call it automatically through a hook.
```bash
~/.local/share/chezmoi/.install-pass-cli.sh
pass-cli login
```

### 4. Apply dotfiles
```bash
chezmoi diff
chezmoi apply
```

## OS-specific files
`home/.chezmoiignore` selects files and scripts per OS.

### Both
- `run_onchange_after_05-fisher.sh.tmpl` installs fisher and syncs fish plugins to
  `~/.config/fish/fish_plugins` with `fisher update`, so plugins removed from the list are uninstalled

### Fedora
- `run_once_00-install-packages.sh.tmpl` installs packages with dnf and Go tools
- the other `run_*` scripts set up sudoers, system settings, keyd and firewalld

### macOS
- `run_onchange_00-darwin-install-packages.sh.tmpl` installs Homebrew if missing and runs `brew bundle` on
  `~/.Brewfile`, then Go tools. It also removes the bootstrap pass-cli in favour of Homebrew's, so update
  it with `brew upgrade`
- `run_onchange_01-darwin-setup-system.sh` makes fish the login shell and enables the application firewall
- `run_onchange_02-darwin-defaults.sh` sets system preferences with `defaults`; log out to apply the keyboard
  settings

## SSH keys
Each OS has its own SSH key, stored as an SSH key item in Proton Pass. The share and item IDs live in
`home/.chezmoidata.toml` under `ssh.key.<os>`. Both machines deploy the key as `~/.ssh/id_ed25519`, so the shared
`~/.ssh/config` works everywhere.

To add a key for a new machine:
```bash
pass-cli item create ssh-key generate --share-id '<share id>' --title "ssh-key-<machine>" --key-type ed25519 --comment "<machine>"
pass-cli item list --share-id '<share id>' | grep ssh-key-<machine>
```
Then add the share and item ID to `home/.chezmoidata.toml` and the public key to GitHub and servers.

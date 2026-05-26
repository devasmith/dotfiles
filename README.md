# Dotfiles
Managed with [chezmoi](https://github.com/twpayne/chezmoi).

## Bootstrap a new machine

### 1. Install chezmoi and clone dotfiles
```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init $GITHUB_USERNAME
```

### 2. Generate chezmoi config
```bash
chezmoi execute-template < ~/.local/share/chezmoi/.chezmoi.toml.tmpl > ~/.config/chezmoi/chezmoi.toml
```

### 3. Login to Proton Pass
```bash
pass-cli login
```

### 4. Apply dotfiles
```bash
chezmoi apply
```

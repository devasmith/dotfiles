# Dotfiles

Managed with [chezmoi](https://github.com/twpayne/chezmoi).

## Install chezmoi to ~/.local/bin and apply config

```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply $GITHUB_USERNAME
```

Generate chezmoi config

```bash
chezmoi execute-template < ~/.local/share/chezmoi/.chezmoi.toml.tmpl > ~/.config/chezmoi/chezmoi.toml
```

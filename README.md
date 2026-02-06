# Dotfiles

Managed with [chezmoi](https://github.com/twpayne/chezmoi).

## Install chezmoi to ~/.local/bin and apply config

```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply $GITHUB_USERNAME
```

Personal secrets are stored in Proton Pass and you'll need the pass-cli installed.

```bash
pass-cli login
```

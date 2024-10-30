# Dotfiles

Managed with [chezmoi](https://github.com/twpayne/chezmoi).

## Install chezmoi to ~/.local/bin and apply config

```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply $GITHUB_USERNAME
```

Personal secrets are stored in 1Password and you'll need the 1Password CLI installed. Login to 1Password with:

```bash
eval $(op signin --account my)
```

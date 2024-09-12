# Dotfiles

Managed with [chezmoi](https://github.com/twpayne/chezmoi).

## Install

```bash
chezmoi init https://github.com/devasmith/dotfiles.git
chezmoi apply
```

Personal secrets are stored in 1Password and you'll need the 1Password CLI installed. Login to 1Password with:

```bash
eval $(op signin --account my)
```

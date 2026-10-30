#!/bin/bash
set -e

if [[ "$(uname -m)" == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Use fish as login shell (foot does shell=fish on Linux)
fish="$(brew --prefix)/bin/fish"
if [[ -x "$fish" ]]; then
  if ! grep -qx "$fish" /etc/shells; then
    echo "$fish" | sudo tee -a /etc/shells >/dev/null
  fi
  if [[ "$(dscl . -read "/Users/$USER" UserShell | awk '{print $2}')" != "$fish" ]]; then
    chsh -s "$fish"
  fi
fi

# Application firewall: on, stealth mode (counterpart to firewalld hardening)
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# Install ClaudeCode
if [ ! -f "$HOME/.local/bin/claude" ]; then
  curl -fsSL https://claude.ai/install.sh | bash
fi

#!/bin/bash
set -e

# Keep System Settings from overwriting the changes below
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

# --- Keyboard ---
# Fast key repeat, short delay (takes effect after logout)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Repeat keys on hold instead of the accent popup (hjkl in nvim)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Tab between all controls in dialogs
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# No autocorrect or smart punctuation
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# --- Trackpad ---
# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# --- Finder ---
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# List view, search current folder, no warning on extension change
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.finder FXDefaultSearchScope -string SCcf
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# No .DS_Store on network and USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# --- Dock / Spaces ---
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
# Keep Spaces in a fixed order, like sway workspaces
defaults write com.apple.dock mru-spaces -bool false

# --- Screenshots ---
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture type -string png
defaults write com.apple.screencapture disable-shadow -bool true

# --- Misc ---
# Expanded save and print dialogs
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
# Save new documents to disk, not iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

for app in Finder Dock SystemUIServer; do
  killall "$app" &>/dev/null || true
done

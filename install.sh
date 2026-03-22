#!/bin/bash
# Bootstrap script — run this on a fresh machine:
#   curl -fsLS https://raw.githubusercontent.com/tsjeyaganesh/dotfiles/main/install.sh | bash
#
# Or clone and run:
#   git clone https://github.com/tsjeyaganesh/dotfiles.git ~/dotfiles && ~/dotfiles/install.sh

set -euo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/tsjeyaganesh/dotfiles.git}"

# Install alacritty if needed
if ! command -v alacritty &>/dev/null; then
  echo "Installing alacritty..."
  if command -v apt-get &>/dev/null; then
    sudo apt-get update && sudo apt-get install -y alacritty
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y alacritty
  elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm alacritty
  elif command -v brew &>/dev/null; then
    brew install --cask alacritty
  else
    echo "Warning: Could not detect package manager — install alacritty manually"
  fi
fi

# Install chezmoi if needed
if ! command -v chezmoi &>/dev/null; then
  echo "Installing chezmoi..."
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
  export PATH="$HOME/.local/bin:$PATH"
fi

# If running from the cloned repo, init from local path then apply
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [[ -f "${SCRIPT_DIR}/.chezmoi.toml.tmpl" ]]; then
  chezmoi init --source "${SCRIPT_DIR}"
  chezmoi apply --source "${SCRIPT_DIR}"
else
  chezmoi init --apply "$DOTFILES_REPO"
fi

echo ""
echo "Done! Restart your shell or run: exec zsh"

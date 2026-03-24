#!/bin/bash
# Bootstrap script — run this on a fresh machine:
#   curl -fsLS https://raw.githubusercontent.com/tsjeyaganesh/dotfiles/main/install.sh | bash
#
# Or clone and run:
#   git clone https://github.com/tsjeyaganesh/dotfiles.git ~/dotfiles && ~/dotfiles/install.sh

set -euo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/tsjeyaganesh/dotfiles.git}"

# ── Install apps if needed ─────────────────────────────────────────────
if command -v brew &>/dev/null; then
  # macOS (Homebrew)
  brew install \
    zsh vim neovim tmux \
    starship zoxide fzf ripgrep fd bat eza \
    git-delta lazygit gh \
    direnv jq yq curl wget \
    yazi ffmpeg sevenzip poppler imagemagick resvg w3m lynx || true

  brew install --cask alacritty font-jetbrains-mono-nerd-font || true

elif command -v apt-get &>/dev/null; then
  sudo apt-get update && sudo apt-get install -y \
    zsh vim tmux alacritty curl wget git jq unzip fontconfig build-essential \
    ripgrep bat fd-find fzf eza direnv \
    ffmpeg p7zip-full poppler-utils imagemagick w3m lynx

elif command -v dnf &>/dev/null; then
  sudo dnf install -y \
    zsh vim tmux alacritty curl wget git jq unzip fontconfig \
    fzf ripgrep fd-find bat direnv gcc make eza \
    ffmpeg p7zip poppler-utils ImageMagick w3m lynx

elif command -v pacman &>/dev/null; then
  sudo pacman -Syu --noconfirm --needed \
    zsh vim neovim tmux alacritty \
    starship zoxide fzf ripgrep fd bat eza \
    git-delta lazygit github-cli \
    direnv jq yq curl wget base-devel \
    yazi ffmpeg p7zip poppler imagemagick resvg w3m lynx

else
  echo "Warning: Could not detect package manager — install apps manually"
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

# ── Set default shell to zsh ──────────────────────────────────────────
if command -v zsh &>/dev/null && [ "$SHELL" != "$(command -v zsh)" ]; then
  echo "Changing default shell to zsh..."
  chsh -s "$(command -v zsh)"
fi

echo ""
echo "Done! Restart your shell or run: exec zsh"

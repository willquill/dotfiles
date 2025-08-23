#!/usr/bin/env bash
set -euo pipefail

ZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip"
FONT_DIR="$HOME/.local/share/fonts"
TMP_DIR=$(mktemp -d)

# Ensure target directory exists
mkdir -p "$FONT_DIR"

# Download ZIP
echo "Downloading FiraCode.zip ..."
curl -L "$ZIP_URL" -o "$TMP_DIR/FiraCode.zip"

# Extract only .ttf files
echo "Extracting .ttf files to $FONT_DIR ..."
unzip -j "$TMP_DIR/FiraCode.zip" '*.ttf' -d "$FONT_DIR"

# Refresh font cache
echo "Updating font cache ..."
fc-cache -fv

# Cleanup
rm -rf "$TMP_DIR"
echo "Done! FiraCode Nerd Font is installed."

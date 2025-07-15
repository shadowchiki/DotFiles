#!/bin/bash

# Check number of arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <terminal> <dotfiles_path>"
  echo "Example: $0 alacritty /home/user/dotfiles"
  exit 1
fi

TERMINAL_NAME="$1"
CONFIG_PATH="$2"

# Check if the configuration file exists
if [ ! -f "$CONFIG_PATH" ]; then
  echo "❌ File '$CONFIG_PATH' does not exist."
  exit 2
fi

# Function to configure Alacritty
configure_alacritty() {
  CONFIG_DIR="$HOME/.config/"

  echo "⚙️ Configuring Alacritty..."
  mkdir -p "$CONFIG_DIR"

  # You can choose between copying or symlinking:
  # cp "$CONFIG_PATH" "$TARGET_FILE"
  # or
  # ln -sf "$CONFIG_PATH" "$TARGET_FILE"
  echo "👉 Copy or symlink '$CONFIG_PATH' to '$TARGET_FILE'"
  ln -sf "$CONFIG_PATH/alacritty" "$CONFIG_PATH"
}

# Function to configure Ghostty
configure_ghostty() {
  CONFIG_DIR="$HOME/.config/ghostty"
  TARGET_FILE="$CONFIG_DIR/config"

  echo "⚙️ Configuring Ghostty..."
  mkdir -p "$CONFIG_DIR"

  # cp "$CONFIG_PATH" "$TARGET_FILE"
  # ln -sf "$CONFIG_PATH" "$TARGET_FILE"
  echo "👉 Copy or symlink '$CONFIG_PATH' to '$TARGET_FILE'"
}

# Function to configure Terminator
configure_terminator() {
  CONFIG_DIR="$HOME/.config/terminator"
  TARGET_FILE="$CONFIG_DIR/config"

  echo "⚙️ Configuring Terminator..."
  mkdir -p "$CONFIG_DIR"

  # cp "$CONFIG_PATH" "$TARGET_FILE"
  # ln -sf "$CONFIG_PATH" "$TARGET_FILE"
  echo "👉 Copy or symlink '$CONFIG_PATH' to '$TARGET_FILE'"
}

# Terminal selection
case "$TERMINAL_NAME" in
alacritty)
  configure_alacritty
  ;;
ghostty)
  configure_ghostty
  ;;
terminator)
  configure_terminator
  ;;
*)
  echo "❌ Unrecognized terminal: $TERMINAL_NAME"
  echo "Valid options: alacritty, ghostty, terminator"
  exit 3
  ;;
esac

echo "✅ Configuration finished (pending actual copy/link operation)."

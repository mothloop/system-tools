#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.local/bin"

mkdir -p "$TARGET_DIR"

# Store repo directory for update script
echo "$REPO_DIR" > "$HOME/.system-tools-repo"

# List of scripts to install
SCRIPTS=(update clean audit up full install monitor syshelp)

# Install each script
for script in "${SCRIPTS[@]}"; do
    target="$TARGET_DIR/$script"
    if [ -L "$target" ] || { [ -e "$target" ] && [ "$(readlink -f "$target")" = "$(readlink -f "$REPO_DIR/bin/$script")" ]; }; then
        rm -f "$target"
    fi
    /usr/bin/install -m 755 "$REPO_DIR/bin/$script" "$target"
done

# Update PATH if needed
case ":$PATH:" in
    *":$TARGET_DIR:"*)
        ;;
    *)
        SHELL_NAME="$(basename "${SHELL:-/bin/bash}")"
        if [ "$SHELL_NAME" = "zsh" ]; then
            RC_FILE="$HOME/.zshrc"
        else
            RC_FILE="$HOME/.bashrc"
        fi
        LINE='export PATH="$HOME/.local/bin:$PATH"'
        if [ -f "$RC_FILE" ]; then
            grep -Fq '.local/bin' "$RC_FILE" || printf '\n%s\n' "$LINE" >> "$RC_FILE"
        else
            printf '%s\n' "$LINE" > "$RC_FILE"
        fi
        source "$RC_FILE"
        ;;
esac

printf "✓ Installed %d system-tools to %s\n" "${#SCRIPTS[@]}" "$TARGET_DIR"
printf "✓ Configuration saved to %s\n" "$HOME/.system-tools-repo"
printf "\nRestart your shell or run: source ~/.bashrc\n"
#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.local/bin"

mkdir -p "$TARGET_DIR"

# Store repo directory for update script
echo "$REPO_DIR" > "$HOME/.system-tools-repo"

for script in update clean audit up full install monitor; do
    target="$TARGET_DIR/$script"
    if [ -L "$target" ] || { [ -e "$target" ] && [ "$(readlink -f "$target")" = "$(readlink -f "$REPO_DIR/bin/$script")" ]; }; then
        rm -f "$target"
    fi
    /usr/bin/install -m 755 "$REPO_DIR/bin/$script" "$target"
done

case ":$PATH:" in
    *":$TARGET_DIR:"*)
        ;;
    *)
        SHELL_NAME="$(basename "${SHELL:-}")"
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

echo "Installed update, clean, audit, up, full, install, and monitor to $TARGET_DIR"
echo "Restart your shell or run: source ~/.bashrc"
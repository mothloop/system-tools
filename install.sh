#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.local/bin"

mkdir -p "$TARGET_DIR"

for script in update clean up; do
    install -m 755 "$REPO_DIR/bin/$script" "$TARGET_DIR/$script"
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
        ;;
esac

echo "Installed update, clean, and up to $TARGET_DIR"
echo "Restart your shell or run: source ~/.bashrc"
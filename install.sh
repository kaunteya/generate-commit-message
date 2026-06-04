#!/usr/bin/env bash
#
# install.sh - Install the gitmsg script so it can be run as a command.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/gitmsg"

# Pick an install location: prefer /usr/local/bin, fall back to ~/.local/bin
if [ -w /usr/local/bin ] 2>/dev/null; then
	DEST_DIR="/usr/local/bin"
else
	DEST_DIR="$HOME/.local/bin"
fi

mkdir -p "$DEST_DIR"
DEST="$DEST_DIR/gitmsg"

install -m 0755 "$SRC" "$DEST"

echo "Installed gitmsg to $DEST"

# Warn if the install location is not on PATH
case ":$PATH:" in
	*":$DEST_DIR:"*) ;;
	*)
		echo "Note: $DEST_DIR is not on your PATH."
		echo "Add this line to your ~/.zshrc:"
		echo "    export PATH=\"$DEST_DIR:\$PATH\""
		;;
esac

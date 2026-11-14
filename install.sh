#!/usr/bin/env bash
# Installer webctl untuk Termux / Linux / WSL / macOS
# Pemakaian:
#   bash install.sh
# atau remote (setelah dipublish ke GitHub):
#   curl -fsSL https://raw.githubusercontent.com/<user>/webctl/main/install.sh | bash
set -euo pipefail

REPO_RAW="${WEBCTL_RAW_BASE:-https://raw.githubusercontent.com/<user>/webctl/main}"
INSTALL_DIR="${WEBCTL_INSTALL_DIR:-$HOME/.local/bin}"
WEBCTL_HOME="${WEBCTL_HOME:-$HOME/.webctl}"

mkdir -p "$INSTALL_DIR" "$WEBCTL_HOME/plugins" "$WEBCTL_HOME/run" "$WEBCTL_HOME/logs" "$WEBCTL_HOME/sites"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$SCRIPT_DIR/bin/webctl" ]; then
  # instalasi dari clone lokal
  cp "$SCRIPT_DIR/bin/webctl" "$INSTALL_DIR/webctl"
else
  # instalasi remote (curl | bash), ambil file dari GitHub raw
  curl -fsSL "$REPO_RAW/bin/webctl" -o "$INSTALL_DIR/webctl"
fi

chmod +x "$INSTALL_DIR/webctl"

echo "webctl terpasang di: $INSTALL_DIR/webctl"

# Pastikan PATH memuat $INSTALL_DIR
SHELL_RC=""
case "${SHELL:-}" in
  */zsh) SHELL_RC="$HOME/.zshrc" ;;
  */bash) SHELL_RC="$HOME/.bashrc" ;;
  *) SHELL_RC="$HOME/.profile" ;;
esac

if ! echo "$PATH" | tr ':' '\n' | grep -qx "$INSTALL_DIR"; then
  echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$SHELL_RC"
  echo "PATH ditambahkan ke $SHELL_RC. Jalankan: source $SHELL_RC  (atau buka terminal baru)"
fi

echo
echo "Selesai! Coba jalankan:"
echo "  webctl help"

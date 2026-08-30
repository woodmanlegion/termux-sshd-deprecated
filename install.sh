#!/data/data/com.termux/files/usr/bin/bash
# Install Termux sshd boot hook.
# Idempotent — safe to re-run.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOOT_DIR="$HOME/.termux/boot"

mkdir -p "$BOOT_DIR"

# ── Boot hook ─────────────────────────────────────────────────────────────────

cp "$SCRIPT_DIR/boot/sshd" "$BOOT_DIR/sshd"
chmod +x "$BOOT_DIR/sshd"
echo "Boot hook: $BOOT_DIR/sshd"

# ── Start sshd now ────────────────────────────────────────────────────────────

if pgrep -x sshd >/dev/null 2>&1; then
  echo "sshd already running"
else
  sshd
  echo "sshd started"
fi

# ── Done ──────────────────────────────────────────────────────────────────────

echo
echo "=== Done ==="
echo "sshd will start automatically on next boot via Termux:Boot."
echo "Listening on port 8022 (Termux default)."
echo
echo "On connecting hosts, add to ~/.ssh/config:"
echo "  Host $(hostname 2>/dev/null || echo '<device>')"
echo "    HostName <ip-or-tailscale-hostname>"
echo "    Port 8022"
echo "    User $(whoami)"

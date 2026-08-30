# termux-sshd

Start sshd automatically on Termux device boot. One boot hook, no configuration required.

## Requirements

- `openssh` package: `pkg install openssh`
- Termux:Boot app (F-Droid) — runs scripts in `~/.termux/boot/` on device startup

## Install

```bash
bash install.sh
```

Installs `~/.termux/boot/sshd` and starts sshd immediately.

## Port

Termux sshd listens on **port 8022** by default (non-privileged port; root not required).

Add to `~/.ssh/config` on any connecting host to avoid specifying the port on every connection:

```
Host <device-name>
  HostName <ip-or-tailscale-hostname>
  Port 8022
  User <username>
```

## Verify

```bash
pgrep -x sshd && echo "running" || echo "not running"
ssh localhost -p 8022 -o StrictHostKeyChecking=no whoami
```

## Keys

Add your public key to `~/.ssh/authorized_keys` on the device. Generate on the connecting host if needed:

```bash
ssh-keygen -t ed25519
ssh-copy-id -p 8022 user@<device>
```

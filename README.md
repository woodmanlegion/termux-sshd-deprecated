# termux-sshd (deprecated — see woodmanlegion/edge-restore)

**Deprecated 2026-10-03** (decided 2026-09-27, actually executed now). This
repo's bare, unsupervised boot hook is the exact dangerous pattern
[`woodmanlegion/edge-restore`](https://github.com/woodmanlegion/edge-restore)
exists to prevent: a plain `~/.termux/boot/sshd` script with no process
supervision at all conflicts with a properly `sv`/runit-supervised `sshd`
over the same port — this is a documented real incident class in that repo
(`AGENTS.md` rule #7 names this repo directly as a red flag). The actual,
safe boot-reliability setup now lives in `edge-restore`'s
`scripts/bootstrap.sh` + [`woodmanlegion/tclaw`](https://github.com/woodmanlegion/tclaw)
(which writes the `sv`-managed `sshd` run script) + `sv status sshd`/
[`woodmanlegion/svbase-health`](https://github.com/woodmanlegion/svbase-health)
for health reporting (deliberately `manual` restart policy — this one
service is never touched unattended). Archived; do not install this on a
new device.

---

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

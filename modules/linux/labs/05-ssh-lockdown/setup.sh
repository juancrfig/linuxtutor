#!/bin/bash
set -euo pipefail

# ────────────────────────────────────────────────────────────────
# Lab 05: SSH Lockdown
# Run as root (or with sudo)
# Uses a sandboxed sshd config — does NOT modify your real SSH
# ────────────────────────────────────────────────────────────────

LAB_DIR="$HOME/sandbox/lab-ssh"

echo "🔧 Setting up SSH Lockdown lab..."

rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"/{configs,keys}

# Create an INSECURE sshd_config for the student to harden
cat > "$LAB_DIR/configs/sshd_config_insecure" << 'END'
# WARNING: This config has multiple security issues. Find and fix them all.

Port 22
ListenAddress 0.0.0.0
Protocol 2

# Authentication
PermitRootLogin yes
PasswordAuthentication yes
PermitEmptyPasswords yes
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys

# Dangerous options
X11Forwarding yes
AllowTcpForwarding yes
PermitTunnel yes
GatewayPorts yes
MaxAuthTries 10
LoginGraceTime 120
ClientAliveInterval 0
ClientAliveCountMax 3

# Logging
SyslogFacility AUTH
LogLevel INFO

# Subsystem
Subsystem sftp /usr/lib/openssh/sftp-server

# No user restrictions
# AllowUsers
# AllowGroups
END

# Create a reference "hardened" config (hidden — student should figure it out)
cat > "$LAB_DIR/configs/.sshd_config_hardened" << 'END'
# Hardened SSH Configuration — Reference Answer
# Don't peek until you've tried yourself!

Port 2222
ListenAddress 0.0.0.0
Protocol 2

PermitRootLogin no
PasswordAuthentication no
PermitEmptyPasswords no
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys

X11Forwarding no
AllowTcpForwarding no
PermitTunnel no
GatewayPorts no
MaxAuthTries 3
LoginGraceTime 30
ClientAliveInterval 300
ClientAliveCountMax 2

SyslogFacility AUTH
LogLevel VERBOSE

Subsystem sftp /usr/lib/openssh/sftp-server

AllowGroups sshusers
Banner /etc/ssh/banner
END

# Create a broken SSH config (for debugging exercise)
cat > "$LAB_DIR/configs/ssh_client_broken" << 'END'
# Something is wrong with each of these entries

Host production
    HostName 10.0.1.50
    User deploy
    IdentityFile ~/keys/prod_key
    StrictHostKeyChecking no
    Port 22

Host staging
    HostName staging.internal
    User admin
    IdentityFile ~/.ssh/staging_rsa
    ForwardAgent yes
    ServerAliveInterval 0

Host *
    AddKeysToAgent yes
    IdentitiesOnly no
    HashKnownHosts no
END

# Create some test keys
ssh-keygen -t rsa -b 2048 -f "$LAB_DIR/keys/weak_rsa" -N "" -q
ssh-keygen -t ed25519 -f "$LAB_DIR/keys/strong_ed25519" -N "" -q
# Create a key with wrong permissions
ssh-keygen -t ed25519 -f "$LAB_DIR/keys/bad_perms" -N "" -q
chmod 644 "$LAB_DIR/keys/bad_perms"  # BAD: private key world-readable

echo ""
echo "✅ Lab ready at $LAB_DIR"
echo "   ⚠️  This lab uses sandbox configs — your real SSH is untouched"

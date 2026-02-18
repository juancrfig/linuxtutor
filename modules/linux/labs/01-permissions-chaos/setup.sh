#!/bin/bash
set -euo pipefail

# ────────────────────────────────────────────────────────────────
# Lab 01: Permissions Chaos
# Run as root (or with sudo)
# ────────────────────────────────────────────────────────────────

LAB_DIR="/tmp/lab-permissions"

echo "🔧 Setting up Permissions Chaos lab..."

# Clean previous run
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"/{project,shared,deploy}

# Create users if they don't exist
for user in alice bob deploy-bot; do
    if ! id "$user" &>/dev/null; then
        useradd -m -s /bin/bash "$user" 2>/dev/null || true
    fi
done

# Create groups
groupadd -f developers
groupadd -f ops

# Add users to groups
usermod -aG developers alice 2>/dev/null || true
usermod -aG developers bob 2>/dev/null || true
usermod -aG ops deploy-bot 2>/dev/null || true

# Create project files with WRONG permissions (the chaos)
echo "DATABASE_URL=postgres://prod:secret@db.internal:5432/app" > "$LAB_DIR/project/.env"
chmod 777 "$LAB_DIR/project/.env"  # BAD: secrets world-readable

echo '#!/bin/bash
echo "Deploying..."
rsync -az /app/ /var/www/html/' > "$LAB_DIR/deploy/deploy.sh"
chmod 644 "$LAB_DIR/deploy/deploy.sh"  # BAD: not executable
chown root:root "$LAB_DIR/deploy/deploy.sh"  # BAD: deploy-bot can't modify

mkdir -p "$LAB_DIR/shared/reports"
echo "Q4 Revenue: $2.3M" > "$LAB_DIR/shared/reports/financial.txt"
chown alice:alice "$LAB_DIR/shared/reports/financial.txt"
chmod 600 "$LAB_DIR/shared/reports/financial.txt"  # BAD: bob can't read shared reports

echo "App config v2.1" > "$LAB_DIR/project/config.yaml"
chown alice:alice "$LAB_DIR/project/config.yaml"
chmod 600 "$LAB_DIR/project/config.yaml"  # Only alice can read

# Create a SUID surprise
cp /usr/bin/cat "$LAB_DIR/project/cat-copy" 2>/dev/null || echo "#!/bin/bash" > "$LAB_DIR/project/cat-copy"
chmod 4755 "$LAB_DIR/project/cat-copy"  # SUID root binary sitting in project dir

# Create a directory where files should be shared but aren't
mkdir -p "$LAB_DIR/shared/workspace"
chown alice:developers "$LAB_DIR/shared/workspace"
chmod 700 "$LAB_DIR/shared/workspace"  # BAD: only alice despite group ownership

# Sticky bit missing on shared temp
mkdir -p "$LAB_DIR/shared/tmp"
chmod 777 "$LAB_DIR/shared/tmp"  # BAD: no sticky bit, anyone can delete anyone's files

echo ""
echo "✅ Lab ready at $LAB_DIR"
echo "   Users created: alice, bob, deploy-bot"
echo "   Groups: developers (alice, bob), ops (deploy-bot)"
echo ""
echo "Run: cat $LAB_DIR/../lab-permissions-README.md"

#!/bin/bash
set -euo pipefail

# ────────────────────────────────────────────────────────────────
# Lab 06: Disk Crisis
# Some tasks need root
# ────────────────────────────────────────────────────────────────

LAB_DIR="$HOME/sandbox/lab-disk"

echo "🔧 Setting up Disk Crisis lab..."

rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"/{app,logs,data,mystery}

# Create files that simulate disk bloat
echo "Creating bloated log files..."
for i in $(seq 1 5); do
    dd if=/dev/urandom of="$LAB_DIR/logs/app-2026-02-$((10+i)).log" bs=1M count=$((i * 2)) 2>/dev/null
done

# Create a big "core dump"
dd if=/dev/zero of="$LAB_DIR/app/core.12345" bs=1M count=50 2>/dev/null

# Create nested directories with scattered large files
mkdir -p "$LAB_DIR/data/backups/old/2024"
dd if=/dev/zero of="$LAB_DIR/data/backups/old/2024/db-dump.sql.gz" bs=1M count=30 2>/dev/null
mkdir -p "$LAB_DIR/data/cache/thumbnails"
for i in $(seq 1 20); do
    dd if=/dev/urandom of="$LAB_DIR/data/cache/thumbnails/img_$i.jpg" bs=100K count=1 2>/dev/null
done

# Create tons of tiny files (inode exhaustion simulation)
mkdir -p "$LAB_DIR/mystery/sessions"
for i in $(seq 1 500); do
    echo "session_$i" > "$LAB_DIR/mystery/sessions/sess_$(openssl rand -hex 8 2>/dev/null || echo $RANDOM)"
done

# Create hard and symbolic links for investigation
echo "Original config file" > "$LAB_DIR/app/config.yaml"
ln "$LAB_DIR/app/config.yaml" "$LAB_DIR/data/config-hardlink.yaml"
ln -s "$LAB_DIR/app/config.yaml" "$LAB_DIR/data/config-symlink.yaml"
ln -s "/nonexistent/path/to/file" "$LAB_DIR/data/broken-link.yaml"

# Create a fake fstab for analysis
cat > "$LAB_DIR/fstab-example" << 'END'
# /etc/fstab: static file system information
# <device>                                 <mount>          <type>  <options>               <dump> <pass>
UUID=a1b2c3d4-e5f6-7890-abcd-ef1234567890  /                ext4    errors=remount-ro       0      1
UUID=b2c3d4e5-f6a7-8901-bcde-f12345678901  /home            ext4    defaults                0      2
UUID=c3d4e5f6-a7b8-9012-cdef-123456789012  none             swap    sw                      0      0
//nas.internal/share                        /mnt/nas         cifs    credentials=/etc/smbcreds,uid=1000  0  0
192.168.1.10:/exports/data                  /mnt/nfs         nfs     defaults,_netdev        0      0
tmpfs                                       /tmp             tmpfs   defaults,noexec,nosuid  0      0
END

echo ""
echo "✅ Lab ready at $LAB_DIR"
echo "   Total size: $(du -sh "$LAB_DIR" | cut -f1)"
echo "   Total files: $(find "$LAB_DIR" -type f | wc -l)"

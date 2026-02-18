#!/bin/bash
set -euo pipefail

# ────────────────────────────────────────────────────────────────
# Lab 02: Process Detective
# Run as root (or with sudo)
# ────────────────────────────────────────────────────────────────

echo "🔧 Setting up Process Detective lab..."

# Create a "rogue" CPU hog
cat > /tmp/lab-cpu-hog.sh << 'SCRIPT'
#!/bin/bash
while true; do
    echo "scale=5000; 4*a(1)" | bc -l > /dev/null 2>&1
done
SCRIPT
chmod +x /tmp/lab-cpu-hog.sh

# Create a process that holds a deleted file open
cat > /tmp/lab-deleted-file-holder.sh << 'SCRIPT'
#!/bin/bash
LOGFILE="/tmp/lab-phantom.log"
echo "This file will be deleted but I'll keep writing" > "$LOGFILE"
exec 3>> "$LOGFILE"
while true; do
    echo "$(date): still writing to deleted file" >&3
    sleep 5
done
SCRIPT
chmod +x /tmp/lab-deleted-file-holder.sh

# Create a fork bomb (safe version — limited)
cat > /tmp/lab-fork-spawner.sh << 'SCRIPT'
#!/bin/bash
# Spawns 15 sleep processes to simulate excessive forking
for i in $(seq 1 15); do
    sleep 3600 &
done
wait
SCRIPT
chmod +x /tmp/lab-fork-spawner.sh

# Create a port squatter
cat > /tmp/lab-port-squatter.sh << 'SCRIPT'
#!/bin/bash
# Listens on a port that a "real" service needs
python3 -c "
import socket, time
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind(('0.0.0.0', 8080))
s.listen(1)
while True:
    time.sleep(60)
" 2>/dev/null || nc -l -p 8080 -k &
SCRIPT
chmod +x /tmp/lab-port-squatter.sh

# Launch the chaos
nohup /tmp/lab-cpu-hog.sh > /dev/null 2>&1 &
echo "  Started CPU hog (PID: $!)"

nohup /tmp/lab-deleted-file-holder.sh > /dev/null 2>&1 &
HOLDER_PID=$!
echo "  Started file holder (PID: $HOLDER_PID)"
sleep 1
rm -f /tmp/lab-phantom.log  # Delete the file while process holds it open
echo "  Deleted /tmp/lab-phantom.log (but process still has it open)"

nohup /tmp/lab-fork-spawner.sh > /dev/null 2>&1 &
echo "  Started fork spawner (PID: $!)"

nohup bash /tmp/lab-port-squatter.sh > /dev/null 2>&1 &
echo "  Started port squatter on 8080 (PID: $!)"

# Start a nice'd background process
nice -n 19 dd if=/dev/zero of=/dev/null bs=1M 2>/dev/null &
echo "  Started nice'd dd process (PID: $!)"

echo ""
echo "✅ Lab ready. Chaos is running."
echo "   Rogue processes are active. Time to hunt them down."

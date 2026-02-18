#!/bin/bash
set -euo pipefail

# ────────────────────────────────────────────────────────────────
# Lab 04: Network Diagnosis
# Some tasks need root
# ────────────────────────────────────────────────────────────────

echo "🔧 Setting up Network Diagnosis lab..."

LAB_DIR="$HOME/sandbox/lab-network"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

# Create a simple HTTP server that responds slowly
cat > "$LAB_DIR/slow-server.py" << 'SCRIPT'
#!/usr/bin/env python3
import http.server, time, socketserver

class SlowHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        time.sleep(3)  # Simulate slow response
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(b"Finally responded!\n")
    def log_message(self, format, *args):
        pass  # Suppress logs

with socketserver.TCPServer(("127.0.0.1", 9090), SlowHandler) as httpd:
    httpd.serve_forever()
SCRIPT
chmod +x "$LAB_DIR/slow-server.py"

# Create a broken /etc/hosts scenario
cat > "$LAB_DIR/hosts-backup" << 'END'
# This is what the hosts file SHOULD look like (for reference)
127.0.0.1       localhost
127.0.1.1       webserver
192.168.1.10    db.internal
192.168.1.20    cache.internal
192.168.1.30    api.internal
END

# Create a "mystery" resolv.conf
cat > "$LAB_DIR/resolv-broken.conf" << 'END'
# Something is wrong with this DNS config
nameserver 192.168.1.1
nameserver 10.255.255.1
options timeout:1 attempts:1
search internal.corp localdomain
END

# Start the slow server in background
nohup python3 "$LAB_DIR/slow-server.py" > /dev/null 2>&1 &
echo "  Started slow HTTP server on port 9090 (PID: $!)"

# Start a few listeners to create an interesting port landscape
nohup python3 -c "
import socket, time
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind(('0.0.0.0', 3306))
s.listen(1)
while True: time.sleep(60)
" > /dev/null 2>&1 &
echo "  Started fake MySQL listener on port 3306 (PID: $!)"

nohup python3 -c "
import socket, time
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind(('127.0.0.1', 6379))
s.listen(1)
while True: time.sleep(60)
" > /dev/null 2>&1 &
echo "  Started fake Redis listener on port 6379 (PID: $!)"

echo ""
echo "✅ Lab ready."
echo "   Slow server: http://127.0.0.1:9090"
echo "   Reference files in: $LAB_DIR"

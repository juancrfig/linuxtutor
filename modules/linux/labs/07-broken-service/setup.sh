#!/bin/bash
set -euo pipefail

# ────────────────────────────────────────────────────────────────
# Lab 07: Broken Service
# Needs root (systemd unit files)
# ────────────────────────────────────────────────────────────────

LAB_DIR="$HOME/sandbox/lab-service"

echo "🔧 Setting up Broken Service lab..."

rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"/{app,configs}

# Create a simple "web app" that reads config and serves
cat > "$LAB_DIR/app/server.py" << 'SCRIPT'
#!/usr/bin/env python3
"""Simple web server that reads config and serves requests."""
import http.server
import json
import os
import sys
import socketserver

CONFIG_PATH = os.environ.get("APP_CONFIG", "/etc/lab-webapp/config.json")
PORT = int(os.environ.get("APP_PORT", "8000"))

def load_config():
    try:
        with open(CONFIG_PATH) as f:
            return json.load(f)
    except FileNotFoundError:
        print(f"FATAL: Config not found at {CONFIG_PATH}", file=sys.stderr)
        sys.exit(1)
    except json.JSONDecodeError:
        print(f"FATAL: Invalid JSON in {CONFIG_PATH}", file=sys.stderr)
        sys.exit(1)

config = load_config()
print(f"App '{config.get('name', 'unknown')}' starting on port {PORT}")

class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        self.end_headers()
        self.wfile.write(json.dumps({"status": "ok", "app": config.get("name")}).encode())
    def log_message(self, format, *args):
        print(f"[{self.log_date_time_string()}] {format % args}", file=sys.stderr)

with socketserver.TCPServer(("0.0.0.0", PORT), Handler) as httpd:
    httpd.serve_forever()
SCRIPT
chmod +x "$LAB_DIR/app/server.py"

# Create a BROKEN config (invalid JSON)
sudo mkdir -p /etc/lab-webapp
cat > "$LAB_DIR/configs/config.json" << 'END'
{
    "name": "lab-webapp",
    "version": "1.0",
    "database": "postgres://localhost/app"
    "debug": false
}
END
sudo cp "$LAB_DIR/configs/config.json" /etc/lab-webapp/config.json

# Create a CORRECT config (hidden reference)
cat > "$LAB_DIR/configs/.config-fixed.json" << 'END'
{
    "name": "lab-webapp",
    "version": "1.0",
    "database": "postgres://localhost/app",
    "debug": false
}
END

# Create the systemd unit file WITH BUGS
sudo tee /etc/systemd/system/lab-webapp.service > /dev/null << END
[Unit]
Description=Lab Web Application
After=network.targe
Wants=network-online.target

[Service]
Type=simple
User=labapp
Group=labapp
WorkingDirectory=$LAB_DIR/app
ExecStart=/usr/bin/python3 $LAB_DIR/app/server.py
Environment=APP_CONFIG=/etc/lab-webapp/config.json
Environment=APP_PORT=8000
Restart=on-failure
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.targe
END

# Note: bugs in the unit file:
# 1. "network.targe" (typo — missing 't')
# 2. "multi-user.targe" (typo — missing 't')
# 3. User=labapp doesn't exist
# 4. Config file has invalid JSON

# Create a SECOND service that depends on the first
sudo tee /etc/systemd/system/lab-worker.service > /dev/null << END
[Unit]
Description=Lab Background Worker
After=lab-webapp.service
Requires=lab-webapp.service

[Service]
Type=simple
ExecStart=/bin/bash -c 'while true; do curl -s http://localhost:8000 > /dev/null && echo "Health OK" || echo "Health FAIL"; sleep 10; done'
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
END

sudo systemctl daemon-reload

echo ""
echo "✅ Lab ready."
echo "   Service: lab-webapp.service (broken — your job to fix it)"
echo "   Dependent: lab-worker.service"
echo "   App dir: $LAB_DIR/app/"
echo "   Config: /etc/lab-webapp/config.json"
echo ""
echo "   Try: sudo systemctl start lab-webapp"

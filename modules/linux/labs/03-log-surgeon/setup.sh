#!/bin/bash
set -euo pipefail

# ────────────────────────────────────────────────────────────────
# Lab 03: Log Surgeon
# No root needed
# ────────────────────────────────────────────────────────────────

LAB_DIR="$HOME/sandbox/lab-logs"

echo "🔧 Setting up Log Surgeon lab..."

rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

# Generate a realistic nginx access log
cat > "$LAB_DIR/access.log" << 'END'
192.168.1.50 - - [15/Feb/2026:08:01:12 +0000] "GET / HTTP/1.1" 200 3421 "-" "Mozilla/5.0"
192.168.1.50 - - [15/Feb/2026:08:01:13 +0000] "GET /css/style.css HTTP/1.1" 200 1234 "http://app.local/" "Mozilla/5.0"
10.0.0.5 - admin [15/Feb/2026:08:02:44 +0000] "POST /api/login HTTP/1.1" 401 89 "-" "curl/7.68.0"
10.0.0.5 - admin [15/Feb/2026:08:02:45 +0000] "POST /api/login HTTP/1.1" 401 89 "-" "curl/7.68.0"
10.0.0.5 - admin [15/Feb/2026:08:02:46 +0000] "POST /api/login HTTP/1.1" 401 89 "-" "curl/7.68.0"
10.0.0.5 - admin [15/Feb/2026:08:02:47 +0000] "POST /api/login HTTP/1.1" 401 89 "-" "curl/7.68.0"
10.0.0.5 - admin [15/Feb/2026:08:02:48 +0000] "POST /api/login HTTP/1.1" 401 89 "-" "curl/7.68.0"
10.0.0.5 - admin [15/Feb/2026:08:02:49 +0000] "POST /api/login HTTP/1.1" 200 512 "-" "curl/7.68.0"
192.168.1.100 - - [15/Feb/2026:08:05:00 +0000] "GET /dashboard HTTP/1.1" 200 8923 "-" "Mozilla/5.0"
192.168.1.100 - - [15/Feb/2026:08:05:01 +0000] "GET /api/users HTTP/1.1" 200 2341 "-" "Mozilla/5.0"
203.0.113.42 - - [15/Feb/2026:08:10:15 +0000] "GET /admin HTTP/1.1" 403 162 "-" "Scrapy/2.5"
203.0.113.42 - - [15/Feb/2026:08:10:16 +0000] "GET /wp-login.php HTTP/1.1" 404 162 "-" "Scrapy/2.5"
203.0.113.42 - - [15/Feb/2026:08:10:17 +0000] "GET /.env HTTP/1.1" 404 162 "-" "Scrapy/2.5"
203.0.113.42 - - [15/Feb/2026:08:10:18 +0000] "POST /xmlrpc.php HTTP/1.1" 404 162 "-" "Scrapy/2.5"
172.16.0.10 - - [15/Feb/2026:09:00:00 +0000] "GET /health HTTP/1.1" 200 2 "-" "kube-probe/1.28"
172.16.0.10 - - [15/Feb/2026:09:00:30 +0000] "GET /health HTTP/1.1" 200 2 "-" "kube-probe/1.28"
172.16.0.10 - - [15/Feb/2026:09:01:00 +0000] "GET /health HTTP/1.1" 200 2 "-" "kube-probe/1.28"
172.16.0.10 - - [15/Feb/2026:09:01:30 +0000] "GET /health HTTP/1.1" 200 2 "-" "kube-probe/1.28"
192.168.1.50 - - [15/Feb/2026:09:15:22 +0000] "POST /api/upload HTTP/1.1" 500 341 "-" "Mozilla/5.0"
192.168.1.100 - - [15/Feb/2026:09:20:00 +0000] "GET /api/reports?from=2026-01-01&to=2026-02-01 HTTP/1.1" 200 45123 "-" "Mozilla/5.0"
10.0.0.8 - - [15/Feb/2026:09:30:00 +0000] "DELETE /api/users/42 HTTP/1.1" 204 0 "-" "PostmanRuntime/7.29"
10.0.0.5 - admin [15/Feb/2026:10:00:00 +0000] "POST /api/login HTTP/1.1" 401 89 "-" "python-requests/2.28"
10.0.0.5 - admin [15/Feb/2026:10:00:01 +0000] "POST /api/login HTTP/1.1" 401 89 "-" "python-requests/2.28"
10.0.0.5 - admin [15/Feb/2026:10:00:02 +0000] "POST /api/login HTTP/1.1" 401 89 "-" "python-requests/2.28"
192.168.1.200 - - [15/Feb/2026:10:30:00 +0000] "GET /api/search?q='; DROP TABLE users;-- HTTP/1.1" 400 120 "-" "Mozilla/5.0"
END

# Generate an application log with mixed severity
cat > "$LAB_DIR/app.log" << 'END'
2026-02-15 08:00:01 [INFO] Application starting on port 3000
2026-02-15 08:00:02 [INFO] Connected to database postgres://db.internal:5432/app
2026-02-15 08:00:02 [INFO] Redis connection established at redis.internal:6379
2026-02-15 08:00:03 [INFO] Loading configuration from /etc/app/config.yaml
2026-02-15 08:00:03 [WARN] Config key 'session_timeout' not set, using default: 3600
2026-02-15 08:00:03 [WARN] Deprecated API endpoint /v1/users still enabled
2026-02-15 08:00:05 [INFO] Application ready. Accepting connections.
2026-02-15 08:02:45 [ERROR] Authentication failed for user 'admin' from 10.0.0.5 - invalid password
2026-02-15 08:02:46 [ERROR] Authentication failed for user 'admin' from 10.0.0.5 - invalid password
2026-02-15 08:02:47 [ERROR] Authentication failed for user 'admin' from 10.0.0.5 - invalid password
2026-02-15 08:02:48 [ERROR] Authentication failed for user 'admin' from 10.0.0.5 - invalid password
2026-02-15 08:02:49 [ERROR] Authentication failed for user 'admin' from 10.0.0.5 - account locked after 5 attempts
2026-02-15 08:05:01 [INFO] User 'jsmith' accessed /api/users - 23 records returned
2026-02-15 08:10:15 [WARN] Blocked request from 203.0.113.42 - known scanner
2026-02-15 09:15:22 [ERROR] Upload failed: file size exceeds limit (52428800 bytes)
2026-02-15 09:15:22 [ERROR] Stack trace:
2026-02-15 09:15:22 [ERROR]   at FileHandler.validate (/app/src/handlers/upload.js:42)
2026-02-15 09:15:22 [ERROR]   at Router.handle (/app/node_modules/express/lib/router.js:178)
2026-02-15 09:15:22 [ERROR]   at processTicksAndRejections (internal/process/task_queues.js:95)
2026-02-15 09:30:00 [WARN] User 'admin-api' deleted user ID 42 via API
2026-02-15 10:00:00 [ERROR] Authentication failed for user 'admin' from 10.0.0.5 - account still locked
2026-02-15 10:00:01 [ERROR] Authentication failed for user 'admin' from 10.0.0.5 - account still locked
2026-02-15 10:00:02 [ERROR] Authentication failed for user 'admin' from 10.0.0.5 - account still locked
2026-02-15 10:30:00 [CRITICAL] SQL injection attempt detected from 192.168.1.200: '; DROP TABLE users;--
2026-02-15 10:30:00 [INFO] Request blocked by WAF rule SQL-001
2026-02-15 11:00:00 [INFO] Scheduled backup started
2026-02-15 11:05:32 [INFO] Backup completed: 2.3GB written to s3://backups/2026-02-15/
2026-02-15 11:30:00 [WARN] Memory usage at 85% (6.8GB / 8GB)
2026-02-15 12:00:00 [WARN] Memory usage at 91% (7.3GB / 8GB)
2026-02-15 12:15:00 [ERROR] OutOfMemoryError: heap space exhausted
2026-02-15 12:15:00 [ERROR] Application crashed. Restarting...
2026-02-15 12:15:05 [INFO] Application starting on port 3000
2026-02-15 12:15:06 [INFO] Application ready. Accepting connections.
END

# Generate auth log
cat > "$LAB_DIR/auth.log" << 'END'
Feb 15 07:55:00 webserver sshd[1234]: Accepted publickey for juanes from 192.168.1.50 port 54321 ssh2
Feb 15 08:02:44 webserver sshd[1240]: Failed password for admin from 10.0.0.5 port 33201 ssh2
Feb 15 08:02:45 webserver sshd[1241]: Failed password for admin from 10.0.0.5 port 33202 ssh2
Feb 15 08:02:46 webserver sshd[1242]: Failed password for admin from 10.0.0.5 port 33203 ssh2
Feb 15 08:02:47 webserver sshd[1243]: Failed password for invalid user root from 10.0.0.5 port 33204 ssh2
Feb 15 08:02:48 webserver sshd[1244]: Failed password for invalid user root from 10.0.0.5 port 33205 ssh2
Feb 15 08:10:00 webserver sudo: juanes : TTY=pts/0 ; PWD=/home/juanes ; USER=root ; COMMAND=/bin/systemctl restart nginx
Feb 15 09:30:00 webserver sudo: admin-api : TTY=unknown ; PWD=/app ; USER=root ; COMMAND=/usr/bin/userdel user42
Feb 15 10:00:00 webserver sshd[1250]: Failed password for admin from 10.0.0.5 port 33210 ssh2
Feb 15 10:00:01 webserver sshd[1251]: Failed password for admin from 10.0.0.5 port 33211 ssh2
Feb 15 10:00:02 webserver sshd[1252]: Failed password for admin from 10.0.0.5 port 33212 ssh2
Feb 15 14:00:00 webserver sshd[1260]: Accepted publickey for deploy from 172.16.0.5 port 44001 ssh2
Feb 15 14:05:00 webserver sudo: deploy : TTY=unknown ; PWD=/app ; USER=root ; COMMAND=/bin/systemctl restart app
END

echo ""
echo "✅ Lab ready at $LAB_DIR"
echo "   Files: access.log, app.log, auth.log"

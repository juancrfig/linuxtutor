# Lab 07: Broken Service

**Difficulty:** ⭐⭐⭐⭐  
**Time:** 30-40 minutes  
**Topics:** systemd unit files, systemctl, journalctl, service dependencies, debugging failed services

## Scenario

The previous DevOps engineer left a web application service that won't start. There's also a worker service that depends on it. Your job: get both services running and prove you understand how systemd works.

## Setup

```bash
sudo bash labs/07-broken-service/setup.sh
```

## Tasks

### 🔴 Get It Running

**Task 1:** Try to start `lab-webapp.service`. It will fail. Use `systemctl status` and `journalctl` to find out why. List every error you find.

**Task 2:** The unit file has bugs. Find and fix them. Hints:
- Check for typos in target names
- Check if the service user exists
- After fixing the unit file, what command must you run before restarting?

**Task 3:** Even after fixing the unit file, the app still crashes. Check the logs again. The config file has an issue. Find it and fix it.

**Task 4:** Create the service user properly. What kind of user should a service run as? (hint: no login shell, no home directory needed)

**Task 5:** Once `lab-webapp` is running, start `lab-worker`. Verify both are active. Use `curl localhost:8000` to confirm the app responds.

### 🟡 Understanding SystemD

**Task 6:** Read the unit file. Explain each directive:
- What does `After=` vs `Requires=` vs `Wants=` mean?
- What's the difference between `Type=simple` and `Type=forking`?
- What does `Restart=on-failure` do? How is it different from `Restart=always`?
- What does `RestartSec=5` mean?

**Task 7:** Enable `lab-webapp` to start on boot. Then:
- How do you verify it's enabled?
- Where does the symlink get created?
- What target is it linked to?

**Task 8:** Use `systemctl cat lab-webapp` to view the unit. Now use `systemctl edit lab-webapp` to add an override that sets `RestartSec=2` without modifying the original file. Where does the override file live?

### 🟢 Logging & Monitoring

**Task 9:** Using `journalctl`, show:
- All logs from `lab-webapp` since 10 minutes ago
- Follow the logs in real time
- Show only ERROR-level messages
- Show logs from the current boot only

**Task 10:** Stop the webapp. What happens to the worker? Why? Now start just the worker — what happens to the webapp? Explain the dependency behavior.

**Task 11:** Simulate a crash: kill the app process directly with `kill`. Watch what systemd does. How long before it restarts? Check the journal for the restart event.

## Self-Check

```bash
# Both services should be active
systemctl is-active lab-webapp lab-worker

# App should respond
curl -s http://localhost:8000 | python3 -m json.tool

# Service user should exist
id labapp

# Unit file should have no typos
systemd-analyze verify lab-webapp.service 2>&1
```

## Cleanup

```bash
sudo systemctl stop lab-webapp lab-worker
sudo systemctl disable lab-webapp lab-worker 2>/dev/null
sudo rm /etc/systemd/system/lab-webapp.service /etc/systemd/system/lab-worker.service
sudo rm -rf /etc/systemd/system/lab-webapp.service.d
sudo rm -rf /etc/lab-webapp
sudo userdel labapp 2>/dev/null
sudo systemctl daemon-reload
rm -rf ~/sandbox/lab-service
```

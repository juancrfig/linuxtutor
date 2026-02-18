# Lab 02: Process Detective

**Difficulty:** ⭐⭐  
**Time:** 20-25 minutes  
**Topics:** ps, top/htop, kill, nice/renice, lsof, ss, /proc, background jobs

## Scenario

You SSH into a server and users are complaining it's slow. Something is off. Multiple rogue processes are consuming resources, squatting on ports, and generally being annoying. Find them, understand them, fix them.

## Setup

```bash
sudo bash labs/02-process-detective/setup.sh
```

## Tasks

### 🔴 Immediate

**Task 1:** The server feels slow. Use `top` or `htop` to identify the process eating the most CPU. What is it? What's its PID? Kill it gracefully first. If it doesn't die, force-kill it.

**Task 2:** Something is listening on port 8080 where your web app needs to run. Find which process owns that port, identify what it is, and kill it.

**Task 3:** There are ~15 orphan `sleep` processes cluttering the process table. Find all of them (they share a parent). Kill them all in one command.

### 🟡 Investigation

**Task 4:** `df` shows `/tmp` at a certain usage. But a file was deleted and a process still holds it open, consuming space. Find which process, find the file descriptor, and recover the contents of the deleted file.

**Task 5:** There's a `dd` process running with nice value 19. What does that mean? Change its priority to 10 while it's running. Verify the change.

**Task 6:** For the CPU hog you killed in Task 1, find its script on disk. How would you prevent it from being started again? (Don't just delete it — what if it's in cron or a service?)

### 🟢 Deep Dive

**Task 7:** Use `/proc` to investigate any running process:
- Find its exact command line
- Find its current working directory
- Find its environment variables
- Find which files it has open

**Task 8:** Show the full process tree of the system. Identify the parent-child relationships of the lab processes.

## Self-Check

```bash
# CPU hog should be dead
pgrep -f lab-cpu-hog && echo "FAIL: still running" || echo "OK: killed"

# Port 8080 should be free
ss -tlnp | grep 8080 && echo "FAIL: port still occupied" || echo "OK: port free"

# Sleep army should be gone
pgrep -c -f "sleep 3600" && echo "FAIL: sleeps remain" || echo "OK: all killed"

# dd process should be at nice 10
ps -o pid,ni,comm -p $(pgrep -f "dd if=/dev/zero") 2>/dev/null
```

## Cleanup

```bash
# Kill any remaining lab processes
pkill -f lab-cpu-hog; pkill -f lab-deleted-file; pkill -f lab-fork-spawner
pkill -f lab-port-squatter; pkill -f "dd if=/dev/zero"
rm -f /tmp/lab-*.sh
```

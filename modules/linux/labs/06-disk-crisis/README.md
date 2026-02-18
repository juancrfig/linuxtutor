# Lab 06: Disk Crisis

**Difficulty:** ⭐⭐  
**Time:** 20-25 minutes  
**Topics:** df, du, find, ln (hard/soft links), inodes, /etc/fstab, mount, filesystem hierarchy

## Scenario

PagerDuty alert: "Disk usage on webserver at 92%." You have 30 minutes before the app crashes from lack of disk space. Find the bloat, clean it up, and prevent it from happening again.

## Setup

```bash
bash labs/06-disk-crisis/setup.sh
```

## Tasks

### 🔴 Emergency Triage

**Task 1:** Get an overview of disk usage on the system. Which filesystem is most full? How much space is available?

**Task 2:** Find the top 10 largest files under `~/sandbox/lab-disk/`. Use a single command.

**Task 3:** Find the top 5 largest directories (by total contents). Which directory is consuming the most space?

**Task 4:** There's a core dump file wasting space. Find it, verify it's a core dump, and delete it. How much space did you recover?

### 🟡 Investigation

**Task 5:** The `mystery/sessions/` directory has hundreds of tiny files. How many? How much total space? How many inodes are they consuming? Explain why this matters even if the files are small.

**Task 6:** In `data/`, there are three "config" files. One is a hard link, one is a symlink, and one is broken. Identify each. Explain:
- How do you tell a hard link from a regular file?
- What happens to the symlink if you delete the original?
- What happens to the hard link if you delete the original?

**Task 7:** Read `fstab-example`. For each entry, explain:
- What device is being mounted
- Where it's mounted
- What filesystem type
- What the options mean (especially `errors=remount-ro`, `noexec`, `nosuid`, `_netdev`)
- What `dump` and `pass` columns do

### 🟢 Prevention

**Task 8:** Old logs are piling up. Write a `find` command that would delete `.log` files older than 7 days under `/var/log/`. Explain each flag. (Don't actually run it on /var/log — run it against the lab logs.)

**Task 9:** The `data/cache/thumbnails/` directory keeps growing. How would you set up automatic cleanup? Name two approaches (one using cron + find, one using systemd-tmpfiles).

**Task 10:** Explain the Filesystem Hierarchy Standard for these directories. Where would you expect to find:
- Application configuration files
- Variable data and logs
- Third-party software
- Temporary files
- System binaries vs user binaries

## Self-Check

```bash
# Core dump should be gone
find ~/sandbox/lab-disk -name "core.*" -type f && echo "FAIL" || echo "OK: cleaned"

# You should be able to answer: how many inodes do the session files use?
find ~/sandbox/lab-disk/mystery/sessions -type f | wc -l

# Hard link test: same inode number
stat -c "%i" ~/sandbox/lab-disk/app/config.yaml ~/sandbox/lab-disk/data/config-hardlink.yaml

# Broken symlink
file ~/sandbox/lab-disk/data/broken-link.yaml
```

## Cleanup

```bash
rm -rf ~/sandbox/lab-disk
```

# Phase 1: Core Linux Survival — Interview Questions

**How to use:** Answer each question out loud or in writing as if you're in an interview.
Don't just think "I know this" — actually articulate it. That's the gap between knowing and interviewing well.

**Levels:**
- **L1** → Define/explain (screening call)
- **L2** → Apply in context (technical interview)
- **L3** → Debug/troubleshoot (senior-level probing)

---

## 1. Command Line & Text Processing

### L1 — Foundations

**Q1.1.1** What's the difference between `>` and `>>` in bash? What about `2>&1`?

**Q1.1.2** Explain what a pipe (`|`) does. How is it different from redirecting to a file and then reading it?

**Q1.1.3** What's the difference between `grep`, `sed`, and `awk`? When would you reach for each one?

**Q1.1.4** What are environment variables? How do `export`, `env`, and `set` differ?

**Q1.1.5** What's the difference between single quotes, double quotes, and backticks in bash?

### L2 — Applied

**Q1.2.1** You have a 2GB access log. You need to find the top 10 IP addresses by request count. Walk me through your pipeline.

**Q1.2.2** How would you find all files modified in the last 24 hours under `/var/log` that are larger than 10MB?

**Q1.2.3** You need to replace every occurrence of `http://` with `https://` across all `.conf` files in `/etc/nginx/`. How do you do it safely?

**Q1.2.4** Explain what this command does: `cat /var/log/syslog | grep -i error | awk '{print $1, $2, $3}' | sort | uniq -c | sort -rn | head -20`

**Q1.2.5** What's the difference between `find` and `locate`? When would you prefer one over the other?

**Q1.2.6** How do bash aliases and functions differ? Give an example where a function is necessary but an alias wouldn't work.

### L3 — Troubleshooting

**Q1.3.1** A colleague says "grep doesn't work on this file." What are the possible reasons and how do you diagnose?

**Q1.3.2** You run `echo $PATH` and notice a critical directory is missing. Where could it have been removed? Walk me through how you'd trace it.

**Q1.3.3** A cron job runs a script that works perfectly in your interactive shell but fails silently in cron. What are the most likely causes?

**Q1.3.4** You're searching logs with `grep "ERROR" /var/log/app.log` and getting no output, but you know errors happened. What do you check?

---

## 2. Process & System Management

### L1 — Foundations

**Q2.1.1** What's the difference between a process and a thread?

**Q2.1.2** Explain what PID 1 is and why it matters.

**Q2.1.3** What's the difference between `kill`, `kill -9`, and `kill -15`? Which should you try first and why?

**Q2.1.4** What is a zombie process? How does it happen and how do you deal with it?

**Q2.1.5** What does `nohup` do? How is it different from running something in `tmux` or `screen`?

### L2 — Applied

**Q2.2.1** A server is slow. Walk me through how you'd use `top`/`htop` to identify the culprit. What columns do you look at first?

**Q2.2.2** Explain the difference between `nice` and `renice`. Give a real scenario where you'd use each.

**Q2.2.3** How do you find which process is listening on port 8080? Give at least two different approaches.

**Q2.2.4** What's in `/proc`? Name three useful files/directories inside it and what information they provide.

**Q2.2.5** You need to run a data migration that takes 6 hours on a remote server. How do you ensure it survives if your SSH connection drops?

### L3 — Troubleshooting

**Q2.3.1** `systemctl restart nginx` hangs and never returns. How do you diagnose this?

**Q2.3.2** A process is using 100% CPU. You `kill -9` it, but it keeps coming back. What's happening and how do you stop it permanently?

**Q2.3.3** The server's load average is 15.0 on a 4-core machine. CPU usage looks normal in `top`. What else could explain high load?

**Q2.3.4** You see a lot of zombie processes (`Z` state in `ps`). What's happening and how do you fix it without rebooting?

---

## 3. Permissions & Users

### L1 — Foundations

**Q3.1.1** Explain Linux file permissions. What do `rwx` mean for files vs directories?

**Q3.1.2** What's the difference between `chmod 755` and `chmod u+rwx,go+rx`? Which do you prefer and why?

**Q3.1.3** What is `umask`? If the umask is `022`, what permissions will new files and directories have?

**Q3.1.4** What's the difference between `su` and `sudo`? Why is `sudo` preferred?

**Q3.1.5** What are SUID, SGID, and the sticky bit? Give a real example of each.

### L2 — Applied

**Q3.2.1** You need to give a group of developers read/write access to a shared directory, but files created by one developer should be accessible by others in the group. How do you set this up?

**Q3.2.2** How does `/etc/sudoers` work? What's the difference between `ALL=(ALL:ALL) ALL` and `ALL=(ALL:ALL) NOPASSWD: ALL`? When is NOPASSWD acceptable?

**Q3.2.3** Explain the difference between `/etc/passwd` and `/etc/shadow`. Why are they separate?

**Q3.2.4** A new developer joins the team. Walk me through the complete process of setting up their Linux account with appropriate access.

**Q3.2.5** What's the difference between `useradd` and `adduser` on Debian/Ubuntu?

### L3 — Troubleshooting

**Q3.3.1** A user reports "Permission denied" when trying to read a file they should have access to. The file permissions show `644` and they're in the correct group. What do you check?

**Q3.3.2** An application runs as a service user and suddenly can't write to `/var/log/app/`. Nothing changed in file permissions. What could have happened?

**Q3.3.3** You discover a file with permissions `4755` owned by root in `/tmp`. Should you be concerned? Why?

**Q3.3.4** A developer accidentally ran `chmod -R 777 /etc`. What's the immediate impact and how do you recover?

---

## 4. Filesystems

### L1 — Foundations

**Q4.1.1** Explain the Filesystem Hierarchy Standard. What goes in `/etc`, `/var`, `/opt`, `/usr`, `/tmp`, and `/home`?

**Q4.1.2** What's the difference between a hard link and a symbolic link? When would you use each?

**Q4.1.3** What's an inode? What information does it store?

**Q4.1.4** What is `/etc/fstab`? Walk me through what each column means.

**Q4.1.5** What's the difference between `df` and `du`? Why might they show different numbers?

### L2 — Applied

**Q4.2.1** A server's root partition is 95% full. Walk me through how you'd identify what's consuming space and free it up.

**Q4.2.2** Explain the difference between `ext4`, `xfs`, and `btrfs`. Which would you choose for a database server and why?

**Q4.2.3** How do you mount an NFS share? How do you make it persist across reboots?

**Q4.2.4** What happens when a filesystem runs out of inodes but still has free disk space? How do you diagnose and fix this?

**Q4.2.5** You need to add 50GB of storage to a running server. Walk me through the steps from attaching the disk to making it usable.

### L3 — Troubleshooting

**Q4.3.1** `df -h` shows the root filesystem at 100%, but `du -sh /*` totals only 60%. What's going on?

**Q4.3.2** A mount point shows as "read-only" even though `/etc/fstab` says `rw`. What do you check?

**Q4.3.3** You can't unmount a filesystem — it says "target is busy." How do you find what's using it and safely unmount?

**Q4.3.4** After a reboot, a mounted volume didn't come back. The fstab entry looks correct. What do you investigate?

---

## 5. Networking Basics

### L1 — Foundations

**Q5.1.1** Explain the difference between TCP and UDP. Give two real-world examples of each.

**Q5.1.2** What is a subnet mask? What does `192.168.1.0/24` mean?

**Q5.1.3** What's the difference between `ip addr`, `ip route`, and `ip link`?

**Q5.1.4** What are well-known ports? Name 5 common services and their default ports.

**Q5.1.5** What's DNS? Walk me through what happens when you type `google.com` in a browser.

### L2 — Applied

**Q5.2.1** How do you check which ports are open and listening on a server? Show me with `ss`.

**Q5.2.2** What's the difference between `/etc/hosts` and `/etc/resolv.conf`? In what order does Linux resolve hostnames?

**Q5.2.3** You need to test if a remote port is open but `ping` works and the connection still fails. What tools do you use and why is ping insufficient?

**Q5.2.4** Explain what `netcat` (`nc`) is and give three practical uses for it.

**Q5.2.5** How would you capture all HTTP traffic on a server for debugging? What tool do you use and what flags?

### L3 — Troubleshooting

**Q5.3.1** A server can ping `8.8.8.8` but can't resolve `google.com`. Walk me through diagnosis.

**Q5.3.2** An application on port 3000 works locally (`curl localhost:3000`) but external clients can't reach it. What do you check?

**Q5.3.3** Latency to a specific host jumped from 5ms to 500ms. How do you diagnose where the delay is?

**Q5.3.4** Two servers on the same subnet can't communicate. Both have correct IPs. What do you investigate?

---

## 6. SSH

### L1 — Foundations

**Q6.1.1** How does SSH key-based authentication work? Walk me through the handshake.

**Q6.1.2** What's the difference between `~/.ssh/authorized_keys` and `~/.ssh/known_hosts`?

**Q6.1.3** What file permissions should `~/.ssh/` and its contents have? Why does SSH refuse to work if permissions are wrong?

**Q6.1.4** What's an SSH config file (`~/.ssh/config`)? Give an example entry and explain each field.

**Q6.1.5** What's the difference between RSA, ED25519, and ECDSA keys? Which do you recommend today?

### L2 — Applied

**Q6.2.1** Explain SSH tunneling. What's the difference between `-L` (local), `-R` (remote), and `-D` (dynamic) forwarding? Give a real use case for each.

**Q6.2.2** How would you set up SSH so you can reach a server behind a bastion/jump host in a single command?

**Q6.2.3** You need to copy a directory recursively to a remote server. What are your options and which is most efficient?

**Q6.2.4** What settings in `/etc/ssh/sshd_config` would you change to harden an SSH server? Explain each.

**Q6.2.5** How do SSH agent and agent forwarding work? What's the security risk of agent forwarding?

### L3 — Troubleshooting

**Q6.3.1** SSH connection hangs after entering the username. No password prompt appears. What do you check?

**Q6.3.2** You set up key-based auth but SSH still asks for a password. Walk me through debugging this step by step.

**Q6.3.3** After changing `sshd_config`, you can't SSH in anymore. You have physical/console access. How do you recover?

**Q6.3.4** SSH works from one machine but not another, same key, same user. What could differ?

---

## Progress Tracking

Mark questions you can confidently answer in an interview with ✅.
Mark questions you need to review with 🔄.
Mark questions you can't answer at all with ❌.

Goal: All ✅ before moving to Phase 2.

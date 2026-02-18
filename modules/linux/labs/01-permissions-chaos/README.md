# Lab 01: Permissions Chaos

**Difficulty:** ⭐⭐  
**Time:** 20-30 minutes  
**Topics:** chmod, chown, chgrp, SUID/SGID, sticky bit, umask, user/group management  

## Scenario

You just inherited a project directory from an intern who left. The permissions are a mess. Your team lead wants you to fix everything before the security audit tomorrow.

## Setup

```bash
sudo bash labs/01-permissions-chaos/setup.sh
```

## Tasks

### 🔴 Critical (Security)

**Task 1:** The `.env` file contains database credentials and is world-readable. Fix it so only the file owner can read/write it.

**Task 2:** There's a suspicious SUID binary in the project directory. Find it, explain why it's dangerous, and remove the SUID bit.

**Task 3:** The shared `/tmp` directory lets any user delete other users' files. Fix this with the appropriate special permission.

### 🟡 Functional (Team Access)

**Task 4:** The deploy script needs to be executable by `deploy-bot` (ops group). Set ownership to `root:ops` with permissions: owner rwx, group rx, others nothing.

**Task 5:** The shared workspace directory should allow all `developers` group members to read, write, and create files. Files created inside should automatically inherit the group. Set this up properly.

**Task 6:** Bob needs to read the financial report but can't. Fix it so both `alice` and `bob` (as developers) can read it, but no one else.

### 🟢 Best Practices

**Task 7:** Set the project directory's umask so new files are created with `640` (owner rw, group r, others nothing) by default. Verify it works.

**Task 8:** The `config.yaml` should be readable by all developers but only writable by alice. Set it up without changing ownership.

## Self-Check

After completing all tasks, verify:

```bash
# .env should be 600
stat -c "%a %U:%G" /tmp/lab-permissions/project/.env

# No SUID binaries in project
find /tmp/lab-permissions/project -perm -4000

# Sticky bit on shared tmp
stat -c "%a" /tmp/lab-permissions/shared/tmp

# deploy.sh executable by ops
sudo -u deploy-bot test -x /tmp/lab-permissions/deploy/deploy.sh && echo "OK" || echo "FAIL"

# Bob can read financial report
sudo -u bob cat /tmp/lab-permissions/shared/reports/financial.txt

# SGID on shared workspace
stat -c "%a" /tmp/lab-permissions/shared/workspace
```

## Cleanup

```bash
sudo rm -rf /tmp/lab-permissions
sudo userdel -r alice 2>/dev/null; sudo userdel -r bob 2>/dev/null; sudo userdel -r deploy-bot 2>/dev/null
sudo groupdel developers 2>/dev/null; sudo groupdel ops 2>/dev/null
```

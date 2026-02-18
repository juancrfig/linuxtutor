# Lab 05: SSH Lockdown

**Difficulty:** ⭐⭐⭐  
**Time:** 25-30 minutes  
**Topics:** SSH key management, sshd_config hardening, SSH client config, tunneling, debugging

## Scenario

A security auditor flagged your SSH configuration as non-compliant. You need to harden it, fix the client configs, and demonstrate you understand SSH security in depth.

## Setup

```bash
bash labs/05-ssh-lockdown/setup.sh
```

All files at `~/sandbox/lab-ssh/`. **Your real SSH config is NOT modified.**

## Tasks

### 🔴 Harden the Server

**Task 1:** Review `configs/sshd_config_insecure`. List every security issue you find. There are at least 8 problems.

**Task 2:** Create a hardened version at `configs/sshd_config_hardened`. Fix all issues you found. For each change, write a comment explaining WHY (not just what).

**Task 3:** The `keys/` directory has three keypairs. One has a critical permissions issue. Find it, explain why it's dangerous, and fix it.

### 🟡 Fix the Client Config

**Task 4:** Review `configs/ssh_client_broken`. Each host entry has at least one issue or bad practice. Identify and fix them:
- **production:** What's wrong with `StrictHostKeyChecking no`? When (if ever) is it acceptable?
- **staging:** What's the risk with `ForwardAgent yes`? What's the impact of `ServerAliveInterval 0`?
- **Wildcard (`*`):** What does `IdentitiesOnly no` do and why might it cause problems?

**Task 5:** Write a proper SSH client config for this scenario:
- You have a bastion host at `bastion.company.com` (user: `jump`, ED25519 key)
- Behind it: `web01` at `10.0.1.10` and `db01` at `10.0.1.20` (user: `deploy`)
- You should be able to SSH directly to web01/db01 using ProxyJump through the bastion

### 🟢 Tunneling & Advanced

**Task 6:** Explain these SSH commands (don't run them — understand them):
```bash
ssh -L 5432:db.internal:5432 bastion
ssh -R 8080:localhost:3000 public-server
ssh -D 1080 proxy-server
```
For each: What does it do? What's a real-world use case?

**Task 7:** What's the difference between `scp`, `rsync over SSH`, and `sftp`? When would you choose each?

**Task 8:** How does `ssh-agent` work? What problem does it solve? What's the security implication of agent forwarding vs ProxyJump?

## Self-Check

```bash
# Private keys should be 600
stat -c "%a %n" ~/sandbox/lab-ssh/keys/*_ed25519 ~/sandbox/lab-ssh/keys/*_rsa | grep -v pub

# Compare your hardened config with the reference (after you've tried!)
diff ~/sandbox/lab-ssh/configs/sshd_config_hardened ~/sandbox/lab-ssh/configs/.sshd_config_hardened

# Verify you addressed all 8+ issues
grep -c "^#.*WHY\|^#.*because\|^#.*security\|^#.*risk" ~/sandbox/lab-ssh/configs/sshd_config_hardened
```

## Cleanup

```bash
rm -rf ~/sandbox/lab-ssh
```

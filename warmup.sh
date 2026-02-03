#!/usr/bin/env bash
set -euo pipefail

# ────────────────────────────────────────────────────────────────
# CONFIGURATION
# ────────────────────────────────────────────────────────────────

SANDBOX="$HOME/sandbox"
mkdir -p "$SANDBOX"
cd "$SANDBOX" || exit 1

# ────────────────────────────────────────────────────────────────
# SETUP FOR ROGUE USER SCENARIO (runs once – simulate rogue intern)
# ────────────────────────────────────────────────────────────────
# This creates the 'rogue' user if it doesn't exist, adds to sudo,
# and starts a dummy background process as 'rogue' to simulate a "logged-in" session
# User will "discover" and clean it up.
if ! id "rogue" &>/dev/null; then
    sudo adduser --home /home/rogue --shell /bin/bash rogue
    sudo usermod -aG sudo rogue
    sudo -u rogue bash -c "sleep &"  # Simulate a running session/process
fi

# ────────────────────────────────────────────────────────────────
# INTRO – MAN PAGES & SELF-RELIANCE
# ────────────────────────────────────────────────────────────────

clear
cat << "EOF"
=============================================
WELCOME TO THE DEVOPS DAILY WARM-UP
=============================================

Good morning. As you know, AI created Skynet some years ago and humankind had
to ban it. We need to make sure you don't need it to perform. It's only allowed for
Senior engineers.

We do NOT Google or ask AI for commands.
We use the tools the system gives us.

Prove you can find and read information yourself without exiting the terminal for the
following challenges, and you will get the job. Fail, and you're out.
EOF

echo
read -p "Press Enter to accept the challenge and begin..."

clear
cat << "EOF"
Before we throw real tasks at you, two quick tools you must master.
These are how every good engineer finds and understands commands.

1. Finding unknown commands: apropos (or man -k)

   apropos searches the short descriptions of all installed man pages.

   Examples:
     apropos network
     apropos "list contents"

2. Reading man pages: man <command>

   Inside a man page:
   ────────────────────────────────────────────────────────────────
   Key                  Action
   ────────────────────────────────────────────────────────────────
   Space or f           Move forward one full screen
   b                    Move backward one full screen
   j                    Move down one line
   k                    Move up one line
   /word                Search forward for 'word' (e.g. /example or /-r)
   ?word                Search backward for 'word'
   n                    Jump to next search match
   N                    Jump to previous search match
   g                    Jump to the very top of the page
   G                    Jump to the very bottom
   ────────────────────────────────────────────────────────────────
EOF

echo
read -p "Press Enter to start Day 1 of Internship..."

clear
cat <<EOF
Prove you belong here — no hand-holding.

Only press Enter when you have confirmed it's done.

────────────────────────────────────────────────────────────────
 Task 1
────────────────────────────────────────────────────────────────

Before you touch anything, find out  who you really are
on this system. Use four different commands.

Self-check:
- One command shows just your username
- One shows who is currently logged in
- One shows a more detailed view of logged-in users, what they doing, and CPU usage
- One shows your user ID, and groups you belong to

When you have run all four commands and understand the differences
between their outputs,

press Enter to continue...
EOF

# ────────────────────────────── Study hints ─────────────────────────────
# Expected commands & what to understand:
# whoami          → just your current username
# who             → shows logged-in users + terminals + login time
# w               → extended who: includes idle time, what they're running
# id              → uid, gid, groups (very useful for privilege troubleshooting)
# ────────────────────────────────────────────────────────────────────────

read -p ""

clear
cat <<EOF
────────────────────────────────────────────────────────────────
                              Task 2
────────────────────────────────────────────────────────────────

First, some quick Linux gymnastics:
1. Create a temporary user called 'tempuser' with home dir.
2. Ops! Change its username to 'tmpUser'.
3. Create a file owned by this user, and set it to: owner rw, group r, others nothing. Use octal permission modes!
4. Try to read it to confirm you cannot do it.
5. Log in as 'tmpuser' and try to read the file.    
5. Delete the user and its home directory.



Now, we need a user 'layla' later for this week.
Create her with a home directory and a proper shell.

Create three files inside her home directory with these permisions:
1. layla-secret.txt -> (only owner rw)
2. layla-report.txt -> (owner rw, group+others r)
3. layla.script.sh ->  (owner rwx, group, others rx)

Try to read and modify those files as layla, and then as your own user (without sudo), to check the permissions were correctly set. 

She will need to run privileged commands later, add her to the sudo (or wheel) group.

When you finished,
press Enter...
EOF
read -p ""
# ────────────────────── Study hints  ──────────────────────
# Commands sequence:
#   sudo adduser --home /home/tempuser tempuser
#   sudo usermod -l tpmuser tempuser
#   sudo -u tmpuser bash -c "echo 'test' > /home/tempuser2/testfile"
#   sudo chmod 640 /home/tempuser2/testfile
#   ls -l /home/tempuser2/testfile     → should show -rw-r-----
#   sudo deluser --remove-home tempuser2
#   id tempuser2                       → no such user
# Understand:
#   - usermod -l changes login name (careful: doesn't rename home dir automatically)
#   - 640 = rw- r-- ---   (common for config files group-readable)
#   - deluser --remove-home cleans up properly
# ────────────────────────────────────────────────────────────────────────

# ────────────────────── Study hints ──────────────────────
# Expected:   sudo adduser alice   (or useradd -m -s /bin/bash alice)
# Verify:     id alice    or   getent passwd alice
# Look for:   home dir, shell=/bin/bash, uid/gid assigned
# ──────────────────────────────────────────────────────────

# ────────────────────────────────────────────────────────────────
# Task 4
# ────────────────────────────────────────────────────────────────
clear

# ────────────────────── Study hints ──────────────────────
# Expected:   sudo usermod -aG sudo alice   (or wheel on some distros)
# Verify:     groups alice
# Understand: -aG = append to group (very important – without -a you overwrite)
# ──────────────────────────────────────────────────────────
read -p ""
cat <<EOF

# ────────────────────────────────────────────────────────────────
# Task 5  Rigue intern scenario
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 5/10
─────────

ALERT! Hold on, intern - security breach! 
I just detected a rigue previous intern who wants revenge because I was too strict.
He still has a user with  sudo permissions on the system, and he's currently logged in!

We need to act fast:
1. Identify who is this user
2. Check who is currently logged in and spot their session
3. Lock the account immediately so he cannot log back in. Confirm the account is locked.
4. Close his connection ASAP (kill all his processes to force logout). Verify no processes remain for that user. 

Do not delete the home directory, we'll preserve it for forensics later. 

When you're done,
press Enter...
EOF

# ────────────────────── Study hints  ──────────────────────
# Recommended safe sequence:
# 1. Lock account:
#    sudo passwd -l rogue          # or sudo usermod -L rogue
#    (alternative: sudo usermod --expiredate 1 rogue)
#
# 2. Verify lock:
#    sudo su - rogue               → should say "Authentication failure" or similar
#
# 3. Kill processes:
#    sudo pkill -u rogue           # polite TERM first
#    # or more forceful:
#    sudo pkill -KILL -u rogue
#    # or by name if needed:
#    sudo killall -u rogue
#
# 4. Verify no processes:
#    ps -u rogue                   → should be empty or "No processes found"
#    pgrep -u rogue                → no output
#
# 5. Confirm home still exists:
#    ls /home/rogue                → should list files (don't delete!)
#
# Key lessons:
#   - Locking prevents re-login faster than killing alone
#   - Killing after lock ensures clean termination
#   - Preserving home dir = critical for real investigations
#   - In production: log every step, notify team, start forensic copy
# ────────────────────────────────────────────────────────────────────────

# ────────────────────── Study hints ──────────────────────
# Expected files & commands:
# /etc/os-release     → PRETTY_NAME= line
# /etc/passwd         → your username line (uid, home, shell)
# /etc/group          → sudo:x:27: or wheel:x:10: line
# ──────────────────────────────────────────────────────────

read -p ""

# ────────────────────────────────────────────────────────────────
# Task 6
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 6/10
─────────

Senior: "Inside day1/ create a file called team-secret.txt
with some fake content (API token or whatever).
Set permissions so ONLY the owner can read or write it."

Self-check (do this!):
1. Check the permissions yourself
2. su - alice (or sudo -u alice cat day1/team-secret.txt)
3. Observe the permission denied message
4. Exit back to your user

Only press Enter when you SAW alice get denied.
EOF

# ────────────────────── Study hints ──────────────────────
# Expected:   echo "secret=xyz123" > day1/team-secret.txt
#             chmod 600 day1/team-secret.txt
# Verify as alice:   Permission denied
# ──────────────────────────────────────────────────────────

read -p ""

# ────────────────────────────────────────────────────────────────
# Task 7
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 7/10
─────────

Senior: "Actually… marketing needs to see the token (read-only).
Adjust permissions so everyone can read, but only owner can write."

Self-check:
1. Check new permissions
2. su - alice and try to READ the file (should succeed)
3. Try to write/append as alice (should fail)
4. Exit back

When both tests pass,

press Enter...
EOF

# ────────────────────── Study hints ──────────────────────
# Expected:   chmod 644 day1/team-secret.txt
#             or chmod o+r day1/team-secret.txt
# Verify read:  works as alice
# Verify write: fails as alice
# ──────────────────────────────────────────────────────────

read -p ""

# ────────────────────────────────────────────────────────────────
# Task 8
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 8/10
─────────

Senior hates symbols. Re-apply the same permissions using only numbers.

Self-check: same as Task 7 — read yes / write no as alice.

When done,

press Enter...
EOF

# ────────────────────── Study hints ──────────────────────
# Expected:   chmod 644 day1/team-secret.txt
# Understand: 6 = rw- (owner), 4 = r-- (group & others)
# ──────────────────────────────────────────────────────────

read -p ""

# ────────────────────────────────────────────────────────────────
# Task 9
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 9/10
─────────

Senior: "Before ending the morning, collect these three facts:"

- The system's hostname
- How long it has been running (uptime output)
- Current date/time according to the server

Self-check:
Run each command. Read the output.
Understand what it means in a production context.

When you have them in your head,

press Enter...
EOF

# ────────────────────── Study hints ──────────────────────
# Expected:
# hostname / hostnamectl
# uptime
# date
# Understand: uptime → load averages, users, time since boot
# ──────────────────────────────────────────────────────────

read -p ""

# ────────────────────────────────────────────────────────────────
# Task 10 – Wrap-up
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 10/10 – Good first morning

Senior: "Not bad for day one.
You can leave alice for later exercises (Wednesday will use her),
or clean her up now if you prefer (deluser --remove-home alice).

Your choice.

Day 1 complete.
See you tomorrow — bring coffee."
EOF

echo
read -p "Press Enter to finish Day 1..."
clear

cat <<EOF
═══════════════════════════════════════════
     Kubecraft Daily Warm-up – Day 1 done
═══════════════════════════════════════════

Tomorrow: deeper file system & text wrangling.

Rest well, intern.
EOF

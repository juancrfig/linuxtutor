#!/usr/bin/env bash
set -euo pipefail

# ────────────────────────────────────────────────────────────────
# CONFIGURATION
# ────────────────────────────────────────────────────────────────

SANDBOX="$HOME/sandbox"
mkdir -p "$SANDBOX/day1"
cd "$SANDBOX" || exit 1

# ────────────────────────────────────────────────────────────────
# INTRO – MAN PAGES & SELF-RELIANCE
# ────────────────────────────────────────────────────────────────

clear
cat << "EOF"
=============================================
WELCOME TO THE DEVOPS DAILY WARM-UP
=============================================

Good morning. As you know, AI created Skynet some years ago and humankind had
to ban it. We need to make sure you don't need it to perform. 
It's only allowed for Senior engineers.

We do NOT Google or ask AI for commands.
We use the tools the system gives us.

Prove you can find and read information yourself without exiting the terminal 
while solving the following challenges, and you will get the job. 
Fail, and you're out.
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
   h                    Move to the left
   l                    Move to the right
   /word                Search forward for 'word'
   ?word                Search backward for 'word'
   n                    Jump to next search match
   N                    Jump to previous search match
   g                    Jump to the very top of the page
   G                    Jump to the very bottom
   ────────────────────────────────────────────────────────────────
EOF

echo
read -p "Press Enter when you're ready for the first practice task..."

clear
cat << "EOF"
Excellent. You now know:
- How to find almost any command
- How to navigate and quickly extract useful info from man pages

That's already a massive edge over most beginners.

Let's get to real work.
EOF

echo
read -p "Press Enter to start Day 1 of Internship..."

# ────────────────────────────────────────────────────────────────
# DAY 1 – FIRST MORNING AS KUBECRAFT INTERN
# ────────────────────────────────────────────────────────────────

# ────────────────────────────────────────────────────────────────
# Task 1
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 1/9
─────────

Before you touch anything, find out who you really are
on this system. Use four different commands."

Self-check:
- One command shows just your username.
- One shows who is currently logged in.
- One shows a more detailed view of logged-in users, what they are doing, and CPU usage.
- One shows your user ID, main group, and secondary groups.

When you have run all four commands and understand the differences
between their outputs,
press Enter to continue...
EOF

read -p ""

# ────────────────────────────────────────────────────────────────
# Task 2 – Temporary user
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 2/9
─────────

Let's start with some Linux gymnastics...

1. Create a temporary user called 'tempuser' (with home dir).
2. Ops! Change its username to 'tmpuser', update its home directory as well.
3. Create a file owned by tmpuser, set it to: owner rw, group r, others nothing. 
(Use octal permissions mode).
4. Finally — delete tmpuser completely (including home).

When you have done ALL steps and seen the results,
press Enter...
EOF

read -p ""

# ────────────────────────────────────────────────────────────────
# Task 3 – Persistent user layla
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 3/9
─────────

Now create another user: 'layla'.
Make sure she has  a home directory and proper bash shell.

Then — create three files inside her home directory with these permissions:

1. secret.txt     →  (only owner rw)
2. report.txt     →  (owner rw, group+others r)
3. script.sh      →  (owner rwx, group+others rx)

Self-check you MUST perform:
- Run ls -l in /home/layla and verify all three permissions are correct

Only press Enter when you have tested ALL of this yourself.
EOF

read -p ""

# ────────────────────────────────────────────────────────────────
# Task 4 – Give layla sudo
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 4/9
─────────

Layla will need to run privileged commands later this week.
Add her to the sudo (or wheel) group — the correct way."

Self-check:
- Check layla's groups → confirm sudo/wheel is there
- If missing → fix and check again

When layla is in the sudo group,
press Enter...
EOF

read -p ""

# ────────────────────────────────────────────────────────────────
# Task 5 – Read important /etc files
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 5/9
─────────

Senior: "Back to audit. Look inside these three files without sudo:"

a) What pretty name does this OS/distribution have?
b) Does your own user appear in the users file? Find your line.
c) What is the sudo / wheel group definition?

Self-check:
Read each file. Understand at least one useful line in each.

When you're comfortable with what you saw,

press Enter...
EOF

read -p ""

# ────────────────────────────────────────────────────────────────
# Task 6 – Private file test
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 6/9
─────────

Senior: "Inside day1/ create a file called team-secret.txt
with some fake content (API token or whatever).
Set permissions so ONLY the owner can read or write it."

Self-check (do this!):
1. Check the permissions yourself
2. su - layla (or sudo -u layla cat day1/team-secret.txt)
3. Observe the permission denied message
4. Exit back to your user

Only press Enter when you SAW layla get denied.
EOF

read -p ""

# ────────────────────────────────────────────────────────────────
# Task 7 – Relax permissions
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 7/9
─────────

Senior: "Actually… marketing needs to see the token (read-only).
Adjust permissions so everyone can read, but only owner can write."

Self-check:
1. Check new permissions
2. su - layla and try to READ the file (should succeed)
3. Try to write/append as layla (should fail)
4. Exit back

When both tests pass,

press Enter...
EOF

read -p ""

# ────────────────────────────────────────────────────────────────
# Task 8 – System snapshot
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 8/9
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

read -p ""

# ────────────────────────────────────────────────────────────────
# Task 9 – Wrap-up
# ────────────────────────────────────────────────────────────────
clear
cat <<EOF
Task 9/9 – Good first morning

Senior: "Not bad for day one.
You can leave layla for later exercises (Wednesday will use her),
or clean her up now if you prefer (deluser --remove-home layla).

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

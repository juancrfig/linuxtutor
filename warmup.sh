#!/usr/bin/env bash
set -euo pipefail

SANDBOX="$HOME/sandbox"
mkdir -p "$SANDBOX"
cd "$SANDBOX"

clear
cat << "EOF"
=============================================
WELCOME TO THE DEVOPS INTERN DAILY WARM-UP
=============================================

You've aced the interview rounds... but suddenly the Senior DevOps Engineer enters
the room and says:

"Good morning. As you know, AI created Skynet some years ago and humankind had
to ban it. We need to make sure you don't need it to perform. It's only allowed for
Senior engineers.

We do NOT Google or ask AI for commands.
We use the tools the system gives us.

Prove you can find and read information yourself without exiting the terminal, solve the
following challenges, and you will get the job. Fail, and you're out."
EOF

echo
read -p "Press Enter to accept the challenge and begin..."

clear
cat << "EOF"
Senior softens a bit:

"Relax, intern. Before we throw real tasks at you, two quick tools you must master.
These are how every good engineer finds and understands commands — no external help.

1. Finding unknown commands: apropos (or man -k)

   apropos searches the short descriptions of all installed man pages.

   Examples:
     apropos directory
     apropos "change directory"
     apropos owner          # finds chown, chgrp, etc.
     apropos "ip address"

   Tip: Use quotes for multi-word searches. Be descriptive but not too specific.

2. Reading man pages: man <command>

   Once you have a candidate command, run: man ls    (or man grep, man chmod, etc.)

   Inside a man page (it opens in a pager like 'less'):
   ────────────────────────────────────────────────────────────────
   Key                  Action
   ────────────────────────────────────────────────────────────────
   Space or f           Move forward one full screen
   b                    Move backward one full screen
   Arrow down / Enter   Scroll down one line
   Arrow up             Scroll up one line
   /word                Search forward for 'word' (e.g. /example or /-r)
   ?word                Search backward for 'word'
   n                    Jump to next search match
   N                    Jump to previous search match
   g                    Jump to the very top of the page
   G (shift+g)          Jump to the very bottom
   q                    Quit and return to shell (very important!)
   h                    Show full help / keyboard shortcuts
   ────────────────────────────────────────────────────────────────

   Pro workflow:
   - Open man → immediately type /EXAMPLES   → Enter   (most useful part)
   - Or /SYNOPSIS   → shows syntax & options
   - Or /-r   → find recursive flag, etc.
   - Read EXAMPLES first — they show real usage.
   - q when done.

Practice these now if you want — then we'll do two guided discovery tasks."
EOF

read -p "Press Enter when you're ready for the first practice task..."

clear
cat << "EOF"
Task 1: Discovering how to change directories

Senior: "Imagine you just logged in and forgot how to move to another folder.
You need to find the command that changes your current working directory.

Use apropos (or man -k) with a good keyword like 'directory', 'change directory', or 'working directory'.

When you've found the obvious command (you'll know it when you see it), and maybe peeked at its man page...

...just press Enter to continue. No need to type anything here."
EOF

read -p "Press Enter when ready → "

clear
cat << "EOF"
Task 2: Exploring a man page properly

Senior: "Nice. Now take that command you discovered (the one for changing directory).

Run: man <that-command>

Inside the page:
- Type /EXAMPLES   → press Enter   → look at the first 1–2 examples
- Try /SYNOPSIS   → see the general format
- Try searching for a word like 'parent' or 'home' if curious

Once you've navigated around a bit and read at least one example...

...press Enter here to move on. Nothing to type."
EOF

read -p "Press Enter when you've explored the man page → "

clear
cat << "EOF"
Senior: "Excellent.

You now know:
- How to find almost any command with apropos / man -k
- How to navigate and quickly extract useful info from man pages

That's already a massive edge over most beginners.

Warm-up complete. Let's get to real work."
echo
echo "Beginning Day 1: Monday – Orientation & Access Basics"
sleep 3

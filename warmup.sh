#!/usr/bin/env bash
set -euo pipefail

SANDBOX="$HOME/sandbox"
mkdir -p "$SANDBOX"
cd "$SANDBOX"

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
   h                    Move left (when horizontal scrolling is available)
   l                    Move right (when horizontal scrolling is available)
   /word                Search forward for 'word' (e.g. /example or /-r)
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

Warm-up complete. Let's get to real work.
EOF

echo
read -p "Press Enter to start Day 1 of Internship..."


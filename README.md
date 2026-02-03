# DevOps Intern Daily Warm-Up

A terminal-based daily review tool to build Linux muscle memory for aspiring DevOps engineers.  
Focused on the **80/20 rule**: only the commands and concepts that deliver 80% of real-world value, curated by my mentor [Mischa](https://x.com/mischavdburg). No fluff, no rarely-used trivia—just the essentials you need to be effective fast.

## The Story

You’re in the final interview for a DevOps intern role.  
You’ve aced the technical rounds, but right before the offer, the Senior DevOps Engineer walks in with a warning:

> AI once tried to take over and build Skynet, so it’s banned for juniors.  
> Prove you can solve problems using only the terminal’s built-in tools. No Google, no AI.  
> Pass the daily challenges, and the job is yours.

The run starts with this high-stakes intro, then drops you into a 5-day work week of escalating tasks.  
The Senior throws realistic problems at you; you solve them using man pages, apropos, and experimentation.  
State persists across days (users you create, files you modify, logs that accumulate), so concepts connect and "click" like in a real system.

## Current Status (v0.1 – First Commit)

- Man pages & discovery warm-up fully implemented (5 tasks forcing apropos, man navigation, no spoilers).
- More days will be added as I progress through Mischa's course.

***

## How to Use

1. Make the script executable: `chmod +x warmup.sh`
2. Run it (anytime—it's your daily morning ritual): `./warmup.sh`

The script creates and uses a persistent sandbox at `~/sandbox`.
Do NOT run as root (practice as a normal user with sudo when needed).

### Contributing / Feedback
This is my personal daily warm-up—feel free to fork, star, or open issues.
[You can find me on X](https://x.com/juancrfig) and share your thoughts if you find it useful. 

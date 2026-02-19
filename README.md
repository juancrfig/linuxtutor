# DevOps Interview Prep

**Nail DevOps interviews. Build production-ready skills. Get hired.**

Terminal-based training system covering Linux, Docker, and Kubernetes.
Built on the **80/20 rule**: only what makes you hireable.

---

## Quick Start

```bash
git clone <repo>
cd devopstutor

# First session
./drill linux
```

That's it. The system seeds itself on first run.

---

## How to Use This Optimally

### The Daily Loop (15-20 min)

Run `./drill` every day. It presents only the questions due today based on your past ratings — no more, no less.

```
./drill          # Linux questions + optional lab
./drill docker   # Docker questions
```

**Rate honestly.** The spaced repetition engine schedules your next review based on your rating:

| Rating | Meaning | Next review |
|--------|---------|-------------|
| 1 | Forgot completely | Tomorrow |
| 2 | Hard — got it with effort | 2-3 days |
| 3 | Good — solid answer | ~1 week |
| 4 | Easy — nailed it | 2+ weeks |

Inflating ratings cheats yourself. A "3" you don't deserve means you'll forget it before the interview.

**Answer out loud.** Not in your head. Say it like you're in a real interview. The gap between "I know this" and "I can explain it clearly" is where candidates fail.

---

### Weekly Check-in (5 min)

```bash
./drill stats          # Linux progress
./drill stats docker   # Docker progress
```

Look at your `forgot` count from the log. If it's high for a topic, you need more reps — not just more time.

---

### Labs: When and How

Labs simulate broken production systems. Run one after your theory session when you have 20-30 minutes.

```bash
./drill lab            # Linux labs
./drill lab docker     # Docker labs
```

**How a lab session works:**
1. Pick a lab from the numbered list
2. Choose **Start** — this runs the setup script that breaks something
3. Read the scenario (option 2 for full instructions)
4. Fix it using only the terminal (use `man`, not Google)
5. Mark it complete when done

**Linux labs available:**
- `01-permissions-chaos` — broken file permissions (needs sudo)
- `02-process-detective` — zombie/runaway processes
- `03-log-surgeon` — dig through logs to find the issue
- `04-network-diagnosis` — network connectivity problems
- `05-ssh-lockdown` — SSH access issues
- `06-disk-crisis` — disk space emergencies
- `07-broken-service` — systemd service failures (needs sudo)

**Docker labs available:**
- `01-broken-dockerfile` — fix a non-building image
- `02-multi-container` — multi-container app debugging
- `03-volume-persistence` — data persistence issues
- `04-image-diet` — image size optimization

---

### Bootcamp: The Progression Path

The bootcamp is a structured 30-day path through realistic production scenarios. Use it alongside daily drills, not instead of them.

```bash
./bootcamp    # Picks up where you left off
```

Do one bootcamp day per day. It tracks progress automatically. Currently available: Days 1-5 (Linux fundamentals).

---

### Quick Warmup: Command Muscle Memory

When you have 5 minutes and want to stay sharp on syntax:

```bash
./drill quick docker   # Rapid Docker command practice
```

Don't think. Just type. This builds motor memory for commands you'll use in take-home assessments.

---

## Command Reference

```bash
./drill                # Today's Linux SR session + lab prompt
./drill linux          # Same as above
./drill docker         # Docker SR session
./drill lab            # Pick a Linux lab
./drill lab docker     # Pick a Docker lab
./drill stats          # Linux progress overview
./drill stats docker   # Docker progress overview
./drill quick docker   # 5-min Docker command warmup
./bootcamp             # 30-day scenario simulator
```

---

## Structure

```
devopstutor/
├── drill                  # Main entry point for daily sessions
├── bootcamp               # 30-day intensive simulator
├── modules/
│   ├── linux/
│   │   ├── theory.md      # 68 interview questions (L1/L2/L3)
│   │   └── labs/          # 7 hands-on scenarios
│   ├── docker/
│   │   ├── theory.md      # 80+ Docker questions
│   │   ├── quick.sh       # 5-min command practice
│   │   └── labs/          # 4 container scenarios
│   └── kubernetes/        # Coming after Kubecraft
└── progress/
    ├── tracker.json        # Spaced repetition state
    ├── bootcamp-progress.json
    └── drill-log.txt       # Full session history
```

---

## Question Levels

- **L1 (Basic):** Define/explain — screening call level
- **L2 (Applied):** Apply in context — technical interview
- **L3 (Troubleshooting):** Debug real issues — senior-level probing

The drill serves all three levels, weighted toward what you've rated poorly.

---

## Requirements

- Linux environment (Ubuntu/Debian/Arch recommended)
- Docker installed (for Docker module and labs)
- `sudo` access (labs 01 and 07 need it)
- `python3` (for spaced repetition engine)

---

## Roadmap

- [x] Linux module: 68 questions + 7 labs
- [x] Docker module: 80+ questions + 4 labs + quick warmup
- [x] Bootcamp days 1-5 (Linux)
- [ ] Bootcamp days 6-30 (Docker, networking, K8s)
- [ ] Kubernetes module
- [ ] Bash scripting module
- [ ] CI/CD + IaC module

---

Built by [Juanes](https://x.com/juancrfig). Linux syllabus curated with [Mischa](https://x.com/mischavdburg).

**License:** MIT — use it, fork it, learn from it.

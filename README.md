# DevOps Interview Prep

**Nail DevOps interviews. Build production-ready skills. Get hired.**

Terminal-based training system covering Linux, Docker, and Kubernetes.
Built on the **80/20 rule**: only what makes you hireable.

---

## 🚀 Quick Start

```bash
# Daily drill (recommended)
./drill linux

# 5-minute command warmup
./drill quick docker

# 30-day bootcamp (full scenarios)
./bootcamp

# Track your progress
./drill stats
```

---

## 📁 Structure

```
devopstutor/
├── drill               # Daily rotation system
├── bootcamp            # 30-day intensive scenarios
├── warmup              # Original guided tutorial (optional)
├── modules/
│   ├── linux/
│   │   ├── theory.md      # 68 interview questions
│   │   └── labs/          # 7 hands-on scenarios
│   ├── docker/
│   │   ├── theory.md      # 80+ Docker questions
│   │   ├── quick.sh       # 5-min command practice
│   │   └── labs/          # Container scenarios
│   └── kubernetes/
│       └── (coming after Kubecraft)
└── progress/
    └── drill-log.txt      # Your training history
```

---

## 🎯 Training Modes

### 1. Daily Drill (`./drill`)
**Time:** 15-20 minutes/day  
**Focus:** Rotating topics, retention through repetition

- **Monday/Thursday:** Command Line + Process Management
- **Tuesday/Friday:** Permissions + Filesystems
- **Wednesday/Saturday:** Networking + SSH
- **Sunday:** Review all

Each session:
- 6-9 interview questions (answer OUT LOUD)
- 1 hands-on lab
- Self-rating for progress tracking

### 2. Quick Warmup (`./drill quick`)
**Time:** 5 minutes  
**Focus:** Command muscle memory

Rapid-fire command practice. Don't think. Just type. Currently available for Docker, more modules coming.

### 3. Bootcamp Simulator (`./bootcamp`)
**Time:** 30 days (20-40 min/day)  
**Focus:** Realistic production scenarios

30 crisis situations. Fix broken prod systems. Finish all 30 → you're job-ready.

**Currently available:** Days 1-5 (Linux fundamentals)  
**Coming soon:** Days 6-30 (Docker, networking, K8s, multi-service debugging)

---

## 📚 Modules

### ✅ Linux (Phase 1)
- **68 theory questions** across 6 topics
- **7 hands-on labs**: permissions, processes, logs, network, SSH, disk, systemd
- **3 difficulty levels**: L1 (screening), L2 (technical), L3 (troubleshooting)

**Status:** Complete

### ✅ Docker
- **80+ interview questions**: containers, images, volumes, networking, security
- **Quick warmup script**: 6 rounds of command practice
- **Labs:** Broken Dockerfiles, multi-container apps, volume persistence, optimization

**Status:** Theory + warmup done, labs in progress

### 🔄 Kubernetes
**Status:** Coming after Kubecraft completion

---

## 💡 Philosophy

**Answer questions OUT LOUD** like you're in a real interview.  
Don't just think "I know this" — articulate it. That's the gap between knowing and interviewing well.

**Labs simulate broken production systems**, not toy examples.  
Permission nightmares. Zombie processes. Port conflicts. Disk space crises. The stuff you'll actually debug.

**Use `man` pages, not Google.**  
Build self-reliance. Interviews test how you think, not how well you search.

**Track your weak spots.**  
The drill logs everything. Review stats weekly. Double down on what you can't answer confidently.

---

## 📈 Progress Tracking

The system automatically logs:
- Which topics you practiced
- How you rated each session (good/okay/bad)
- Which labs you completed
- Time invested

View anytime with `./drill stats`

---

## 🎓 Question Levels

- **L1 (Basic):** Define/explain — screening call level
- **L2 (Applied):** Apply in context — technical interview  
- **L3 (Troubleshooting):** Debug real issues — senior-level probing

---

## 🗺️ Roadmap

- [x] **Phase 1:** Linux fundamentals
- [x] **Docker module:** Theory + quick warmup
- [ ] **Docker labs:** 4 scenarios
- [ ] **Bootcamp days 6-15:** Advanced Linux + Docker
- [ ] **Kubernetes module:** Theory + labs
- [ ] **Bootcamp days 16-30:** K8s + multi-service debugging
- [ ] **Phase 2:** Bash scripting + automation
- [ ] **Phase 3:** CI/CD + Infrastructure as Code

---

## 🛠️ Requirements

- Linux environment (Ubuntu/Debian/Arch recommended)
- Docker installed (for Docker module)
- `sudo` access (some Linux labs need it)
- `python3` (for progress tracking)

---

## 🤝 Contributing

This is a personal training repo, but if you find bugs or have suggestions, open an issue.

---

Built by [Juanes](https://x.com/juancrfig). Linux syllabus curated with [Mischa](https://x.com/mischavdburg).

**License:** MIT — use it, fork it, learn from it.

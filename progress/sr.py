#!/usr/bin/env python3
"""Spaced repetition engine for DevOpsTutor."""

import json
import sys
import os
import re
from datetime import date, timedelta
from math import ceil

TRACKER_FILE = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'tracker.json')

THEORY_FILES = {
    'linux': os.path.join(os.path.dirname(os.path.abspath(__file__)),
                          '..', 'modules', 'linux', 'theory', 'phase1-core.md'),
    'docker': os.path.join(os.path.dirname(os.path.abspath(__file__)),
                           '..', 'modules', 'docker', 'theory.md'),
}

LAB_DIRS = {
    'linux': os.path.join(os.path.dirname(os.path.abspath(__file__)),
                          '..', 'modules', 'linux', 'labs'),
}


# ── JSON helpers ────────────────────────────────────────────────

def load_tracker():
    if os.path.exists(TRACKER_FILE):
        with open(TRACKER_FILE) as f:
            return json.load(f)
    return {"version": 2}


def save_tracker(data):
    with open(TRACKER_FILE, 'w') as f:
        json.dump(data, f, indent=2)


# ── Question parsing ─────────────────────────────────────────────

def parse_questions(module):
    """Return dict of {qid: question_text} from the theory file."""
    path = THEORY_FILES.get(module)
    if not path or not os.path.exists(path):
        return {}
    questions = {}
    with open(path) as f:
        for line in f:
            m = re.match(r'\*\*(Q[\d.]+)\*\*\s+(.*)', line.strip())
            if m:
                questions[m.group(1)] = m.group(2)
    return questions


def parse_labs(module):
    """Return list of lab directory names for a module."""
    lab_dir = LAB_DIRS.get(module)
    if not lab_dir or not os.path.exists(lab_dir):
        return []
    return sorted(
        d for d in os.listdir(lab_dir)
        if os.path.isdir(os.path.join(lab_dir, d))
    )


# ── SR card helpers ──────────────────────────────────────────────

def new_card():
    return {
        "interval": 0,
        "ease": 2.5,
        "due": date.today().isoformat(),
        "reps": 0,
        "status": "new"
    }


def new_lab_entry():
    return {"completed": False, "attempts": 0, "last_attempt": None, "notes": ""}


# ── Commands ─────────────────────────────────────────────────────

def cmd_init(module='linux'):
    """Seed tracker.json with all questions and labs for a module."""
    tracker = load_tracker()
    tracker.setdefault("version", 2)
    tracker.setdefault(module, {"questions": {}, "labs": {}})

    q_data = tracker[module].setdefault("questions", {})
    questions = parse_questions(module)
    added = 0
    for qid in questions:
        if qid not in q_data:
            q_data[qid] = new_card()
            added += 1

    lab_data = tracker[module].setdefault("labs", {})
    labs = parse_labs(module)
    for lab in labs:
        if lab not in lab_data:
            lab_data[lab] = new_lab_entry()

    save_tracker(tracker)
    print(f"[sr] {module}: +{added} questions, {len(q_data)} total, {len(lab_data)} labs tracked.",
          file=sys.stderr)


def cmd_due(module='linux', new_per_day=5):
    """Print JSON array of questions due today + new introductions."""
    tracker = load_tracker()
    if module not in tracker or not tracker[module].get("questions"):
        cmd_init(module)
        tracker = load_tracker()

    today = date.today().isoformat()
    q_data = tracker[module]["questions"]
    all_questions = parse_questions(module)

    due = [
        qid for qid, d in q_data.items()
        if d["status"] != "new" and d["due"] <= today
    ]

    new_cards = [qid for qid, d in q_data.items() if d["status"] == "new"]
    introduce = new_cards[:new_per_day]

    result = []
    for qid in due + introduce:
        text = all_questions.get(qid, "")
        if text:
            result.append({
                "id": qid,
                "text": text,
                "status": q_data[qid]["status"]
            })

    print(json.dumps(result))


def cmd_rate(qid, rating, module='linux'):
    """Update SR data for a question after a review.

    rating: 1=again, 2=hard, 3=good, 4=easy
    """
    tracker = load_tracker()
    if module not in tracker or qid not in tracker[module].get("questions", {}):
        print(f"[sr] Question {qid} not found in {module}", file=sys.stderr)
        sys.exit(1)

    card = tracker[module]["questions"][qid]
    rating = int(rating)
    today = date.today()
    interval = card["interval"]
    ease = card["ease"]
    reps = card["reps"]

    if rating == 1:  # again — forgot it
        interval = 1
        ease = max(1.3, ease - 0.2)
        status = "learning"
    else:
        if reps == 0:  # first time seeing it
            interval = 4 if rating == 4 else 1
        else:
            if rating == 2:  # hard
                interval = max(1, ceil(interval * 1.2))
                ease = max(1.3, ease - 0.15)
            elif rating == 3:  # good
                interval = max(1, ceil(interval * ease))
            else:  # easy
                interval = max(1, ceil(interval * ease * 1.3))
                ease += 0.15

        if interval > 21:
            status = "mastered"
        elif reps == 0:
            status = "learning"
        else:
            status = "review"

    card["interval"] = interval
    card["ease"] = round(ease, 2)
    card["due"] = (today + timedelta(days=interval)).isoformat()
    card["reps"] = reps + 1
    card["status"] = status

    save_tracker(tracker)


def cmd_stats(module='linux'):
    """Print JSON object with counts: new, learning, review, mastered, due_today, total."""
    tracker = load_tracker()
    if module not in tracker:
        print(json.dumps({"new": 0, "learning": 0, "review": 0, "mastered": 0,
                          "due_today": 0, "total": 0}))
        return

    today = date.today().isoformat()
    q_data = tracker[module].get("questions", {})
    counts = {"new": 0, "learning": 0, "review": 0, "mastered": 0}
    due_today = 0

    for d in q_data.values():
        status = d.get("status", "new")
        counts[status] = counts.get(status, 0) + 1
        if status != "new" and d.get("due", "") <= today:
            due_today += 1

    counts["due_today"] = due_today
    counts["total"] = len(q_data)
    print(json.dumps(counts))


def cmd_lab_done(lab, module='linux'):
    """Mark a lab as completed."""
    tracker = load_tracker()
    tracker.setdefault(module, {"questions": {}, "labs": {}})
    lab_data = tracker[module].setdefault("labs", {})
    entry = lab_data.setdefault(lab, new_lab_entry())
    entry["completed"] = True
    entry["attempts"] = entry.get("attempts", 0) + 1
    entry["last_attempt"] = date.today().isoformat()
    save_tracker(tracker)
    print(f"[sr] Lab '{lab}' marked complete.", file=sys.stderr)


def cmd_lab_stats(module='linux'):
    """Print JSON with lab completion summary."""
    tracker = load_tracker()
    if module not in tracker:
        print(json.dumps({}))
        return
    print(json.dumps(tracker[module].get("labs", {})))


# ── Entry point ──────────────────────────────────────────────────

if __name__ == '__main__':
    args = sys.argv[1:]
    if not args:
        print("Usage: sr.py <command> [args...]")
        print("  init   <module>                 — seed tracker with questions")
        print("  due    <module> [new_per_day]   — list due + new questions (JSON)")
        print("  rate   <qid> <1-4> <module>     — record answer quality")
        print("  stats  <module>                 — SR counts (JSON)")
        print("  lab-done <lab> <module>         — mark lab complete")
        print("  lab-stats <module>              — lab completion (JSON)")
        sys.exit(0)

    cmd = args[0]

    if cmd == 'init':
        cmd_init(args[1] if len(args) > 1 else 'linux')
    elif cmd == 'due':
        module = args[1] if len(args) > 1 else 'linux'
        new_per_day = int(args[2]) if len(args) > 2 else 5
        cmd_due(module, new_per_day)
    elif cmd == 'rate':
        if len(args) < 3:
            print("Usage: sr.py rate <qid> <1-4> [module]", file=sys.stderr)
            sys.exit(1)
        cmd_rate(args[1], args[2], args[3] if len(args) > 3 else 'linux')
    elif cmd == 'stats':
        cmd_stats(args[1] if len(args) > 1 else 'linux')
    elif cmd == 'lab-done':
        if len(args) < 2:
            print("Usage: sr.py lab-done <lab> [module]", file=sys.stderr)
            sys.exit(1)
        cmd_lab_done(args[1], args[2] if len(args) > 2 else 'linux')
    elif cmd == 'lab-stats':
        cmd_lab_stats(args[1] if len(args) > 1 else 'linux')
    else:
        print(f"Unknown command: {cmd}", file=sys.stderr)
        sys.exit(1)

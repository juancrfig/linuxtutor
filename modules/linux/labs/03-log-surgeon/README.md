# Lab 03: Log Surgeon

**Difficulty:** ⭐⭐⭐  
**Time:** 25-35 minutes  
**Topics:** grep, sed, awk, cut, sort, uniq, pipes, regex, text processing pipelines

## Scenario

It's Monday morning. The weekend on-call engineer left you three log files and a note: "Something weird happened over the weekend. I didn't have time to investigate. Figure it out."

Your job: analyze these logs, find the incidents, and write a brief incident summary.

## Setup

```bash
bash labs/03-log-surgeon/setup.sh
```

All files are at `~/sandbox/lab-logs/`.

## Tasks

### 🔴 Incident Detection

**Task 1:** Find all unique IP addresses in `access.log`. How many distinct IPs accessed the server?

**Task 2:** Find the top 3 IPs by number of requests. Which one looks suspicious and why?

**Task 3:** Someone tried to brute-force the login. Using `access.log`, find:
- Which IP did it
- How many failed attempts (401s)
- Did they eventually succeed? (look for a 200 on the same endpoint)

**Task 4:** There's a scanner probing for vulnerabilities. Find all 404 responses and identify the scanner's IP and user agent.

### 🟡 Deep Analysis

**Task 5:** From `app.log`, extract all ERROR lines and count them by hour. Which hour had the most errors?

**Task 6:** The app crashed due to memory exhaustion. Using `app.log`, trace the timeline:
- When did memory warnings start?
- What was the progression (percentage)?
- When did it crash?
- When did it recover?

**Task 7:** Cross-reference `auth.log` and `access.log`. The IP `10.0.0.5` appears in both. Build a timeline of everything this IP did across both logs. Use a single pipeline.

**Task 8:** Find all `sudo` commands executed from `auth.log`. Format the output as: `TIME | USER | COMMAND` using awk or sed.

### 🟢 Pipeline Mastery

**Task 9:** Write a one-liner that extracts all unique URLs (paths) from `access.log`, sorted by frequency, excluding health checks (`/health`).

**Task 10:** Extract the total bytes served from `access.log` (the number after the HTTP status code). Calculate the sum. Hint: `awk` can do math.

**Task 11:** Create a "security summary" with a single pipeline that shows:
- Number of failed login attempts (401s)
- Number of blocked requests (403s)
- Number of server errors (5xx)
- The SQL injection attempt details

**Task 12:** Using `sed`, sanitize `app.log` by replacing all IP addresses with `[REDACTED]` and write the result to `app-sanitized.log`.

## Self-Check

```bash
# Task 1: Should find 6 unique IPs
grep -oE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' ~/sandbox/lab-logs/access.log | sort -u | wc -l

# Task 3: 10.0.0.5 should have 5 failed + 1 success (first wave) + 3 failed (second wave)

# Task 10: Total bytes should be calculable with:
# awk '{sum += $10} END {print sum}' ~/sandbox/lab-logs/access.log
```

## Cleanup

```bash
rm -rf ~/sandbox/lab-logs
```

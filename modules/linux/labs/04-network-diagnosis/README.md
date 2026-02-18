# Lab 04: Network Diagnosis

**Difficulty:** ⭐⭐⭐  
**Time:** 25-30 minutes  
**Topics:** ip, ss, ping, traceroute, curl, dig, netcat, tcpdump, /etc/hosts, /etc/resolv.conf

## Scenario

You're on-call and multiple alerts are firing. The app team says "everything is broken." Time to figure out what's actually wrong by systematically checking the network stack.

## Setup

```bash
bash labs/04-network-diagnosis/setup.sh
```

## Tasks

### 🔴 Quick Triage

**Task 1:** Map the current network state of this machine:
- List all network interfaces and their IPs
- Show the default gateway
- Show the routing table
- What DNS servers are configured?

**Task 2:** List all ports currently listening on this machine. Identify:
- Which services are listening on `0.0.0.0` (all interfaces) vs `127.0.0.1` (localhost only)
- Why does this distinction matter for security?

**Task 3:** Port 3306 (MySQL) is listening on `0.0.0.0`. This is a security issue — it should only listen on localhost. Without modifying the process, explain what firewall rule you'd add to block external access.

### 🟡 Connectivity Debugging

**Task 4:** Use `curl` to hit the slow server at `http://127.0.0.1:9090`. Measure how long it takes. Use curl's timing features to break down where the time is spent (DNS, connect, transfer).

**Task 5:** Use `netcat` to:
- Test if port 9090 is open
- Test if port 8443 is open
- Send a raw HTTP GET request to the slow server manually

**Task 6:** Look at `~/sandbox/lab-network/resolv-broken.conf`. Identify what's wrong with it. What symptoms would a server with this config show?

### 🟢 DNS & Advanced

**Task 7:** Use `dig` to query:
- The A record for `google.com`
- The MX records for `gmail.com`
- The NS records for `cloudflare.com`
- Explain each record type

**Task 8:** What is the file `/etc/nsswitch.conf` and how does it relate to DNS resolution? What does the `hosts:` line typically look like and what does each entry mean?

**Task 9:** Without using `tcpdump`, figure out all established TCP connections on this machine right now. Show the local address, remote address, and state for each.

**Task 10:** Using `curl`, make requests to these URLs and explain the HTTP status codes you get:
```bash
curl -I https://httpstat.us/200
curl -I https://httpstat.us/301
curl -I https://httpstat.us/403
curl -I https://httpstat.us/500
curl -I https://httpstat.us/503
```
What does each status code mean in real-world terms?

## Self-Check

```bash
# Task 1: You should be able to answer these from memory after doing them:
# - What command shows interfaces? (ip addr / ip a)
# - What command shows routes? (ip route)
# - Where is DNS config? (/etc/resolv.conf)

# Task 2: Verify you found all listeners
ss -tlnp | wc -l  # Compare with your findings

# Task 4: curl timing should show ~3 seconds in TTFB
```

## Cleanup

```bash
pkill -f slow-server.py
pkill -f "bind.*3306"
pkill -f "bind.*6379"
rm -rf ~/sandbox/lab-network
```

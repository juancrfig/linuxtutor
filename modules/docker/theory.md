# Docker — Interview Questions

**How to use:** Answer each question out loud or in writing as if you're in an interview.

**Levels:**
- **L1** → Define/explain (screening call)
- **L2** → Apply in context (technical interview)
- **L3** → Debug/troubleshoot (senior-level probing)

---

## 1. Container Fundamentals

### L1 — Foundations

**Q1.1.1** What's the difference between a container and a virtual machine?

**Q1.1.2** Explain what a Docker image is. How is it different from a container?

**Q1.1.3** What does `docker run -d` do? What about `-it`? When would you use each?

**Q1.1.4** Why should you always specify image tags in production? What's wrong with using `latest`?

**Q1.1.5** What's the difference between `docker stop` and `docker kill`?

### L2 — Applied

**Q1.2.1** You run `docker ps` and see 15 exited containers. How do you clean them up? What command removes all stopped containers at once?

**Q1.2.2** Explain the `--rm` flag. Give a scenario where you'd use it and one where you wouldn't.

**Q1.2.3** A developer says "the container works on my machine but not in production." What are the most common causes?

**Q1.2.4** How do you see the logs of a container that exited 10 minutes ago?

**Q1.2.5** What's the difference between `docker exec` and `docker attach`? When would you use each?

### L3 — Troubleshooting

**Q1.3.1** A container starts then immediately exits with code 137. What does that mean and how do you diagnose it?

**Q1.3.2** You run `docker run nginx` but can't access it on `localhost:80`. The container is running. What do you check?

**Q1.3.3** `docker ps` shows a container as "(unhealthy)". How do you investigate what's failing?

**Q1.3.4** A container won't stop — `docker stop` hangs for 10+ seconds then times out. What's happening and how do you fix it?

---

## 2. Networking & Ports

### L1 — Foundations

**Q2.1.1** What does `-p 8080:80` mean in `docker run -p 8080:80 nginx`?

**Q2.1.2** Can multiple containers listen on the same port inside their own network? What about exposing them to the host?

**Q2.1.3** What's the difference between `EXPOSE 80` in a Dockerfile and `-p 80:80` when running?

**Q2.1.4** What is a Docker network? Name three default network types.

**Q2.1.5** How do containers on the same network communicate with each other?

### L2 — Applied

**Q2.2.1** You have a web app container and a database container. How do you connect them without hardcoding IPs?

**Q2.2.2** Explain what happens when you run `docker run -p 3000:3000 -p 3001:3001 myapp`. How many ports are exposed?

**Q2.2.3** A containerized app needs to call an API running on the host machine. How do you reference the host from inside the container?

**Q2.2.4** What's the difference between bridge, host, and none network modes? Give a use case for each.

### L3 — Troubleshooting

**Q2.3.1** Two containers can't communicate even though they're on the same custom network. What do you check?

**Q2.3.2** You mapped port 80 but `curl localhost:80` times out. The container logs show the app is listening. What's wrong?

**Q2.3.3** A container needs to access another service via `localhost:5432` but that port is inside a different container. How do you fix this?

---

## 3. Images & Dockerfile

### L1 — Foundations

**Q3.1.1** What's the difference between `FROM`, `RUN`, `CMD`, and `ENTRYPOINT` in a Dockerfile?

**Q3.1.2** Explain Docker layers. Why does the order of instructions in a Dockerfile matter?

**Q3.1.3** What does `COPY . .` do? How is it different from `COPY ./ /app/`?

**Q3.1.4** What is `WORKDIR`? Why use it instead of `RUN cd /app`?

**Q3.1.5** What's a `.dockerignore` file? Why do you need it?

### L2 — Applied

**Q3.2.1** You changed one line of code and rebuilt the image. Docker re-runs all 15 layers. How do you optimize the Dockerfile to use cache better?

**Q3.2.2** Explain multi-stage builds. Give a real example where you'd use one.

**Q3.2.3** Your image is 1.2GB. How do you reduce it? Name three strategies.

**Q3.2.4** What's the difference between `CMD ["node", "server.js"]` and `CMD node server.js`? Which should you use?

**Q3.2.5** How do you pass environment variables at build time vs runtime?

### L3 — Troubleshooting

**Q3.3.1** `docker build` fails with "COPY failed: no source files found". What's the likely cause?

**Q3.3.2** Your Dockerfile has `RUN npm install` but packages aren't installed in the final image. Why?

**Q3.3.3** A container built from your image works locally but crashes in production with "permission denied". What do you check?

**Q3.3.4** You updated the Dockerfile but `docker build` uses old cached layers. How do you force a fresh build?

---

## 4. Volumes & Data Persistence

### L1 — Foundations

**Q4.1.1** Why do containers lose data when they're deleted? How do volumes solve this?

**Q4.1.2** What's the difference between a named volume and a bind mount?

**Q4.1.3** Explain what `-v mydata:/data` does.

**Q4.1.4** How do you list all volumes? How do you see which containers are using a volume?

**Q4.1.5** What's the difference between `docker volume rm` and `docker volume prune`?

### L2 — Applied

**Q4.2.1** You need a database container where data survives container restarts and deletions. How do you set this up?

**Q4.2.2** A developer wants to edit code on their laptop and see changes instantly in the container. What do you use?

**Q4.2.3** You have a volume with 50GB of data. How do you back it up?

**Q4.2.4** What's the security risk of bind-mounting `/` into a container?

**Q4.2.5** Explain the difference between `$(pwd):/app` and `./data:/data` when bind mounting.

### L3 — Troubleshooting

**Q4.3.1** A container can't write to a bind-mounted directory. Logs show "permission denied". What's happening?

**Q4.3.2** You deleted a container but the volume still exists and takes up 10GB. How do you find and remove it?

**Q4.3.3** Data you wrote to a container disappeared after restart. You thought you used a volume. How do you verify?

---

## 5. Environment Variables & Secrets

### L1 — Foundations

**Q5.1.1** How do you pass an environment variable to a container at runtime?

**Q5.1.2** What's the problem with `docker run -e DB_PASSWORD=secret123 postgres`?

**Q5.1.3** What's an `--env-file`? When would you use it?

**Q5.1.4** How do you see all environment variables inside a running container?

### L2 — Applied

**Q5.2.1** Your app needs 10 environment variables. How do you manage them without typing them all in the command line?

**Q5.2.2** You need different configs for dev, staging, and prod. How do you structure your env files?

**Q5.2.3** A container needs to read an API key. What are three ways to provide it (from least to most secure)?

**Q5.2.4** What's the risk of committing `.env` files to Git?

### L3 — Troubleshooting

**Q5.3.1** An app works with `docker run --env-file .env` but the same file doesn't work in docker-compose. Why?

**Q5.3.2** You set `ENV DB_URL=...` in the Dockerfile but the container still uses the wrong value. What's overriding it?

---

## 6. Resource Management & Health

### L1 — Foundations

**Q6.1.1** What does `docker stats` show you?

**Q6.1.2** How do you limit a container's memory? CPU?

**Q6.1.3** What's a health check? Why do you need it?

**Q6.1.4** What are restart policies? Name all four.

### L2 — Applied

**Q6.2.1** A container keeps crashing and restarting in a loop. How do you stop it from auto-restarting so you can debug?

**Q6.2.2** How do you ensure a database container always restarts after a server reboot?

**Q6.2.3** A container is consuming 8GB RAM and slowing down the server. How do you limit it to 2GB?

**Q6.2.4** Explain the difference between `--restart=always` and `--restart=unless-stopped`.

### L3 — Troubleshooting

**Q6.3.1** A container shows as "healthy" but the app inside isn't responding. How is that possible?

**Q6.3.2** You set a memory limit but the container was killed anyway. How do you find out why?

**Q6.3.3** A container restarts every 30 seconds. Logs show nothing useful. How do you diagnose?

---

## 7. Docker Compose

### L1 — Foundations

**Q7.1.1** What problem does docker-compose solve?

**Q7.1.2** What's the difference between `docker-compose up` and `docker-compose up -d`?

**Q7.1.3** How do you view logs for all services? For just one service?

**Q7.1.4** What does `docker-compose down -v` do that `docker-compose down` doesn't?

### L2 — Applied

**Q7.2.1** You have a web app, a database, and a cache. Write a basic `docker-compose.yml` structure (don't need full syntax — just the services).

**Q7.2.2** How do you ensure the web app doesn't start until the database is ready?

**Q7.2.3** A service in docker-compose needs to rebuild after code changes. What command do you run?

**Q7.2.4** Explain the difference between `build` and `image` in a docker-compose service definition.

### L3 — Troubleshooting

**Q7.3.1** `docker-compose up` fails with "network not found". What happened?

**Q7.3.2** One service in your compose file won't start. How do you run just that service to debug?

**Q7.3.3** Services can't communicate even though they're in the same docker-compose file. What do you check?

---

## 8. Security & Best Practices

### L1 — Foundations

**Q8.1.1** Why is running containers as root a security risk?

**Q8.1.2** What's a multi-stage build and how does it improve security?

**Q8.1.3** Why should you never put secrets in a Dockerfile?

**Q8.1.4** What's the difference between `ubuntu:24.04`, `ubuntu:24.04-slim`, and `alpine`?

### L2 — Applied

**Q8.2.1** How do you run a container as a non-root user?

**Q8.2.2** Your image is based on `node:latest`. A security scan shows 47 vulnerabilities. What do you do?

**Q8.2.3** A Dockerfile has `RUN apt-get update && apt-get install -y curl vim nano htop`. What's wrong with this from a security perspective?

**Q8.2.4** How would you scan an image for vulnerabilities before deploying?

### L3 — Troubleshooting

**Q8.3.1** A container needs to bind to port 80 but can't because it's not running as root. How do you fix this securely?

**Q8.3.2** You switched to a non-root user but now the app can't write to `/app/logs`. How do you fix permissions in the Dockerfile?

---

## Progress Tracking

Mark questions you can confidently answer in an interview with ✅.
Mark questions you need to review with 🔄.
Mark questions you can't answer at all with ❌.

**Goal:** All ✅ before interviews.

#!/bin/bash
set -euo pipefail

# ════════════════════════════════════════════════════════════════
# Docker Quick Warmup — 5-Minute Command Practice
# ════════════════════════════════════════════════════════════════
# Don't think. Just type. Build muscle memory.

clear
cat << "EOF"
╔═══════════════════════════════════════════════════════════╗
║         DOCKER QUICK WARMUP — 5 MINUTES                 ║
╚═══════════════════════════════════════════════════════════╝

Commands you should be able to type without thinking.
This isn't about understanding — it's about speed and recall.

Ready? Let's go. ⚡
EOF

echo ""
read -p "Press Enter to start..."

# ────────────────────────────────────────────────────────────
# Round 1: Basic Container Lifecycle
# ────────────────────────────────────────────────────────────
clear
cat << "EOF"
╭─────────────────────────────────────────────────────────╮
│ ROUND 1: Container Basics (30 seconds)                  │
╰─────────────────────────────────────────────────────────╯

Type these commands (don't run them — just practice typing):

1. Pull nginx version 1.28-alpine
2. Run nginx detached, name it "web", map port 8080 to 80
3. List all running containers
4. List all containers including stopped ones
5. Stop the web container
6. Remove the web container
7. Remove all stopped containers

EOF

read -p "Type them, then press Enter..."

# ────────────────────────────────────────────────────────────
# Round 2: Logs & Inspection
# ────────────────────────────────────────────────────────────
clear
cat << "EOF"
╭─────────────────────────────────────────────────────────╮
│ ROUND 2: Logs & Debugging (30 seconds)                  │
╰─────────────────────────────────────────────────────────╯

1. Follow logs of a container named "api" in real-time
2. Show last 50 lines of logs from "api"
3. Get a shell inside a running container named "db"
4. Execute "whoami" inside the "api" container
5. Show live resource stats for all containers
6. Inspect the "web" container and view its network settings

EOF

read -p "Type them, then press Enter..."

# ────────────────────────────────────────────────────────────
# Round 3: Images
# ────────────────────────────────────────────────────────────
clear
cat << "EOF"
╭─────────────────────────────────────────────────────────╮
│ ROUND 3: Images (30 seconds)                            │
╰─────────────────────────────────────────────────────────╯

1. List all images on your system
2. Build an image from Dockerfile in current dir, tag it "myapp:1.0.0"
3. Build with no cache
4. Remove an image named "oldapp:0.5"
5. Remove all unused images
6. Show the layer history of "myapp:1.0.0"

EOF

read -p "Type them, then press Enter..."

# ────────────────────────────────────────────────────────────
# Round 4: Volumes & Networks
# ────────────────────────────────────────────────────────────
clear
cat << "EOF"
╭─────────────────────────────────────────────────────────╮
│ ROUND 4: Volumes & Networks (30 seconds)                │
╰─────────────────────────────────────────────────────────╯

1. Create a named volume called "dbdata"
2. Run postgres with the "dbdata" volume mounted to /var/lib/postgresql/data
3. List all volumes
4. Remove the "dbdata" volume
5. Remove all unused volumes
6. Run a container with current directory bind-mounted to /app

EOF

read -p "Type them, then press Enter..."

# ────────────────────────────────────────────────────────────
# Round 5: Environment & Cleanup
# ────────────────────────────────────────────────────────────
clear
cat << "EOF"
╭─────────────────────────────────────────────────────────╮
│ ROUND 5: Config & Cleanup (30 seconds)                  │
╰─────────────────────────────────────────────────────────╯

1. Run postgres with environment variable POSTGRES_PASSWORD=secret
2. Run a container using an env file called "db.env"
3. Run nginx with restart policy "always"
4. Update restart policy of "web" to "unless-stopped"
5. Show disk usage for containers, images, and volumes
6. NUCLEAR: Remove all stopped containers, networks, images, and volumes

EOF

read -p "Type them, then press Enter..."

# ────────────────────────────────────────────────────────────
# Round 6: Docker Compose
# ────────────────────────────────────────────────────────────
clear
cat << "EOF"
╭─────────────────────────────────────────────────────────╮
│ ROUND 6: Docker Compose (30 seconds)                    │
╰─────────────────────────────────────────────────────────╯

1. Start all services in detached mode
2. View logs for all services, following in real-time
3. Show logs for just the "web" service
4. Stop all services
5. Stop all services and remove volumes
6. Rebuild all services and start them
7. Run a command in the "db" service

EOF

read -p "Type them, then press Enter..."

# ────────────────────────────────────────────────────────────
# Answer Key
# ────────────────────────────────────────────────────────────
clear
cat << "EOF"
╔═══════════════════════════════════════════════════════════╗
║                     ANSWER KEY                           ║
╚═══════════════════════════════════════════════════════════╝

ROUND 1: Container Basics
─────────────────────────
1. docker pull nginx:1.28-alpine
2. docker run -d --name web -p 8080:80 nginx
3. docker ps
4. docker ps -a
5. docker stop web
6. docker rm web
7. docker container prune

ROUND 2: Logs & Debugging
─────────────────────────
1. docker logs -f api
2. docker logs --tail 50 api
3. docker exec -it db bash
4. docker exec api whoami
5. docker stats
6. docker inspect web -f '{{.NetworkSettings}}'

ROUND 3: Images
─────────────────────────
1. docker images
2. docker build -t myapp:1.0.0 .
3. docker build --no-cache -t myapp:1.0.0 .
4. docker rmi oldapp:0.5
5. docker image prune
6. docker history myapp:1.0.0

ROUND 4: Volumes & Networks
─────────────────────────
1. docker volume create dbdata
2. docker run -d --name db -v dbdata:/var/lib/postgresql/data postgres
3. docker volume ls
4. docker volume rm dbdata
5. docker volume prune
6. docker run -it -v $(pwd):/app ubuntu bash

ROUND 5: Config & Cleanup
─────────────────────────
1. docker run -d -e POSTGRES_PASSWORD=secret postgres
2. docker run --env-file db.env postgres
3. docker run -d --restart=always nginx
4. docker update --restart=unless-stopped web
5. docker system df
6. docker system prune -a

ROUND 6: Docker Compose
─────────────────────────
1. docker compose up -d
2. docker compose logs -f
3. docker compose logs -f web
4. docker compose down
5. docker compose down -v
6. docker compose up -d --build
7. docker compose exec db psql

EOF

echo ""
echo "💪 Warmup complete! How did you do?"
echo ""
echo "Can't remember a command? That's what this warmup is for."
echo "Run it daily. Speed comes from repetition."

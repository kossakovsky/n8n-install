#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if docker compose version >/dev/null 2>&1; then
    DC=(docker compose)
elif command -v docker-compose >/dev/null 2>&1; then
    DC=(docker-compose)
else
    echo "Docker Compose is not installed. Install Docker Compose plugin or docker-compose." >&2
    exit 1
fi

if [[ ! -f .env ]]; then
    cp .env.example .env
    echo "Created .env from .env.example"
    echo "Fill .env with production values and run this script again."
    exit 0
fi

echo "Validating docker compose config..."
"${DC[@]}" config >/dev/null

echo "Pulling images..."
"${DC[@]}" pull

echo "Starting services..."
"${DC[@]}" up -d

echo "Done. Check status with: docker compose ps"

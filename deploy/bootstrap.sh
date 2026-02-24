#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if [[ ! -f .env ]]; then
    cp .env.example .env
    echo "Created .env from .env.example"
    echo "Fill .env with production values and run this script again."
    exit 0
fi

echo "Validating docker compose config..."
docker compose config >/dev/null

echo "Pulling images..."
docker compose pull

echo "Starting services..."
docker compose up -d

echo "Done. Check status with: docker compose ps"

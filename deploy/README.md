# Deploy Guide (Bot Zavod Infra)

This repository is the infrastructure/deployment repo.
Main production cycle:

```bash
git pull
docker compose pull
docker compose up -d
```

## 1. First start on server

```bash
git clone git@github.com:sanya8923/bot-zavod-infra.git
cd bot-zavod-infra
cp .env.example .env
```

Fill `.env` with production values, then run:

```bash
docker compose config
docker compose up -d
```

## 2. Future services (disabled by default)

Profiles are prepared but not enabled by default:
- `future-changedetection`
- `future-mtproto`

Validation commands:

```bash
docker compose --profile future-changedetection config
docker compose --profile future-mtproto config
```

Enable profile by adding it into `COMPOSE_PROFILES` in `.env`.

## 3. Quick checks

```bash
docker compose ps
docker compose logs -f --tail=200
```

Healthcheck placeholders for future services:
- Changedetection: check web UI HTTP response on `/` (after profile enable)
- MTProto Bridge: check container is `Up` and bridge endpoint returns 200 (after replacing stub image)

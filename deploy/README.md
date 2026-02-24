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
- `profy-storage` (separate MinIO for Profy images)
- `future-changedetection`
- `future-mtproto`

Validation commands:

```bash
docker compose --profile profy-storage config
docker compose --profile future-changedetection config
docker compose --profile future-mtproto config
```

Enable profile by adding it into `COMPOSE_PROFILES` in `.env`.

For `profy-storage`, fill these variables in `.env`:
- `MINIO_ENDPOINT` (default: `http://minio-profy:9000`)
- `MINIO_ACCESS_KEY`
- `MINIO_SECRET_KEY`
- `MINIO_BUCKET` (default: `profy-images`)
- `MINIO_PUBLIC_URL` (for example `https://storage.yourdomain.com/profy-images`)
- `STORAGE_HOSTNAME` (for example `storage.yourdomain.com`)

## 3. Quick checks

```bash
docker compose ps
docker compose logs -f --tail=200
```

Healthcheck placeholders for future services:
- Changedetection: check web UI HTTP response on `/` (after profile enable)
- MTProto Bridge: check container is `Up` and bridge endpoint returns 200 (after replacing stub image)

#!/usr/bin/env bash
# Arranca TODO: bases de datos (Docker) + backend + frontend.
set -e
cd "$(dirname "$0")"

echo "▶ Levantando PostgreSQL y Redis (Docker)..."
docker compose up -d --wait

[ -d backend/node_modules ]  || { echo "▶ Instalando backend...";  (cd backend && npm install); }
[ -d frontend/node_modules ] || { echo "▶ Instalando frontend..."; (cd frontend && npm install); }

(cd backend && npm run dev) & BACK=$!
(cd frontend && npm run dev) & FRONT=$!
trap 'kill $BACK $FRONT 2>/dev/null' EXIT INT TERM

echo ""
echo "✅ Listo → abre http://localhost:3000   (Ctrl+C para detener)"
wait

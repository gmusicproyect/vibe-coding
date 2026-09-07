#!/usr/bin/env bash
# serve-dashboard.sh — Levanta servidor local para el Project Kanban Dashboard
set -euo pipefail

PORT=${1:-8000}
URL="http://localhost:$PORT/dashboard.html"

echo ""
echo "  ┌─────────────────────────────────────────────────────────┐"
echo "  │  Project Kanban Dashboard — Servidor Local              │"
echo "  │  URL: $URL                             │"
echo "  └─────────────────────────────────────────────────────────┘"
echo ""

# Intentar abrir el navegador automáticamente según el sistema
if command -v open >/dev/null 2>&1; then
  # macOS
  (sleep 1 && open "$URL") &
elif command -v xdg-open >/dev/null 2>&1; then
  # Linux
  (sleep 1 && xdg-open "$URL") &
fi

python3 -m http.server "$PORT"

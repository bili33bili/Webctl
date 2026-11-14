#!/usr/bin/env bash
# Contoh plugin webctl: cek beberapa port localhost sekaligus
# Pasang:   webctl plugin install plugins/example-portcheck.sh
# Jalankan: webctl plugin run example-portcheck 8000 8080 3000
set -euo pipefail

if [ $# -eq 0 ]; then
  echo "Pakai: webctl plugin run example-portcheck <port1> [port2] ..."
  exit 1
fi

for p in "$@"; do
  if command -v curl >/dev/null 2>&1; then
    code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 1 "http://127.0.0.1:$p/" || echo "000")
    echo "port $p -> HTTP $code"
  fi
done

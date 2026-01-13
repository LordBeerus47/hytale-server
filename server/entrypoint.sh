#!/usr/bin/env bash
set -e

cd /hytale-data

ZIP=$(ls *.zip 2>/dev/null || true)
SERVER_BIN=$(find . -type f -name "hytale-server*" -perm -111 | head -n 1)

if [ -z "$SERVER_BIN" ]; then
  echo "==> No server binary found, running downloader"
  /opt/hytale/hytale-downloader-linux-amd64

  ZIP=$(ls *.zip | head -n 1)
  if [ -z "$ZIP" ]; then
    echo "ERROR: Download completed but no zip found"
    exit 1
  fi

  echo "==> Extracting $ZIP"
  unzip "$ZIP"
  # Ensure server binary is executable
  chmod +x hytale-server*
fi

SERVER_BIN=$(find . -type f -name "hytale-server*" -perm -111 | head -n 1)

if [ -z "$SERVER_BIN" ]; then
  echo "ERROR: Server binary still not found after extraction"
  exit 1
fi

echo "==> Starting Hytale server"
exec "$SERVER_BIN"
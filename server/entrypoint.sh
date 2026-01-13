#!/usr/bin/env bash
set -e

cd /hytale-server/server

echo "==> Starting Hytale server..."
exec ./hytale-server-linux

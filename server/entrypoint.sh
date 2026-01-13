#!/usr/bin/env bash
set -e

cd /hytale-data

echo "==> Launching Hytale server from patchline archive..."
# The .zip file is a proprietary Hytale format, not a standard ZIP
# Use the Hytale downloader to extract and run the server
exec /opt/hytale/hytale-downloader-linux-amd64 run --patchline "2026.01.13-50e69c385.zip"

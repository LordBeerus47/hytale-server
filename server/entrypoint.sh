#!/usr/bin/env bash
set -e

cd /hytale-data

# Check if server files already exist
if [ ! -d "Server" ] || [ ! -f "Assets.zip" ]; then
    # Download game.zip if it doesn't exist
    if [ ! -f "game.zip" ]; then
        echo "==> Downloading Hytale server files..."
        echo "==> This will require authentication on first run"
        /opt/hytale/hytale-downloader-linux-amd64 -download-path game.zip
    fi
    
    echo "==> Extracting server files from game.zip..."
    unzip -q game.zip
    echo "==> Server files extracted successfully"
fi

# Verify HytaleServer.jar exists
if [ ! -f "Server/HytaleServer.jar" ]; then
    echo "ERROR: Server/HytaleServer.jar not found"
    exit 1
fi

echo "==> Starting Hytale server..."
echo "==> Server will be available on UDP port 5520"
echo "==> After first launch, authenticate with: /auth login device"

# Run the server with assets
cd Server
exec java -jar HytaleServer.jar --assets ../Assets.zip --bind 0.0.0.0:5520

#!/usr/bin/env bash
set -e

cd /hytale-data

# Check if server files already exist
if [ ! -d "Server" ] || [ ! -f "Assets.zip" ]; then
    echo "==> Extracting server files from game.zip..."
    if [ -f "game.zip" ]; then
        unzip -q game.zip
        echo "==> Server files extracted successfully"
    else
        echo "ERROR: game.zip not found. Please ensure the download completed."
        echo "You can download it manually using:"
        echo "  docker exec -it hytale-server /opt/hytale/hytale-downloader-linux-amd64"
        exit 1
    fi
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

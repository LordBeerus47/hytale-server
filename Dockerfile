FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /hytale

# Dependencies required by the Hytale server
RUN apt-get update && \
    apt-get install -y \
        curl \
        ca-certificates \
        libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# Download the Hytale server launcher (NOT a zip)
RUN curl -L -o hytale-server https://launcher.hytale.com/server/latest/linux && \
    chmod +x hytale-server

# Expose default ports
EXPOSE 25565/tcp
EXPOSE 25565/udp

# Start server (it will download the real server on first run)
CMD ["./hytale-server"]

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        curl \
        ca-certificates \
        libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# Install launcher in a non-mounted path
WORKDIR /opt/hytale
RUN curl -L -o hytale-server https://launcher.hytale.com/server/latest/linux && \
    chmod +x hytale-server

# Persistent data directory
WORKDIR /hytale-data

EXPOSE 25565/tcp
EXPOSE 25565/udp

CMD ["/opt/hytale/hytale-server"]

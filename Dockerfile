FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install runtime deps
RUN apt-get update && \
    apt-get install -y \
        curl \
        unzip \
        ca-certificates \
        libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# Install downloader
WORKDIR /opt/hytale
RUN curl -fL -o hytale-downloader.zip https://downloader.hytale.com/hytale-downloader.zip \
 && unzip hytale-downloader.zip \
 && chmod +x hytale-downloader-linux-amd64 \
 && rm hytale-downloader.zip

# Persistent server data
WORKDIR /hytale-data

EXPOSE 25565/tcp
EXPOSE 25565/udp

CMD ["/opt/hytale/hytale-downloader-linux-amd64"]

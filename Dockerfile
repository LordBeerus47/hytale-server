FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install runtime deps
RUN apt-get update && \
    apt-get install -y \
        curl \
        unzip \
        ca-certificates \
        libstdc++6 \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Install Java 25 from Adoptium
RUN mkdir -p /opt/java && \
    cd /opt/java && \
    wget -qO- https://github.com/adoptium/temurin25-binaries/releases/download/jdk-25.0.1%2B8/OpenJDK25U-jdk_x64_linux_hotspot_25.0.1_8.tar.gz | tar xzf - --strip-components=1 && \
    update-alternatives --install /usr/bin/java java /opt/java/bin/java 1 && \
    update-alternatives --set java /opt/java/bin/java

# Install downloader
WORKDIR /opt/hytale
RUN curl -fL -o hytale-downloader.zip https://downloader.hytale.com/hytale-downloader.zip \
 && unzip hytale-downloader.zip \
 && chmod +x hytale-downloader-linux-amd64 \
 && rm hytale-downloader.zip

# Copy entrypoint script into image
COPY server/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Persistent server data
WORKDIR /hytale-data

# Hytale uses QUIC over UDP on port 5520
EXPOSE 5520/udp

ENTRYPOINT ["/entrypoint.sh"]

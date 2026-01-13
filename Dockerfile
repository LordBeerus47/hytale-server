FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /hytale

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        curl \
        unzip \
        ca-certificates \
        libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# Download Hytale server
# ⚠️ Replace URL if it changes
RUN curl -L -o hytale-server.zip https://launcher.hytale.com/server/latest/linux && \
    unzip hytale-server.zip && \
    rm hytale-server.zip

# Make server executable
RUN chmod +x start.sh

# Expose default ports (adjust if needed)
EXPOSE 25565/udp
EXPOSE 25565/tcp

# Start server
CMD ["./start.sh"]

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        curl \
        ca-certificates \
        libstdc++6 \
        bash \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/hytale
RUN curl -L -o hytale-server https://launcher.hytale.com/server/latest/linux && \
    chmod +x hytale-server

WORKDIR /hytale-data

EXPOSE 25565/tcp
EXPOSE 25565/udp

CMD ["bash", "/opt/hytale/hytale-server"]

ARG JITSI_REPO=jitsi
ARG BASE_TAG=latest
FROM debian:bookworm-slim

LABEL org.opencontainers.image.title="Jitsi Meet"
LABEL org.opencontainers.image.description="Base image for Jitsi Meet"
LABEL org.opencontainers.image.url="https://jitsi.org"
LABEL org.opencontainers.image.source="https://github.com/jitsi/docker-jitsi-meet"
LABEL org.opencontainers.image.version=$BASE_TAG
LABEL org.opencontainers.image.licenses="Apache-2.0"

ARG JITSI_RELEASE=unstable

RUN set -xe; \
    dpkgArch="$(dpkg --print-architecture)"; \
    case "${dpkgArch##*-}" in \
        "amd64") TPL_ARCH=amd64; S6_ARCH=amd64 ;; \
        "arm64") TPL_ARCH=arm64; S6_ARCH=aarch64 ;; \
        *) echo "unsupported architecture"; exit 1 ;; \
    esac; \
    apt-get update; \
    apt-get install -y apt-transport-https apt-utils ca-certificates gnupg wget curl; \
    wget -qO /usr/bin/tpl https://github.com/jitsi/tpl/releases/download/v1.4.0/tpl-linux-${TPL_ARCH}; \
    chmod +x /usr/bin/tpl; \
    wget -qO /tmp/s6.tar.gz https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-${S6_ARCH}.tar.gz; \
    mkdir /tmp/s6; \
    tar xfz /tmp/s6.tar.gz -C /tmp/s6; \
    tar hxfz /tmp/s6.tar.gz -C /; \
    rm -f /usr/bin/execlineb; \
    cp /tmp/s6/bin/execlineb /usr/bin/; \
    rm -rf /tmp/s6*; \
    wget -qO - https://download.jitsi.org/jitsi-key.gpg.key | gpg --dearmor > /etc/apt/trusted.gpg.d/jitsi.gpg; \
    echo "deb https://download.jitsi.org $JITSI_RELEASE/" > /etc/apt/sources.list.d/jitsi.list; \
    echo "deb http://ftp.debian.org/debian bookworm-backports main" > /etc/apt/sources.list.d/backports.list; \
    apt-get update; \
    apt-get dist-upgrade -y; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

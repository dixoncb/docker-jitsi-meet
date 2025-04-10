FROM illustra/base:my-custom

LABEL org.opencontainers.image.title="Jitsi Conference Focus (jicofo)"
LABEL org.opencontainers.image.description="Server-side focus component that manages media sessions and acts as load balancer."
LABEL org.opencontainers.image.url="https://github.com/jitsi/jicofo"
LABEL org.opencontainers.image.source="https://github.com/jitsi/docker-jitsi-meet"
LABEL org.opencontainers.image.documentation="https://jitsi.github.io/handbook/"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        jicofo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY rootfs/ /

VOLUME /config

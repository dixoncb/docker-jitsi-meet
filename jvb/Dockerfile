FROM illustra/base:my-custom

LABEL org.opencontainers.image.title="Jitsi Videobridge (jvb)"
LABEL org.opencontainers.image.description="WebRTC compatible server designed to route video streams amongst participants in a conference."
LABEL org.opencontainers.image.url="https://jitsi.org/jitsi-videobridge/"
LABEL org.opencontainers.image.source="https://github.com/jitsi/docker-jitsi-meet"
LABEL org.opencontainers.image.documentation="https://jitsi.github.io/handbook/"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        jitsi-videobridge2 \
        jitsi-autoscaler-sidecar \
        jq \
        curl \
        iproute2 \
        dnsutils \
        libpcap0.8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY rootfs/ /

VOLUME /config

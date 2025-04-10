FROM debian:bookworm-slim

# Ensure directories exist and install base packages
RUN mkdir -p /usr/share/man/man1 && \
    mkdir -p /etc/apt/keyrings/ && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        unzip \
        ca-certificates \
        curl \
        gnupg && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        nodejs \
        openjdk-17-jre-headless \
        openjdk-17-jdk-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

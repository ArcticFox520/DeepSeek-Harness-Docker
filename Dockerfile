FROM node:24

LABEL org.opencontainers.image.title="DeepSeek Harness"
LABEL org.opencontainers.image.description="DeepSeek Harness (dsh) with socat reverse proxy"
LABEL org.opencontainers.image.source="https://github.com/deepseek-ai/deepseek-harness"

RUN apt-get update && apt-get install -y --no-install-recommends socat \
    && rm -rf /var/lib/apt/lists/*

ARG DSH_VERSION=latest
RUN npm install -g @deepseek-ai/dsh@${DSH_VERSION}

EXPOSE 8080

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

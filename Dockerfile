FROM node:24

LABEL org.opencontainers.image.title="DeepSeek Harness"
LABEL org.opencontainers.image.description="DeepSeek Harness (dsh) - AI Agent execution framework"
LABEL org.opencontainers.image.source="https://github.com/deepseek-ai/deepseek-harness"

ARG DSH_VERSION=latest
RUN npm install -g @deepseek-ai/dsh@${DSH_VERSION}

EXPOSE 3080

ENTRYPOINT ["dsh"]
CMD ["web", "--host", "0.0.0.0", "--port", "3080"]

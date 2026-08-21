FROM node:22.6.0-bookworm

ENV DEBIAN_FRONTEND=noninteractive \
    PUPPETEER_SKIP_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       chromium \
       fonts-liberation \
       fonts-noto-cjk \
       git \
       tini \
    && rm -rf /var/lib/apt/lists/* \
    && corepack enable \
    && corepack prepare pnpm@9.7.1 --activate

WORKDIR /app
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["node", "app.js"]

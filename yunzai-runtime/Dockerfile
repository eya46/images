FROM node:22.6.0-bookworm

ENV DEBIAN_FRONTEND=noninteractive \
    PUPPETEER_SKIP_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium \
    UV_PYTHON=3.13 \
    UV_PYTHON_INSTALL_DIR=/opt/uv/python \
    UV_PYTHON_BIN_DIR=/usr/local/bin \
    UV_PYTHON_PREFERENCE=only-managed \
    UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy

COPY --from=ghcr.io/astral-sh/uv:0.12.5 /uv /uvx /usr/local/bin/

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
    && corepack prepare pnpm@9.7.1 --activate \
    && uv python install 3.13 --default \
    && uv pip install --python 3.13 pip aiohttp \
    && pybin="$(dirname "$(uv python find 3.13)")" \
    && ln -sfn "$(uv python find 3.13)" /usr/local/bin/python \
    && ln -sfn "$(uv python find 3.13)" /usr/local/bin/python3 \
    && ln -sfn "$(uv python find 3.13)" /usr/local/bin/python3.13 \
    && ln -sfn "$pybin/pip" /usr/local/bin/pip \
    && ln -sfn "$pybin/pip3" /usr/local/bin/pip3 \
    && python3 -c "import aiohttp, sys; assert sys.version_info[:2] == (3, 13), sys.version"

WORKDIR /app
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["node", "app.js"]

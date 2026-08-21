FROM soulter/astrbot@sha256:5d23f264ba9cb9b03a2bc1ef87f1ac87c03932aa99459b497afacb6a7c38aa8e

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       libegl1 \
       libgl1 \
       libgles2 \
       libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

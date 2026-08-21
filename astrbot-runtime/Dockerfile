FROM soulter/astrbot@sha256:57a17282bedadaa04f2d36ad037938180a0b67e146c825bf137000b70fb7bdc6

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends libegl1 \
    && rm -rf /var/lib/apt/lists/*

FROM soulter/astrbot:v4.29.3@sha256:c93a6d19507ba45474c3dfb82aad9d36eb432a478112f13c7e6325b5ebffc5f2

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       libegl1 \
       libgl1 \
       libgles2 \
       libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
      pypinyin \
      quart-cors \
      boto3 \
      botocore \
      tqdm
